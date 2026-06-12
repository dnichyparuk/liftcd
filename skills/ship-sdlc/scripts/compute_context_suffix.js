'use strict';

const { execSync } = require('child_process');

function computeContextSuffix(cwd, targetRef = 'HEAD') {
  try {
    const out = execSync(`git diff --shortstat ${targetRef}`, { cwd, encoding: 'utf8', stdio: ['pipe', 'pipe', 'ignore'] });
    if (!out || !out.trim()) {
      return '-low';
    }

    const match = out.match(/(\d+)\s+file[s]?\s+changed(?:,\s+(\d+)\s+insertion[s]?(?:\(\+\))?)?(?:,\s+(\d+)\s+deletion[s]?(?:\(-\))?)?/);
    if (!match) {
      return '-low';
    }

    const files = parseInt(match[1] || '0', 10);
    const insertions = parseInt(match[2] || '0', 10);
    const deletions = parseInt(match[3] || '0', 10);
    const totalLines = insertions + deletions;

    if (totalLines > 2000 || files > 10) return '-high';
    if (totalLines > 500 || files > 3) return '-medium';
    return '-low';
  } catch (err) {
    return '-low';
  }
}

if (require.main === module) {
  const cwd = process.cwd();
  const targetRef = process.argv[2] || 'HEAD';
  const suffix = computeContextSuffix(cwd, targetRef);
  console.log(JSON.stringify({ suffix }));
}

module.exports = { computeContextSuffix };
