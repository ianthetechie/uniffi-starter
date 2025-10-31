#!/bin/sh
# clone-repo.sh
# Clone a repository from GitHub (POSIX compliant)

set -eu

# Usage: ./clone-repo.sh <repo-url> <target-dir> [commit-hash]
REPO_URL="${1:?Repository URL required}"
TARGET_DIR="${2:?Target directory required}"
COMMIT_HASH="${3:-main}"

# Check git availability
if ! command -v git >/dev/null 2>&1; then
    echo "❌ Git is not installed. Please install Git first." >&2
    exit 1
fi

# Clone if missing
if [ -d "$TARGET_DIR" ]; then
    echo "ℹ️ Directory '$TARGET_DIR' already exists. Skipping clone."
else
    echo "👉 Cloning $REPO_URL into $TARGET_DIR..."
    git clone "$REPO_URL" "$TARGET_DIR"
    echo "✅ Repository cloned."
fi

# Fetch + checkout requested commit/branch/tag
echo "👉 Fetching latest refs..."
git -C "$TARGET_DIR" fetch --all --tags

echo "👉 Checking out $COMMIT_HASH..."
if ! git -C "$TARGET_DIR" checkout "$COMMIT_HASH"; then
    echo "❌ Failed to checkout $COMMIT_HASH" >&2
    exit 1
fi
echo "✅ Checked out $COMMIT_HASH"

# Optional: strip .git so it’s just source files
if [ -d "$TARGET_DIR/.git" ]; then
    rm -rf "$TARGET_DIR/.git"
    echo "🧹 Removed .git folder; repo is now a plain directory."
fi