# GitHub Automation for Claude Code 🚀

This document describes all the GitHub automation features that enhance Claude Code's capabilities and make it more autonomous.

## 📋 Table of Contents

- [Overview](#overview)
- [GitHub Actions Workflows](#github-actions-workflows)
- [Git Hooks](#git-hooks)
- [Slash Commands](#slash-commands)
- [Issue & PR Templates](#issue--pr-templates)
- [Setup Instructions](#setup-instructions)
- [Usage Guide](#usage-guide)

## 🎯 Overview

This repository includes comprehensive GitHub automation to make Claude Code more capable and autonomous:

- **7 Automated Workflows** - Continuous validation, monitoring, and maintenance
- **1 Git Hook** - Local validation before commits
- **4 GitHub CLI Slash Commands** - Intelligent GitHub operations
- **3 Issue Templates** - Structured issue creation
- **1 PR Template** - Standardized pull request format

### Key Benefits:

✅ **Automated Quality Control** - Validates configs, checks links, prevents errors
✅ **Intelligent Labeling** - Auto-categorizes issues and PRs
✅ **Self-Maintaining** - Updates documentation, manages stale items
✅ **Release Automation** - Creates releases with changelogs
✅ **Claude Code Integration** - Slash commands for GitHub operations

---

## 🔄 GitHub Actions Workflows

### 1. Configuration Validation (`validate-claude-config.yml`)

**Triggers:** Push to main/claude branches, Pull requests

**What it does:**
- Validates all JSON files (settings, MCP configs)
- Checks for required files (CLAUDE.md, .claude/settings.json)
- Validates markdown files and internal links
- Verifies slash command syntax
- Validates agent configuration files

**Status:** ✅ Always runs on push/PR

```bash
# Manually trigger
gh workflow run validate-claude-config.yml
```

### 2. Auto-Label Issues & PRs (`auto-label.yml`)

**Triggers:** Issues and PRs opened/edited

**What it does:**
- Analyzes issue/PR content and title
- Automatically adds relevant labels:
  - **Component labels**: hooks, slash-commands, agents, mcp-servers, skills, memory-bank
  - **Type labels**: bug, enhancement, documentation, question
  - **Priority labels**: priority:high (if urgent keywords found)
  - **Size labels**: size:XS/S/M/L/XL (for PRs based on changes)

**Example:**
```
Issue: "Bug in slash command /custom fails with error"
Auto-labels: bug, slash-commands, needs-investigation
```

### 3. Link Checker (`link-checker.yml`)

**Triggers:** Weekly schedule (Mondays 9 AM), Push to markdown files, Manual

**What it does:**
- Checks all external links in markdown files
- Retries failed links (handles temporary failures)
- Creates GitHub issue if broken links found
- Ignores localhost and placeholder links

**Monitoring:**
```bash
# View link check results
gh run list --workflow=link-checker.yml

# Manually trigger
gh workflow run link-checker.yml
```

### 4. Documentation Sync (`sync-docs.yml`)

**Triggers:** Daily schedule (2 AM), Manual

**What it does:**
- Monitors Claude Code official documentation
- Checks key docs URLs for updates
- Creates issue if documentation needs updating
- Lists affected documentation links

**Key URLs monitored:**
- https://docs.anthropic.com/en/docs/claude-code/overview
- https://docs.anthropic.com/en/docs/claude-code/settings
- https://docs.anthropic.com/en/docs/claude-code/hooks
- https://docs.anthropic.com/en/docs/claude-code/sub-agents
- https://docs.anthropic.com/en/docs/claude-code/skills

### 5. Stale Issue Management (`stale-issues.yml`)

**Triggers:** Daily schedule (1 AM)

**What it does:**
- Marks issues stale after 60 days of inactivity
- Closes stale issues after 7 additional days
- Marks PRs stale after 45 days
- Closes stale PRs after 14 additional days
- Exempts: pinned, security, priority:high, in-progress items

**Customization:** Edit `.github/workflows/stale-issues.yml` to adjust timeframes

### 6. Release Automation (`release-automation.yml`)

**Triggers:** Tag push (v*.*.*), Manual with version input

**What it does:**
- Generates changelog from commits since last release
- Categorizes changes: Features, Bug Fixes, Documentation, Maintenance
- Creates GitHub release with formatted notes
- Includes installation instructions

**Usage:**
```bash
# Create release
git tag v1.0.0
git push origin v1.0.0

# Or manually
gh workflow run release-automation.yml -f version=v1.0.0
```

### 7. Auto-Update README Stats (`auto-update-readme.yml`)

**Triggers:** Weekly schedule (Sundays 3 AM), Manual

**What it does:**
- Collects repository statistics
- Counts: slash commands, agents, hooks, workflows, commits, contributors
- Creates stats JSON file
- Opens PR with updated statistics

**Statistics tracked:**
- Slash commands count
- Agents count
- Hooks count
- Workflows count
- Total commits
- Contributors count
- Last update date

---

## 🪝 Git Hooks

### Pre-Commit Hook (`PRE_COMMIT.sh`)

**Location:** `.claude/hooks/PRE_COMMIT.sh`

**What it validates:**
- ✅ JSON files syntax (using jq)
- ✅ Markdown file issues (trailing whitespace, TODO markers)
- ✅ Slash command structure
- ✅ File sizes (warns about large files)
- ⚠️  Potential secrets (api-key, password, token patterns)

**Automatic execution:** Runs before each git commit

**Manual test:**
```bash
bash .claude/hooks/PRE_COMMIT.sh
```

---

## ⚡ GitHub CLI Slash Commands

### 1. `/github/auto-issue` - Intelligent Issue Creation

**Purpose:** Create well-structured GitHub issues with automatic categorization

**Features:**
- Parses user input intelligently
- Determines issue type (bug/feature/question)
- Formats with appropriate sections
- Adds relevant labels
- Uses gh CLI for creation

**Usage:**
```
Claude Code> /github/auto-issue

[Then describe your issue and Claude will create it]
```

**Example:**
```
User: "The memory bank sync agent fails when there are too many files"
Claude: Creates issue with:
  Title: "Bug: Memory bank sync agent fails with large file counts"
  Labels: bug, agents, needs-investigation
  Structured body with description, steps, environment
```

### 2. `/github/auto-pr-review` - Automated PR Review

**Purpose:** Intelligently review pull requests and provide structured feedback

**Features:**
- Fetches PR details and diff
- Analyzes code quality, documentation, testing
- Categorizes feedback (Critical/Suggestions/Positive)
- Checks Claude Code specific patterns
- Submits review via gh CLI

**Usage:**
```
Claude Code> /github/auto-pr-review 123

[Claude reviews PR #123 and provides structured feedback]
```

**Review includes:**
- 🔴 Critical issues (must fix)
- 🟡 Suggestions (should consider)
- 🟢 Positive observations
- ✅ Checklist status
- 📝 Recommendation (APPROVE/REQUEST CHANGES/COMMENT)

### 3. `/github/sync-fork` - Fork Synchronization

**Purpose:** Sync forked repository with upstream source

**Features:**
- Checks/adds upstream remote
- Fetches latest changes
- Handles merge or rebase
- Resolves conflicts with guidance
- Provides detailed summary

**Usage:**
```
Claude Code> /github/sync-fork

[Claude guides through sync process]
```

**Safety checks:**
- No uncommitted changes
- On correct branch
- Upstream configured
- Conflict handling

### 4. `/github/manage-labels` - Label Management

**Purpose:** Create and organize repository labels efficiently

**Features:**
- Lists current labels
- Recommends label structure
- Bulk creates labels
- Provides usage guide
- Includes label creation script

**Usage:**
```
Claude Code> /github/manage-labels

[Claude helps setup comprehensive label system]
```

**Label categories created:**
- Type: bug, enhancement, documentation, question
- Component: hooks, slash-commands, agents, mcp-servers, skills, memory-bank
- Priority: priority:high/medium/low
- Status: needs-investigation, in-progress, blocked
- Size: size:XS/S/M/L/XL

### 5. `/github/deploy-workflows` - Workflow Deployment

**Purpose:** Deploy and verify GitHub Actions workflows

**Features:**
- Validates workflow YAML files
- Tests workflows with manual triggers
- Checks required permissions
- Monitors workflow status
- Provides troubleshooting guide

**Usage:**
```
Claude Code> /github/deploy-workflows

[Claude deploys and tests all workflows]
```

---

## 📝 Issue & PR Templates

### Issue Templates (`.github/ISSUE_TEMPLATE/`)

#### 1. Bug Report (`bug_report.yml`)
Structured form for reporting bugs with:
- Component selection
- Description, expected/actual behavior
- Steps to reproduce
- Environment details
- Log output

#### 2. Feature Request (`feature_request.yml`)
Structured form for suggesting features with:
- Component selection
- Problem statement
- Proposed solution
- Alternatives considered
- Use case and examples
- Priority level

#### 3. Question (`question.yml`)
Structured form for asking questions with:
- Category selection
- Question and context
- What was already tried
- Additional information

### Pull Request Template (`PULL_REQUEST_TEMPLATE.md`)

Comprehensive PR template with:
- Description and type of change
- Component checkboxes
- List of changes made
- Related issues
- Testing details
- Screenshots/examples
- Review checklist

---

## 🚀 Setup Instructions

### Initial Setup

1. **Enable GitHub Actions:**
   - Go to repository Settings → Actions → General
   - Enable "Allow all actions and reusable workflows"
   - Enable "Read and write permissions" for GITHUB_TOKEN

2. **Configure Branch Protection (Optional but Recommended):**
   ```bash
   # Require PR reviews
   # Require status checks (validation workflow)
   # Require branches to be up to date
   ```

3. **Install GitHub CLI:**
   ```bash
   # macOS
   brew install gh

   # Linux
   curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
   echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
   sudo apt update
   sudo apt install gh
   ```

4. **Authenticate GitHub CLI:**
   ```bash
   gh auth login
   ```

### Testing Workflows

```bash
# Test validation workflow
git checkout -b test-workflows
echo "# Test" >> .claude/test.md
git add .
git commit -m "test: workflow validation"
git push -u origin test-workflows

# Check workflow status
gh run list --branch test-workflows

# Create test issue (tests auto-labeling)
gh issue create \
  --title "Test: Auto-label feature" \
  --body "Testing hooks and slash-commands labeling"

# Manually trigger workflows
gh workflow run validate-claude-config.yml
gh workflow run link-checker.yml
gh workflow run sync-docs.yml
```

### Monitoring

```bash
# List all workflows
gh workflow list

# View recent runs
gh run list --limit 20

# View specific workflow runs
gh run list --workflow=validate-claude-config.yml

# View run details
gh run view <run-id>

# Download logs
gh run download <run-id>
```

---

## 📖 Usage Guide

### For Daily Development

1. **Making Changes:**
   - Pre-commit hook automatically validates before each commit
   - Push to trigger validation workflow
   - Auto-labeling applies to any issues/PRs created

2. **Creating Issues:**
   - Use issue templates for consistency
   - Or use `/github/auto-issue` for intelligent creation
   - Labels are auto-applied based on content

3. **Creating PRs:**
   - PR template auto-loads when creating PR
   - Size label auto-added based on changes
   - Use `/github/auto-pr-review` for AI review before requesting human review

4. **Monitoring:**
   ```bash
   # Check workflow status
   gh run list

   # View failed runs
   gh run list --status failure

   # Check specific workflow
   gh workflow view validate-claude-config.yml
   ```

### For Maintenance

1. **Weekly:**
   - Review stale issue/PR labels
   - Check link-checker results
   - Review automated stats PR

2. **As Needed:**
   - Sync with upstream using `/github/sync-fork`
   - Manage labels using `/github/manage-labels`
   - Deploy new workflows using `/github/deploy-workflows`

3. **For Releases:**
   ```bash
   # Create release
   git tag v1.0.0 -a -m "Release version 1.0.0"
   git push origin v1.0.0

   # Workflow automatically creates release with changelog
   ```

### For Collaboration

1. **Issue Management:**
   - Issues auto-labeled by component and type
   - Stale issues auto-closed after 60+ days
   - Auto-created for broken links or doc updates

2. **PR Management:**
   - Size labels help prioritize reviews
   - Auto-labels by component
   - Template ensures consistency

3. **Documentation:**
   - Link checker prevents broken links
   - Doc sync alerts to Claude Code updates
   - Stats auto-updated weekly

---

## 🛠️ Troubleshooting

### Workflow Not Triggering

**Check:**
- GitHub Actions enabled in repository
- Workflow file syntax valid
- Trigger conditions met (branch, paths)
- GITHUB_TOKEN has required permissions

**Fix:**
```bash
# Manually trigger to test
gh workflow run <workflow-name>.yml
```

### Workflow Failing

**Debug:**
```bash
# View logs
gh run view <run-id> --log

# Check specific job
gh run view <run-id> --job <job-id>
```

### Pre-Commit Hook Not Running

**Check:**
- Hook file is executable: `chmod +x .claude/hooks/PRE_COMMIT.sh`
- Hook configured in `.claude/settings.json`
- No syntax errors in hook script

**Test manually:**
```bash
bash .claude/hooks/PRE_COMMIT.sh
```

### Labels Not Auto-Applying

**Check:**
- `auto-label.yml` workflow is enabled
- Workflow has `issues: write` and `pull-requests: write` permissions
- Keywords present in issue/PR title or body

**View workflow runs:**
```bash
gh run list --workflow=auto-label.yml
```

---

## 🎯 Advanced Usage

### Custom Workflow Triggers

Edit workflows to add custom triggers:

```yaml
on:
  push:
    branches: [ main, develop ]
    paths:
      - '**.md'
      - '.claude/**'
  schedule:
    - cron: '0 9 * * 1'  # Weekly on Mondays
  workflow_dispatch:  # Manual trigger
```

### Custom Labels

Use `/github/manage-labels` or:

```bash
gh label create "custom-label" \
  --description "Description" \
  --color "FF6347"
```

### Workflow Notifications

Configure notifications:
- GitHub: Settings → Notifications → Actions
- Slack: Add GitHub app to workspace
- Email: Configure in GitHub settings

---

## 📚 Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [GitHub CLI Documentation](https://cli.github.com/manual/)
- [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code/overview)
- [Workflow Syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)

---

## 🤝 Contributing

See `.github/PULL_REQUEST_TEMPLATE.md` for PR guidelines.

Use issue templates for bugs, features, or questions.

---

**Made with ❤️ for Claude Code automation**
