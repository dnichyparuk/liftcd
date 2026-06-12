import re

with open('/home/dzmitry/.gemini/config/plugins/sdlc/skills/execute-plan-sdlc/SKILL.md', 'r') as f:
    content = f.read()

content = content.replace("gemini-3.5-flash-low", "gemini-3.5-flash")
content = content.replace("gemini-3.5-flash-medium", "gemini-3.5-flash")
content = content.replace("gemini-3.1-pro-high", "gemini-3.1-pro")

with open('/home/dzmitry/.gemini/config/plugins/sdlc/skills/execute-plan-sdlc/SKILL.md', 'w') as f:
    f.write(content)
