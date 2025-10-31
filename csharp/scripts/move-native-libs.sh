#!/bin/sh
# Restructure a Rust build output into the .NET runtimes/ layout
# Usage: ./move-native-libs.sh <RustOutputFile> <DestPath>

set -eu

RUST_OUTPUT_FILE="${1:?Rust output file path required}"
DEST_PATH="${2:?Destination path required}"

ensure_dir() {
    path="$1"
    dir=$(dirname "$path")
    mkdir -p "$dir"
}

if [ ! -f "$RUST_OUTPUT_FILE" ]; then
    echo "⚠️  Skipping missing file: $RUST_OUTPUT_FILE"
    exit 0
fi

ensure_dir "$DEST_PATH"
cp -f "$RUST_OUTPUT_FILE" "$DEST_PATH"
echo "✅ Copied $RUST_OUTPUT_FILE → $DEST_PATH"