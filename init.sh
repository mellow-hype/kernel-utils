#!/usr/bin/env bash

# Install symlinks to all scripts in the build-utils directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "Installing symlinks to scripts in $SCRIPT_DIR/build-utils"
BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"
for script in "$SCRIPT_DIR"/build-utils/*; do
    ln -sf "$script" "$BIN_DIR/$(basename "$script")"
done
echo "Symlinks to scripts installed in $BIN_DIR"

# Check if Docker is available
if ! command -v docker &> /dev/null; then
    echo "Docker could not be found. Please install Docker to use the Docker build features."
    exit 1
fi

# Setup the debootstrapper Docker images
cd "$SCRIPT_DIR/debootstrapper"
echo "Building debootstrapper Docker image..."
./init.sh
cd "$SCRIPT_DIR"

echo "Initialization complete."