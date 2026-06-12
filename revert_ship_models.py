import re

with open('/home/dzmitry/.gemini/config/plugins/sdlc/scripts/skill/ship.js', 'r') as f:
    content = f.read()

content = content.replace("gemini-3.5-flash-medium", "gemini-3.5-flash")
content = content.replace("gemini-3.1-pro-high", "gemini-3.1-pro")

with open('/home/dzmitry/.gemini/config/plugins/sdlc/scripts/skill/ship.js', 'w') as f:
    f.write(content)
