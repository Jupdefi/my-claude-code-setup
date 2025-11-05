# GitHub Agent Quick Reference Guide 🤖

The GitHub automation agent is your autonomous assistant for managing all GitHub operations. This guide provides quick examples and common use cases.

## Quick Start

### Invoke the Agent

In Claude Code, use the Task tool to invoke the github-automation agent:

```
Use the github-automation agent to [describe your task]
```

Or use the skill shorthand:

```
Use github-agent to [describe your task]
```

---

## Common Operations

### 📝 Issue Management

#### Create an Issue
```
Use github-agent to create an issue:
"The slash command /custom-command fails when processing files with special characters"
```

**Agent will:**
- Analyze the description
- Determine it's a bug
- Create structured issue with:
  - Appropriate template
  - Auto-labels: `bug`, `slash-commands`, `needs-investigation`
  - Clear title and description
- Return issue URL and number

#### List Issues by Label
```
Use github-agent to list all open issues labeled "priority:high"
```

#### Close Stale Issues
```
Use github-agent to close all stale issues older than 60 days
```

#### Add Comment to Issue
```
Use github-agent to add a comment to issue #42:
"This has been fixed in the latest release"
```

---

### 🔀 Pull Request Operations

#### Review a PR
```
Use github-agent to review PR #123
```

**Agent will:**
- Fetch PR details and diff
- Analyze code quality
- Check Claude Code configurations
- Validate documentation
- Categorize feedback (Critical/Suggestions/Positive)
- Submit structured review with recommendation

#### Create a PR
```
Use github-agent to create a PR from my current branch to main
with title "Add GitHub automation agent"
```

#### List PRs Awaiting Review
```
Use github-agent to list all PRs that need review
```

#### Merge a PR
```
Use github-agent to merge PR #42 if all checks pass
```

**Agent asks for confirmation before merging**

---

### 🍴 Fork Management

#### Sync Fork with Upstream
```
Use github-agent to sync my fork with upstream
```

**Agent will:**
- Check if upstream remote exists
- Add it if needed (will ask for URL)
- Fetch latest changes
- Show what's new
- Merge or rebase (asks preference)
- Handle conflicts if needed
- Push to fork

#### Check for Upstream Updates
```
Use github-agent to check if upstream has new changes
```

---

### 📦 Release Management

#### Create a Release
```
Use github-agent to create release v1.2.0
```

**Agent will:**
- Get commits since last release
- Categorize changes (Features, Fixes, Docs, etc.)
- Generate formatted changelog
- Create GitHub release with notes
- Include installation instructions

#### Generate Changelog
```
Use github-agent to generate changelog from v1.1.0 to v1.2.0
```

#### List Recent Releases
```
Use github-agent to list the last 5 releases
```

---

### 🏷️ Label Management

#### Setup Label System
```
Use github-agent to set up the comprehensive label system
```

**Agent will:**
- Create all standard labels:
  - Type: bug, enhancement, documentation, question
  - Component: hooks, slash-commands, agents, mcp-servers, skills, memory-bank, automation
  - Priority: priority:high/medium/low
  - Status: needs-investigation, in-progress, blocked, good-first-issue
  - Size: size:XS/S/M/L/XL
  - Special: automated, stale

#### Create Custom Label
```
Use github-agent to create label "performance" with color "FF6347"
and description "Performance improvements"
```

#### Rename Label
```
Use github-agent to rename label "bug" to "defect"
```

---

### ⚙️ Workflow Operations

#### Trigger a Workflow
```
Use github-agent to trigger the validation workflow
```

#### Check Workflow Status
```
Use github-agent to check status of all workflows
```

#### Debug Failed Workflow
```
Use github-agent to debug the failing release workflow
```

**Agent will:**
- Get workflow run details
- Fetch logs
- Identify failing step
- Suggest fixes

#### List Recent Workflow Runs
```
Use github-agent to list the last 10 workflow runs
```

---

### 🏥 Repository Health

#### Perform Health Check
```
Use github-agent to perform a repository health check
```

**Agent will:**
- Count open/closed issues and PRs
- Check for stale items
- Validate configurations
- Check workflow status
- Scan for broken links
- Generate comprehensive report

#### Check for Broken Links
```
Use github-agent to check for broken links in documentation
```

#### List Failed Workflows
```
Use github-agent to list all workflows that failed in the last 7 days
```

---

## Advanced Operations

### Batch Issue Operations

```
Use github-agent to:
1. Label all issues containing "documentation" with "documentation" label
2. Close all issues labeled "wontfix"
3. Generate report of changes made
```

### Multi-Step PR Workflow

```
Use github-agent to:
1. Review PR #123
2. If approved, merge it
3. Create a release if it was a version bump
4. Post summary in Slack (if configured)
```

### Automated Maintenance

```
Use github-agent to:
1. Perform health check
2. Close stale issues
3. Update repository statistics
4. Generate weekly maintenance report
```

### Release Pipeline

```
Use github-agent to:
1. Check if all PRs are merged
2. Generate changelog
3. Create release v1.3.0
4. Update documentation
5. Post release announcement
```

---

## Integration Examples

### With Workflows

```
Use github-agent to:
1. Trigger validation workflow
2. Wait for completion
3. If failed, create issue with failure details
4. If passed, approve pending PR
```

### With Issue Templates

```
Use github-agent to create a bug report using the bug_report template
with the following details:
- Component: Hooks
- Description: PRE_COMMIT hook fails with JSON error
- Steps: [provide steps]
```

### With Slash Commands

The agent can leverage existing slash commands:

```
Use github-agent to:
1. Run /github/deploy-workflows to verify all workflows
2. Create issue if any failures found
3. Report summary
```

---

## Best Practices

### 1. Be Specific
❌ "Fix my issues"
✅ "Close all issues labeled 'wontfix' and add comment explaining why"

### 2. Provide Context
❌ "Review the PR"
✅ "Review PR #123 focusing on security and code quality"

### 3. Ask for Reports
```
Use github-agent to review PR #123 and provide detailed report
```

### 4. Batch Related Operations
```
Use github-agent to:
1. Create issue for bug X
2. Link it to PR #123
3. Add to milestone "v1.2"
```

### 5. Confirm Destructive Operations
The agent will ask for confirmation before:
- Merging PRs
- Deleting issues/PRs
- Force pushing
- Bulk deletions

---

## Error Handling

### If Agent Can't Authenticate

**Error**: "GitHub CLI not authenticated"

**Solution:**
```bash
gh auth login
```

### If Rate Limited

**Error**: "GitHub API rate limit exceeded"

**Agent will:**
- Report current limit status
- Show reset time
- Suggest waiting or using PAT

### If Permission Denied

**Error**: "Permission denied for operation"

**Check:**
1. Repository permissions
2. GITHUB_TOKEN scopes
3. Branch protection rules

---

## Sample Workflows

### Morning Routine
```
Use github-agent to:
1. List all issues created yesterday
2. List PRs awaiting review
3. Check for failed workflows
4. Generate morning summary report
```

### Pre-Release Checklist
```
Use github-agent to:
1. Verify all milestone issues are closed
2. Check all PRs are merged
3. Validate configuration files
4. Run all workflows
5. Generate release notes
6. Create release when ready
```

### Weekly Maintenance
```
Use github-agent to:
1. Close stale issues (60+ days)
2. Close stale PRs (45+ days)
3. Update repository statistics
4. Check for documentation updates
5. Generate weekly report
```

### Security Audit
```
Use github-agent to:
1. Review all open PRs for security issues
2. Check for exposed secrets in recent commits
3. Validate workflow permissions
4. Generate security audit report
```

---

## Monitoring and Reporting

The agent always provides:

### Operation Summary
- What was done
- Status (success/failure)
- Metrics (issues created, PRs reviewed, etc.)

### Detailed Reports
- Links to created resources
- Before/after comparisons
- Recommendations for next steps

### Error Details
- What went wrong
- Suggested fixes
- How to retry

---

## Tips for Maximum Effectiveness

1. **Use for Batch Operations** - The agent excels at processing multiple items
2. **Combine Operations** - Chain related tasks together
3. **Request Reports** - Always ask for summary reports
4. **Leverage Automation** - Let agent handle repetitive tasks
5. **Review First** - Agent will show plan before destructive operations
6. **Use Labels** - Take advantage of intelligent auto-labeling
7. **Monitor Health** - Regular health checks prevent issues
8. **Automate Releases** - Let agent handle changelog generation

---

## Getting Help

### View Agent Capabilities
```
Use github-agent to show me what operations you can perform
```

### Test Agent
```
Use github-agent to perform a test operation:
Create a test issue and immediately close it
```

### Debug Issues
```
Use github-agent to debug why PR #123 can't be merged
```

---

## Related Documentation

- **Agent Definition**: `.claude/agents/github-automation.md`
- **Skill File**: `.claude/SKILLS/github-agent.md`
- **GitHub Automation Guide**: `.github/GITHUB_AUTOMATION.md`
- **Workflow Documentation**: `.github/workflows/README.md`
- **Slash Commands**: `.claude/commands/github/`

---

## Quick Reference Commands

| Operation | Command |
|-----------|---------|
| Create issue | `Use github-agent to create issue: [description]` |
| Review PR | `Use github-agent to review PR #[number]` |
| Sync fork | `Use github-agent to sync my fork` |
| Create release | `Use github-agent to create release v[version]` |
| Setup labels | `Use github-agent to setup label system` |
| Health check | `Use github-agent to perform health check` |
| List issues | `Use github-agent to list issues [filters]` |
| Trigger workflow | `Use github-agent to trigger [workflow-name]` |
| Merge PR | `Use github-agent to merge PR #[number]` |
| Close stale | `Use github-agent to close stale issues` |

---

**The GitHub agent is your autonomous assistant for all GitHub operations. Use it to save time, maintain quality, and keep your repository healthy!** 🚀
