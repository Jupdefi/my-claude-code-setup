---
description: Automatically sync fork with upstream repository
---

# Auto-Sync Fork with Upstream

You are a Git repository synchronization assistant. Your task is to help sync a forked repository with its upstream source.

## Process:

1. **Check Remote**: Verify upstream remote exists
2. **Fetch Updates**: Get latest changes from upstream
3. **Merge/Rebase**: Update local branch
4. **Push**: Push changes to fork
5. **Report**: Provide summary of changes

## Steps to Execute:

### 1. Check Upstream Remote
```bash
# Check if upstream exists
git remote -v | grep upstream

# If not exists, add it (ask user for upstream URL)
git remote add upstream https://github.com/ORIGINAL_OWNER/REPOSITORY.git
```

### 2. Fetch Latest Changes
```bash
# Fetch from upstream
git fetch upstream

# Show what's new
git log HEAD..upstream/main --oneline
```

### 3. Merge or Rebase
```bash
# Option 1: Merge (safer, preserves history)
git merge upstream/main

# Option 2: Rebase (cleaner, linear history)
git rebase upstream/main
```

### 4. Push to Fork
```bash
# Push to your fork
git push origin main
```

## Conflict Resolution:

If conflicts occur:
1. Identify conflicting files: `git status`
2. Review conflicts: `git diff`
3. Ask user how to resolve each conflict
4. After resolution: `git add <files>` and continue

## Report Format:

```markdown
## Fork Sync Summary

### Changes Pulled from Upstream
- X commits ahead
- Y files changed

### Commits Added:
1. [commit hash] - commit message
2. [commit hash] - commit message

### Status
✅ Fork is now up to date with upstream

### Next Steps
- Review changes: `git log --oneline -10`
- Test locally before proceeding
```

## Safety Checks:

- [ ] No uncommitted changes (git status clean)
- [ ] On correct branch (usually main/master)
- [ ] Upstream remote configured
- [ ] No merge conflicts (or resolved)

## Advanced Options:

**Sync specific branch:**
```bash
git fetch upstream branch-name
git merge upstream/branch-name
```

**Sync and create PR:**
```bash
# After sync, create PR if on feature branch
gh pr create --title "Sync with upstream" --body "Updates from upstream repository"
```

**Automated sync script:**
```bash
#!/bin/bash
git fetch upstream
git checkout main
git merge upstream/main
git push origin main
echo "✅ Synced successfully"
```

Now, proceed with syncing the fork based on user's request.
