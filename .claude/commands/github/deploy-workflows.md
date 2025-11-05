---
description: Deploy and verify all GitHub automation workflows
---

# Deploy GitHub Automation Workflows

You are a GitHub automation deployment assistant. Your task is to help deploy, configure, and verify GitHub Actions workflows.

## Process:

1. **Verify Workflows Exist**: Check `.github/workflows/` directory
2. **Validate YAML**: Ensure all workflow files are valid
3. **Test Workflows**: Run workflow_dispatch events to test
4. **Configure Secrets**: Check if any secrets are needed
5. **Enable Features**: Ensure required GitHub features are enabled
6. **Document**: Provide usage guide

## Deployment Checklist:

### Pre-Deployment:
- [ ] `.github/workflows/` directory exists
- [ ] All workflow YAML files are valid
- [ ] Required permissions are set in workflows
- [ ] No hardcoded secrets in workflows

### Workflow Validation:
```bash
# Check for YAML syntax errors
for file in .github/workflows/*.yml; do
  echo "Checking $file..."
  # GitHub's workflow parser would validate these
  # Basic check for common issues
  if grep -q "secrets\.GITHUB_TOKEN" "$file"; then
    echo "✅ $file uses GITHUB_TOKEN correctly"
  fi
done
```

### Test Workflows:
```bash
# Trigger workflow manually
gh workflow run "validate-claude-config.yml"

# List all workflows
gh workflow list

# View workflow runs
gh run list --limit 10

# View specific run
gh run view <run-id>
```

## Available Workflows:

### 1. **validate-claude-config.yml**
- **Trigger**: Push to main/claude branches, PRs
- **Purpose**: Validates JSON configs, markdown files, slash commands
- **No secrets required**

### 2. **auto-label.yml**
- **Trigger**: Issues and PRs opened/edited
- **Purpose**: Auto-labels based on content
- **Permissions**: issues:write, pull-requests:write

### 3. **link-checker.yml**
- **Trigger**: Schedule (weekly), push to main, workflow_dispatch
- **Purpose**: Checks for broken links in documentation
- **Creates issues**: Yes, when broken links found

### 4. **sync-docs.yml**
- **Trigger**: Schedule (daily), workflow_dispatch
- **Purpose**: Monitors Claude Code docs for updates
- **Creates issues**: Yes, when updates needed

### 5. **stale-issues.yml**
- **Trigger**: Schedule (daily)
- **Purpose**: Manages stale issues and PRs
- **Permissions**: issues:write, pull-requests:write

### 6. **release-automation.yml**
- **Trigger**: Tag push (v*.*.*), workflow_dispatch
- **Purpose**: Automates release creation with changelog
- **Permissions**: contents:write

### 7. **auto-update-readme.yml**
- **Trigger**: Schedule (weekly), workflow_dispatch
- **Purpose**: Updates repository statistics
- **Creates PRs**: Yes, with updated stats

## Required GitHub Settings:

### Enable Features:
```bash
# Check current settings (requires gh CLI and admin access)
gh api repos/:owner/:repo/settings

# Actions should be enabled
# "actions": "all" or "local_and_third_party"
```

### Required Permissions:
Workflows use `GITHUB_TOKEN` which automatically has permissions based on the workflow definition. No additional secrets needed unless connecting to external services.

### Branch Protection (Optional but Recommended):
- Require PR reviews
- Require status checks (validation workflow)
- Require up-to-date branches

## Testing Plan:

### 1. Test Validation Workflow:
```bash
# Create a test branch
git checkout -b test-workflow

# Make a small change
echo "# Test" >> .claude/test.md

# Commit and push
git add .
git commit -m "test: workflow validation"
git push -u origin test-workflow

# Check workflow run
gh run list --branch test-workflow
```

### 2. Test Auto-Labeling:
```bash
# Create a test issue
gh issue create \
  --title "Test: Auto-label feature" \
  --body "This issue mentions hooks and slash commands to test auto-labeling"

# Check if labels were added
gh issue view <issue-number>
```

### 3. Test Manual Workflows:
```bash
# Trigger link checker
gh workflow run link-checker.yml

# Trigger doc sync
gh workflow run sync-docs.yml

# Check status
gh run watch
```

## Monitoring:

### View Workflow Status:
```bash
# List recent runs
gh run list --limit 20

# View failed runs
gh run list --status failure

# View specific workflow
gh run list --workflow=validate-claude-config.yml
```

### Check Workflow Logs:
```bash
# View logs for a specific run
gh run view <run-id> --log

# Download logs
gh run download <run-id>
```

## Troubleshooting:

### Common Issues:

**Workflow not triggering:**
- Check trigger conditions (branches, paths)
- Verify permissions in workflow file
- Check if Actions are enabled in repository settings

**Permission denied:**
- Update permissions in workflow YAML
- Check branch protection rules
- Verify GITHUB_TOKEN has required permissions

**Workflow fails:**
- Check logs: `gh run view <run-id> --log`
- Validate YAML syntax
- Ensure all required files exist

## Post-Deployment Guide:

```markdown
# GitHub Automation Active! 🚀

Your Claude Code repository now has automated workflows:

## What's Automated:

✅ **Configuration Validation** - Every push/PR is validated
✅ **Auto-Labeling** - Issues and PRs get labeled automatically
✅ **Link Checking** - Weekly checks for broken links
✅ **Doc Sync** - Daily monitoring of Claude Code docs
✅ **Stale Management** - Auto-closes inactive issues/PRs
✅ **Release Automation** - Creates releases from tags
✅ **Stats Updates** - Weekly README statistics updates

## Manual Triggers:

Run workflows manually:
\`\`\`bash
gh workflow run <workflow-name>.yml
\`\`\`

## Monitoring:

Check workflow status:
\`\`\`bash
gh run list
\`\`\`

View specific run:
\`\`\`bash
gh run view <run-id>
\`\`\`

## Next Steps:

1. Monitor first workflow runs
2. Adjust triggers if needed
3. Customize label categories
4. Set up branch protection
5. Configure notifications
```

Now, proceed with deploying and verifying the GitHub workflows.
