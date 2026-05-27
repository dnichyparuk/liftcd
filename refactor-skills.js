const fs = require('fs');
const path = require('path');

const targetDir = path.join(__dirname, 'skills');

const sdlcRootResolver = `for d in "antigravity" "plugins/sdlc" "plugins/sdlc-utilities" "$HOME/.gemini/config/plugins/sdlc" "$HOME/.claude/plugins/sdlc"; do [ -f "$d/plugin.json" ] && SDLC_ROOT="$d" && break; done
[ -z "$SDLC_ROOT" ] && { echo "ERROR: SDLC plugin root not found." >&2; exit 2; }`;

function processFile(filePath) {
    let content = fs.readFileSync(filePath, 'utf8');
    let modified = false;

    const blockRegex = /```bash\r?\n([\s\S]*?)```/g;
    
    content = content.replace(blockRegex, (match, blockContent) => {
        let blockModified = false;
        let newBlockContent = blockContent;

        // node -e with .map(d=>d+...)
        const mapMatches = [...newBlockContent.matchAll(/([A-Z_]+)=\$\(node -e ".*?\.map\(d=>d\+'([^']+)'\)\.find.*?"\)/g)];
        
        // node -e with path.join(d, ...)
        const joinMatches = [...newBlockContent.matchAll(/([A-Z_]+)=\$\(node -e ".*?(?:const|let|var) p=path\.join\(d,([^)]+)\).*?"\)/g)];

        const processNodeMatch = (varName, scriptPath) => {
            if (scriptPath.startsWith('/')) scriptPath = scriptPath.substring(1);
            
            const fullMatchRegex = new RegExp(`^[ \\t]*${varName}=\\$\\(node -e [^\\n]+\\)\\r?\\n[ \\t]*\\[ -z "\\$${varName}" \\] && \\{ echo "ERROR: Could not locate .*?".*? exit 2; \\}`, 'm');
            const replacement = `${varName}="$SDLC_ROOT/${scriptPath}"\n[ ! -f "$${varName}" ] && { echo "ERROR: Could not locate ${scriptPath}. Is the sdlc plugin installed?" >&2; exit 2; }`;
            
            if (newBlockContent.match(fullMatchRegex)) {
                newBlockContent = newBlockContent.replace(fullMatchRegex, replacement);
                blockModified = true;
            } else {
                const simpleMatchRegex = new RegExp(`^[ \\t]*${varName}=\\$\\(node -e [^\\n]+\\)`, 'm');
                if (newBlockContent.match(simpleMatchRegex)) {
                    newBlockContent = newBlockContent.replace(simpleMatchRegex, replacement);
                    blockModified = true;
                }
            }
        };

        for (const m of mapMatches) {
            processNodeMatch(m[1], m[2]);
        }

        for (const m of joinMatches) {
            // m[2] is something like "'scripts','skill','version.js'"
            let scriptPath = m[2].split(',').map(s => s.trim().replace(/^'|'$/g, '')).join('/');
            processNodeMatch(m[1], scriptPath);
        }

        const findMatches = [...newBlockContent.matchAll(/([A-Z_]+)=\$\(find .*? -path ".*?\*\/sdlc\*\/(.+?)".*?\)/g)];
        for (const m of findMatches) {
            const varName = m[1];
            let scriptPath = m[2];
            
            let suffix = '';
            if (m[0].includes('xargs dirname')) {
                scriptPath = scriptPath.substring(0, scriptPath.lastIndexOf('/'));
            }
            
            const fullMatchRegex = new RegExp(`^[ \\t]*${varName}=\\$\\(find .*?\\)\\r?\\n(?:\\[ -z "\\$${varName}" \\].*?\\r?\\n)*[ \\t]*\\[ -z "\\$${varName}" \\].*?exit 2; \\}`, 'm');
            const replacement = `${varName}="$SDLC_ROOT/${scriptPath}"\n[ ! -f "$${varName}" ] && { echo "ERROR: Could not locate ${scriptPath}. Is the sdlc plugin installed?" >&2; exit 2; }`;
            
            if (newBlockContent.match(fullMatchRegex)) {
                newBlockContent = newBlockContent.replace(fullMatchRegex, replacement);
                blockModified = true;
            } else {
                const simpleMatchRegex = new RegExp(`^[ \\t]*${varName}=\\$\\(find .*?\\)`, 'm');
                if (newBlockContent.match(simpleMatchRegex)) {
                    newBlockContent = newBlockContent.replace(simpleMatchRegex, replacement);
                    blockModified = true;
                }
            }
        }

        if (blockModified) {
            newBlockContent = sdlcRootResolver + '\n\n' + newBlockContent.trimStart();
            modified = true;
            return `\`\`\`bash\n${newBlockContent}\n\`\`\``;
        }

        return match;
    });

    if (modified) {
        fs.writeFileSync(filePath, content, 'utf8');
        console.log(`Updated ${filePath}`);
    }
}

function walkDir(dir) {
    const files = fs.readdirSync(dir);
    for (const file of files) {
        const fullPath = path.join(dir, file);
        if (fs.statSync(fullPath).isDirectory()) {
            walkDir(fullPath);
        } else if (fullPath.endsWith('.md')) {
            processFile(fullPath);
        }
    }
}

walkDir(targetDir);
console.log('Done.');
