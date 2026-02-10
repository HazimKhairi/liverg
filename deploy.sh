#!/bin/bash

# ==========================================
# 🚀 Smart Deployment Script for LIVERG
# ==========================================

# --- Configuration ---
# UPDATED: Detected running Tomcat is from Homebrew
TOMCAT_HOME="/opt/homebrew/Cellar/tomcat@10/10.1.52/libexec" 
PROJECT_NAME="RythmicGymnasticScoringSystem"
DEPLOY_DIR="$TOMCAT_HOME/webapps/$PROJECT_NAME"
WAR_FILE="dist/$PROJECT_NAME.war"
Src_WEB="web"
SERVICE_PORT=8080

echo "--------------------------------------------------"
echo "   🚀  Starting Deployment Process"
echo "   📍  Tomcat Home: $TOMCAT_HOME"
echo "   📂  Target App:  $PROJECT_NAME"
echo "--------------------------------------------------"

# --- 1. Validation Checks ---
if [ ! -d "$TOMCAT_HOME" ]; then
    echo "❌  CRITICAL ERROR: Tomcat directory not found!"
    echo "    Expected: $TOMCAT_HOME"
    exit 1
fi

# --- 2. Build Process ---
echo "📦  Step 1: Building Project..."
if [ -f "build.sh" ]; then
    sh build.sh
    if [ $? -ne 0 ]; then
        echo "❌  Build Failed! Please check compilation errors."
        exit 1
    fi
    echo "✅  Build successful."
else
    echo "⚠️  Warning: 'build.sh' not found. Skipping build."
fi

# --- 3. Server Status Check ---
echo "🔍  Step 2: Checking Server Status..."
PID=$(lsof -ti:$SERVICE_PORT)
if [ -z "$PID" ]; then
    echo "⚠️  Tomcat is NOT running."
    echo "    Attempting to start Tomcat..."
    # Homebrew tomcat usually started via brew services or catalina run
    if [ -f "$TOMCAT_HOME/bin/startup.sh" ]; then
        "$TOMCAT_HOME/bin/startup.sh"
        echo "⏳  Waiting for server to initialize..."
        sleep 5
    else
        echo "ℹ️  Try starting it with: brew services start tomcat@10"
    fi
else
    echo "✅  Tomcat is running (PID: $PID)."
fi

# --- 4. Deployment ---
echo "📂  Step 3: Deploying Files..."

# Ensure target webapps directory exists
if [ ! -d "$TOMCAT_HOME/webapps" ]; then
    echo "❌  Error: 'webapps' folder missing in Tomcat Home."
    exit 1
fi

# Method A: WAR Deployment
if [ -f "$WAR_FILE" ]; then
    echo "    -> Copying WAR file to webapps..."
    cp "$WAR_FILE" "$TOMCAT_HOME/webapps/"
else
    echo "⚠️  WAR file not found at $WAR_FILE"
fi

# Method B: Direct File Sync (Hot Reload Fix)
# This forces the updated JSPs into the folder even if Tomcat didn't unpack the WAR yet
if [ -d "$Src_WEB" ]; then
    echo "    -> Performing Direct File Sync (Hot Update)..."
    
    # Ensure target directory exists
    if [ ! -d "$DEPLOY_DIR" ]; then
        echo "    (Creating target directory...)"
        mkdir -p "$DEPLOY_DIR"
    fi
    
    # Copy web contents using sudo if necessary (Homebrew dirs might be protected)
    # Trying check permissions first
    if [ -w "$DEPLOY_DIR" ]; then
        cp -R "$Src_WEB/"* "$DEPLOY_DIR/"
    else
        echo "⚠️  Permission denied. Trying with sudo..."
        echo "    (You might be asked for your password)"
        sudo cp -R "$Src_WEB/"* "$DEPLOY_DIR/"
    fi
    
    echo "✅  Files synced directly to $DEPLOY_DIR"
else
    echo "❌  Source 'web' directory not found!"
fi

echo "--------------------------------------------------"
echo "🎉  DEPLOYMENT COMPLETE"
echo "👉  Verify at: http://localhost:$SERVICE_PORT/$PROJECT_NAME/publicEvents.jsp"
echo "--------------------------------------------------"
