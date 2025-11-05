#!/bin/bash
# PRE_COMMIT hook - Validates files before committing
# This hook runs automatically before each git commit

set -e

echo "🔍 Running pre-commit validation..."

# Check if jq is available
if ! command -v jq &> /dev/null; then
    echo "⚠️  Warning: jq not installed, skipping JSON validation"
else
    # Validate JSON files in .claude directory
    echo "📝 Validating JSON configuration files..."
    find .claude -name "*.json" -type f 2>/dev/null | while read file; do
        if ! jq empty "$file" 2>/dev/null; then
            echo "❌ Invalid JSON in $file"
            exit 1
        fi
    done
    echo "✅ JSON validation passed"
fi

# Check for common issues in markdown files
echo "📄 Checking markdown files..."
git diff --cached --name-only --diff-filter=ACM | grep '\.md$' | while read file; do
    if [ -f "$file" ]; then
        # Check for trailing whitespace
        if grep -q '[[:space:]]$' "$file"; then
            echo "⚠️  Warning: Trailing whitespace found in $file"
        fi

        # Check for TODO/FIXME markers
        if grep -qi 'TODO\|FIXME' "$file"; then
            echo "ℹ️  Info: TODO/FIXME markers found in $file"
        fi
    fi
done

# Validate slash commands if any are modified
echo "⚡ Validating slash commands..."
git diff --cached --name-only --diff-filter=ACM | grep '.claude/commands/.*\.md$' | while read file; do
    if [ -f "$file" ]; then
        # Check if file is not empty
        if [ ! -s "$file" ]; then
            echo "❌ Empty slash command file: $file"
            exit 1
        fi

        # Check if file has basic markdown structure
        if ! grep -q '^#' "$file"; then
            echo "⚠️  Warning: $file may be missing header structure"
        fi
    fi
done

# Check for large files
echo "📦 Checking file sizes..."
git diff --cached --name-only --diff-filter=ACM | while read file; do
    if [ -f "$file" ]; then
        size=$(wc -c < "$file")
        if [ $size -gt 1048576 ]; then  # 1MB
            echo "⚠️  Warning: Large file detected: $file ($(numfmt --to=iec-i --suffix=B $size))"
            echo "   Consider using Git LFS for large files"
        fi
    fi
done

# Check for sensitive information patterns
echo "🔐 Scanning for potential secrets..."
PATTERNS=(
    "api[_-]?key"
    "password"
    "secret"
    "token"
    "private[_-]?key"
    "aws[_-]?access[_-]?key"
    "ANTHROPIC_API_KEY"
)

for pattern in "${PATTERNS[@]}"; do
    git diff --cached --name-only --diff-filter=ACM | while read file; do
        if [ -f "$file" ]; then
            # Skip checking in certain files/directories
            if [[ "$file" == *".md"* ]] || [[ "$file" == *"LICENSE"* ]]; then
                continue
            fi

            if git diff --cached "$file" | grep -iE "$pattern" | grep -v "# " | grep -v "^\s*//" > /dev/null; then
                echo "⚠️  Warning: Potential secret pattern '$pattern' found in $file"
                echo "   Please review before committing"
            fi
        fi
    done
done

echo "✅ Pre-commit validation complete!"
