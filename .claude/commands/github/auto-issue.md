---
description: Automatically create GitHub issue with intelligent categorization and labels
---

# Auto-Create GitHub Issue

You are an intelligent GitHub issue creation assistant. Your task is to create a well-structured GitHub issue from user input.

## Process:

1. **Parse Input**: Understand the issue description provided by the user
2. **Categorize**: Determine the type (bug, feature, question, enhancement, documentation)
3. **Structure**: Create a properly formatted issue with:
   - Clear, descriptive title
   - Detailed body with sections (Description, Expected Behavior, Current Behavior, Steps to Reproduce, etc.)
   - Appropriate labels based on content
   - Component tags (if applicable: hooks, slash-commands, agents, mcp-servers, skills)

4. **Create Issue**: Use `gh issue create` with:
   - Structured title
   - Well-formatted body with markdown
   - Appropriate labels

## Issue Template Structure:

For **Bugs**:
```
## Description
[Clear description of the bug]

## Current Behavior
[What's happening now]

## Expected Behavior
[What should happen]

## Steps to Reproduce
1. Step 1
2. Step 2

## Environment
- Claude Code version:
- OS:
- Other relevant info:
```

For **Features**:
```
## Feature Description
[Clear description of the feature]

## Use Case
[Why is this feature needed]

## Proposed Solution
[How it might work]

## Alternatives Considered
[Other approaches]
```

For **Questions/Documentation**:
```
## Question
[The question being asked]

## Context
[Additional context or what was tried]

## Expected Information
[What would help answer this]
```

## Labels to Consider:
- **Type**: bug, enhancement, question, documentation
- **Component**: hooks, slash-commands, agents, mcp-servers, skills, memory-bank, automation
- **Priority**: priority:high, priority:medium, priority:low
- **Status**: needs-investigation, good-first-issue

## Usage:
After creating the issue, provide:
1. Issue URL
2. Issue number
3. Summary of what was created

## Example Command:
```bash
gh issue create \
  --title "Bug: Slash command fails with JSON error" \
  --body "$(cat <<'EOF'
## Description
The /custom-command fails when processing JSON files

## Steps to Reproduce
1. Run /custom-command
2. Error appears in console

## Environment
- Claude Code version: latest
- OS: macOS
EOF
)" \
  --label "bug,slash-commands,needs-investigation"
```

Now, create the GitHub issue based on the user's input.
