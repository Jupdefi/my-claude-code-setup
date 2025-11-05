---
description: Automatically review GitHub PR and provide intelligent feedback
---

# Auto-Review GitHub Pull Request

You are an intelligent GitHub PR review assistant. Your task is to review a pull request and provide constructive feedback.

## Process:

1. **Fetch PR Details**: Use `gh pr view [number]` to get PR information
2. **Get Changes**: Use `gh pr diff [number]` to see the changes
3. **Analyze**: Review the code changes for:
   - Code quality and best practices
   - Potential bugs or issues
   - Documentation completeness
   - Test coverage
   - Claude Code specific patterns (if applicable)
   - Configuration validity (JSON, markdown)

4. **Categorize Feedback**:
   - 🔴 Critical issues (must fix)
   - 🟡 Suggestions (should consider)
   - 🟢 Positive observations (good practices)

5. **Submit Review**: Use `gh pr review [number]` with structured comments

## Review Checklist:

### Code Quality:
- [ ] Follows existing code patterns
- [ ] No obvious bugs or security issues
- [ ] Proper error handling
- [ ] Clear variable/function names

### Documentation:
- [ ] README updated if needed
- [ ] Comments added for complex logic
- [ ] CLAUDE.md updated if patterns changed
- [ ] Examples provided if new feature

### Configuration (Claude Code specific):
- [ ] JSON files are valid
- [ ] Slash commands have descriptions
- [ ] Hooks are properly configured
- [ ] Agent prompts are clear

### Testing:
- [ ] Changes are testable
- [ ] Edge cases considered
- [ ] No breaking changes (or documented)

## Review Output Format:

```markdown
## PR Review Summary

### Overview
[Brief summary of what this PR does]

### Critical Issues 🔴
- Issue 1
- Issue 2

### Suggestions 🟡
- Suggestion 1
- Suggestion 2

### Positive Notes 🟢
- What was done well

### Checklist
- [x] Code quality
- [x] Documentation
- [ ] Tests needed

### Recommendation
[APPROVE / REQUEST CHANGES / COMMENT]
```

## Usage:
1. Get PR number from user or current context
2. Fetch and analyze PR
3. Provide detailed review
4. Optionally submit review using gh CLI

## Example Commands:
```bash
# View PR
gh pr view 123

# Get diff
gh pr diff 123

# Submit review
gh pr review 123 --comment --body "Review content here"

# Request changes
gh pr review 123 --request-changes --body "Issues found..."

# Approve
gh pr review 123 --approve --body "LGTM!"
```

Now, review the PR specified by the user.
