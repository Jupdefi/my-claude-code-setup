---
name: github-agent
description: Autonomous GitHub operations agent for managing issues, PRs, releases, and repository health
---

# GitHub Agent Skill

This skill invokes the GitHub automation subagent to handle GitHub operations autonomously.

## When to Use

Use this skill when you need to:
- Create or manage GitHub issues
- Review or manage pull requests
- Sync forks with upstream
- Create releases and changelogs
- Manage repository labels
- Monitor repository health
- Automate GitHub workflows
- Perform batch GitHub operations

## How to Use

Simply invoke the agent with your GitHub operation request:

```
Use the github-agent to [describe what you need]
```

## Examples

### Issue Management
```
Use the github-agent to create an issue for the bug I just described
Use the github-agent to close all stale issues older than 60 days
Use the github-agent to list all open issues labeled "priority:high"
```

### Pull Request Operations
```
Use the github-agent to review PR #123
Use the github-agent to create a PR for my current branch
Use the github-agent to merge PR #42 if all checks pass
```

### Fork Management
```
Use the github-agent to sync my fork with upstream
Use the github-agent to check if upstream has new changes
```

### Release Management
```
Use the github-agent to create a release for v1.2.0
Use the github-agent to generate a changelog since last release
```

### Repository Health
```
Use the github-agent to perform a health check
Use the github-agent to check for broken links
Use the github-agent to list all failing workflows
```

### Label Management
```
Use the github-agent to set up the comprehensive label system
Use the github-agent to rename label "bug" to "defect"
```

### Workflow Operations
```
Use the github-agent to trigger the validation workflow
Use the github-agent to debug the failing release workflow
```

## Agent Capabilities

The GitHub agent can autonomously:
- ✅ Create intelligent issues with auto-labeling
- ✅ Review PRs with code quality analysis
- ✅ Manage issue/PR lifecycle
- ✅ Sync forks and branches
- ✅ Create releases with changelogs
- ✅ Manage labels and milestones
- ✅ Trigger and monitor workflows
- ✅ Perform repository health checks
- ✅ Handle batch operations
- ✅ Generate comprehensive reports

## GitHub CLI Required

This skill requires the GitHub CLI (`gh`) to be installed and authenticated:

```bash
# Install gh CLI
# macOS:
brew install gh

# Linux:
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh

# Authenticate
gh auth login
```

## Integration with Existing Tools

This skill integrates with:
- `/github/*` slash commands
- GitHub Actions workflows in `.github/workflows/`
- Issue and PR templates in `.github/ISSUE_TEMPLATE/`
- Pre-commit hook in `.claude/hooks/PRE_COMMIT.sh`

## Best Practices

1. **Be Specific** - Provide clear details about what you need
2. **Provide Context** - Include issue/PR numbers, branch names, etc.
3. **Review Actions** - The agent will ask for confirmation on destructive operations
4. **Check Reports** - Review the agent's summary after operations
5. **Use for Batch** - Great for operations on multiple issues/PRs

## Security

The agent:
- ✅ Respects repository permissions
- ✅ Asks for confirmation before destructive operations
- ✅ Never exposes secrets
- ✅ Validates all inputs
- ✅ Maintains audit trail

## Troubleshooting

If the agent encounters issues:
1. Check `gh auth status` - Ensure authentication
2. Verify repository permissions
3. Check GitHub API rate limits: `gh api rate_limit`
4. Review the agent's error report

## Related Documentation

- Agent Definition: `.claude/agents/github-automation.md`
- GitHub Automation Guide: `.github/GITHUB_AUTOMATION.md`
- Slash Commands: `.claude/commands/github/`
- Workflows: `.github/workflows/`

---

**Powered by Claude Code GitHub Automation Agent**
