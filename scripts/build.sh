#!/bin/bash
set -e

echo "Building Rojo projects..."

BUILD_DIR="builds"
OUTPUT_NAME="Satchel"
BUILD_PROJECT="package.project.json"

# Setup build directory
echo "Cleaning up build directory..."
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

# Build .rbxm file
rojo build --output "$BUILD_DIR/$OUTPUT_NAME.rbxm" $BUILD_PROJECT

# Build .rbxmx file
rojo build --output "$BUILD_DIR/$OUTPUT_NAME.rbxmx" $BUILD_PROJECT

echo "Build completed successfully!"