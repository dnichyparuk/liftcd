import os
import glob

skills_dir = '/home/dzmitry/.gemini/config/plugins/sdlc/skills'
skill_files = glob.glob(os.path.join(skills_dir, '*', 'SKILL.md'))

for filepath in skill_files:
    with open(filepath, 'r') as f:
        lines = f.readlines()
    
    with open(filepath, 'w') as f:
        for line in lines:
            if not line.startswith('model: '):
                f.write(line)
