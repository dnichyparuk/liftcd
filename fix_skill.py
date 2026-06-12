import re

with open('/home/dzmitry/.gemini/config/plugins/sdlc/skills/execute-plan-sdlc/SKILL.md', 'r') as f:
    content = f.read()

# Approach A: update the model assignment mappings
content = content.replace(
    "- **Trivial** → `gemini-3.5-flash`",
    "- **Trivial** → `gemini-3.5-flash-low`"
)
content = content.replace(
    "- **Standard** → `gemini-3.5-flash`",
    "- **Standard** → `gemini-3.5-flash-medium`"
)
content = content.replace(
    "- **Complex** → `gemini-3.1-pro`",
    "- **Complex** → `gemini-3.1-pro-high`"
)

# Replace table lines
content = content.replace("[Trivial → gemini-3.5-flash]", "[Trivial → gemini-3.5-flash-low]")
content = content.replace("1 gemini-3.5-flash agent", "1 gemini-3.5-flash-low agent")
content = content.replace("[Standard → gemini-3.5-flash]", "[Standard → gemini-3.5-flash-medium]")
content = content.replace("[Complex  → gemini-3.1-pro]", "[Complex  → gemini-3.1-pro-high]")

# Replace Quality Tiers strings
content = content.replace("N × gemini-3.5-flash, N × gemini-3.5-flash              — fast", "N × gemini-3.5-flash-low, N × gemini-3.5-flash-medium      — fast")
content = content.replace("N × gemini-3.5-flash, N × gemini-3.5-flash, N × gemini-3.1-pro", "N × gemini-3.5-flash-low, N × gemini-3.5-flash-medium, N × gemini-3.1-pro-high")
content = content.replace("N × gemini-3.5-flash, N × gemini-3.1-pro              — max", "N × gemini-3.5-flash-medium, N × gemini-3.1-pro-high       — max")

# Replace highest model line
content = content.replace(
    "- `model: <highest model among wave tasks>` — gemini-3.5-flash if all tasks are Trivial; gemini-3.5-flash if any Standard; gemini-3.1-pro if any Complex.",
    "- `model: <highest model among wave tasks>` — gemini-3.5-flash-low if all tasks are Trivial; gemini-3.5-flash-medium if any Standard; gemini-3.1-pro-high if any Complex."
)

with open('/home/dzmitry/.gemini/config/plugins/sdlc/skills/execute-plan-sdlc/SKILL.md', 'w') as f:
    f.write(content)
