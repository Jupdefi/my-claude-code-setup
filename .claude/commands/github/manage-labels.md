---
description: Manage GitHub repository labels efficiently
---

# Manage GitHub Repository Labels

You are a GitHub repository label management assistant. Your task is to help create, update, or organize repository labels for better issue and PR management.

## Process:

1. **Analyze Current Labels**: List existing labels
2. **Recommend Structure**: Suggest label organization
3. **Create/Update**: Apply changes using gh CLI
4. **Document**: Provide label usage guide

## Label Organization Strategy:

### Category-based Labeling:

**Type Labels** (what kind of item):
- `bug` - Something isn't working (color: #d73a4a)
- `enhancement` - New feature or request (color: #a2eeef)
- `documentation` - Documentation improvements (color: #0075ca)
- `question` - Further information requested (color: #d876e3)

**Component Labels** (which part):
- `hooks` - Related to Claude Code hooks (color: #fbca04)
- `slash-commands` - Related to slash commands (color: #fbca04)
- `agents` - Related to subagents (color: #fbca04)
- `mcp-servers` - Related to MCP servers (color: #fbca04)
- `skills` - Related to Claude skills (color: #fbca04)
- `memory-bank` - Related to memory bank system (color: #fbca04)
- `automation` - Related to GitHub Actions/workflows (color: #1d76db)

**Priority Labels**:
- `priority:high` - High priority (color: #b60205)
- `priority:medium` - Medium priority (color: #ff9800)
- `priority:low` - Low priority (color: #4caf50)

**Status Labels**:
- `needs-investigation` - Requires analysis (color: #ededed)
- `in-progress` - Currently being worked on (color: #0e8a16)
- `blocked` - Blocked by other issues (color: #d93f0b)
- `good-first-issue` - Good for newcomers (color: #7057ff)

**Size Labels** (for PRs):
- `size:XS` - Extra small PR (color: #90EE90)
- `size:S` - Small PR (color: #98FB98)
- `size:M` - Medium PR (color: #FFD700)
- `size:L` - Large PR (color: #FFA500)
- `size:XL` - Extra large PR (color: #FF6347)

## Commands:

### List existing labels:
```bash
gh label list
```

### Create new label:
```bash
gh label create "label-name" --description "Description" --color "RRGGBB"
```

### Update existing label:
```bash
gh label edit "old-name" --name "new-name" --description "New description" --color "RRGGBB"
```

### Delete label:
```bash
gh label delete "label-name"
```

### Bulk create labels:
```bash
# Create multiple labels from script
gh label create "hooks" --description "Related to Claude Code hooks" --color "fbca04"
gh label create "slash-commands" --description "Related to slash commands" --color "fbca04"
gh label create "agents" --description "Related to subagents" --color "fbca04"
# ... etc
```

## Label Creation Script:

```bash
#!/bin/bash
# Create comprehensive label set for Claude Code repository

# Type labels
gh label create "bug" --description "Something isn't working" --color "d73a4a" --force
gh label create "enhancement" --description "New feature or request" --color "a2eeef" --force
gh label create "documentation" --description "Documentation improvements" --color "0075ca" --force
gh label create "question" --description "Further information requested" --color "d876e3" --force

# Component labels
gh label create "hooks" --description "Related to Claude Code hooks" --color "fbca04" --force
gh label create "slash-commands" --description "Related to slash commands" --color "fbca04" --force
gh label create "agents" --description "Related to subagents" --color "fbca04" --force
gh label create "mcp-servers" --description "Related to MCP servers" --color "fbca04" --force
gh label create "skills" --description "Related to Claude skills" --color "fbca04" --force
gh label create "memory-bank" --description "Related to memory bank system" --color "fbca04" --force
gh label create "automation" --description "Related to GitHub Actions/workflows" --color "1d76db" --force

# Priority labels
gh label create "priority:high" --description "High priority" --color "b60205" --force
gh label create "priority:medium" --description "Medium priority" --color "ff9800" --force
gh label create "priority:low" --description "Low priority" --color "4caf50" --force

# Status labels
gh label create "needs-investigation" --description "Requires analysis" --color "ededed" --force
gh label create "in-progress" --description "Currently being worked on" --color "0e8a16" --force
gh label create "blocked" --description "Blocked by other issues" --color "d93f0b" --force
gh label create "good-first-issue" --description "Good for newcomers" --color "7057ff" --force

# Size labels
gh label create "size:XS" --description "Extra small PR (< 10 changes)" --color "90EE90" --force
gh label create "size:S" --description "Small PR (10-49 changes)" --color "98FB98" --force
gh label create "size:M" --description "Medium PR (50-199 changes)" --color "FFD700" --force
gh label create "size:L" --description "Large PR (200-499 changes)" --color "FFA500" --force
gh label create "size:XL" --description "Extra large PR (500+ changes)" --color "FF6347" --force

# Automated label
gh label create "automated" --description "Created by automation" --color "1d76db" --force

echo "✅ All labels created successfully!"
```

## Usage Documentation:

After creating labels, provide a guide:

```markdown
# Label Usage Guide

## How to Use Labels

### When Creating Issues:
1. Add a **type** label (bug, enhancement, question, documentation)
2. Add **component** labels for affected areas
3. Add **priority** if urgent
4. Automation will add additional relevant labels

### When Creating PRs:
1. Size label will be auto-added based on changes
2. Add **component** labels for areas changed
3. Link related issues

### Label Combinations:
- `bug` + `hooks` + `priority:high` = Critical hook bug
- `enhancement` + `slash-commands` + `good-first-issue` = Easy feature to add
- `documentation` + `memory-bank` = Docs improvement needed

## Label Maintenance:
- Review labels monthly
- Archive unused labels
- Update descriptions as needed
```

Now, proceed with managing labels based on user's request.
