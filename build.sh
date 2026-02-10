#!/bin/bash

# Simple Build Script for Rhythmic Gymnastics Scoring System
# This script builds the WAR file without requiring NetBeans

echo "=========================================="
echo "Building Rhythmic Gymnastics Scoring System"
echo "=========================================="
echo ""

# Configuration
PROJECT_DIR=$(pwd)
SRC_DIR="src/java"
BUILD_DIR="build"
WEB_DIR="web"
DIST_DIR="dist"
WAR_NAME="RythmicGymnasticScoringSystem.war"
LIB_DIR="lib"

# Check Java
if ! command -v javac &> /dev/null; then
    echo "ERROR: Java JDK not found!"
    echo "Please install Java JDK 17+ and ensure javac is in PATH"
    exit 1
fi

echo "✓ Java JDK found: $(javac -version 2>&1)"
echo ""

# Clean previous build
echo "Cleaning previous build..."
rm -rf "$BUILD_DIR" "$DIST_DIR"
mkdir -p "$BUILD_DIR/WEB-INF/classes"
mkdir -p "$DIST_DIR"
echo "✓ Build directories cleaned"
echo ""

# Compile Java sources
echo "Compiling Java sources..."
CLASSPATH="$LIB_DIR/*"

# Find all Java files
JAVA_FILES=$(find "$SRC_DIR" -name "*.java")

if [ -z "$JAVA_FILES" ]; then
    echo "ERROR: No Java source files found in $SRC_DIR"
    exit 1
fi

# Compile
javac -d "$BUILD_DIR/WEB-INF/classes" \
      -cp "$CLASSPATH" \
      -source 17 \
      -target 17 \
      $JAVA_FILES

if [ $? -ne 0 ]; then
    echo "✗ Compilation failed"
    exit 1
fi

echo "✓ Java sources compiled successfully"
echo ""

# Copy web resources
echo "Copying web resources..."
cp -r "$WEB_DIR"/* "$BUILD_DIR/"
echo "✓ Web resources copied"
echo ""

# Ensure libraries are in WEB-INF/lib
echo "Ensuring libraries in WEB-INF/lib..."
mkdir -p "$BUILD_DIR/WEB-INF/lib"
cp -f "$LIB_DIR"/*.jar "$BUILD_DIR/WEB-INF/lib/"
echo "✓ Libraries copied to WEB-INF/lib"
echo ""

# Create WAR file
echo "Creating WAR file..."
cd "$BUILD_DIR"
jar -cvf "../$DIST_DIR/$WAR_NAME" * > /dev/null 2>&1
cd ..

if [ ! -f "$DIST_DIR/$WAR_NAME" ]; then
    echo "✗ Failed to create WAR file"
    exit 1
fi

WAR_SIZE=$(du -h "$DIST_DIR/$WAR_NAME" | cut -f1)
echo "✓ WAR file created: $DIST_DIR/$WAR_NAME ($WAR_SIZE)"
echo ""

# Verify WAR contents
echo "Verifying WAR contents..."
jar -tf "$DIST_DIR/$WAR_NAME" | grep -q "WEB-INF/web.xml"
if [ $? -eq 0 ]; then
    echo "✓ WAR file verified (web.xml found)"
else
    echo "✗ WAR file verification failed"
    exit 1
fi

echo ""
echo "=========================================="
echo "Build completed successfully!"
echo "=========================================="
echo ""
echo "WAR file location: $DIST_DIR/$WAR_NAME"
echo ""
echo "Next steps:"
echo "1. Deploy to Tomcat: cp $DIST_DIR/$WAR_NAME \$CATALINA_HOME/webapps/"
echo "2. Or deploy to GlassFish: asadmin deploy $DIST_DIR/$WAR_NAME"
echo "3. Access: http://localhost:8080/RythmicGymnasticScoringSystem/"
echo ""
