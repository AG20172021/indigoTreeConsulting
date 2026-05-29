#!/bin/bash

# Deploy script for Indigo Tree Consulting website to Fly.io

set -e

echo "🌿 Deploying Indigo Tree Consulting to Fly.io..."

# Check if logged in to fly
if ! flyctl auth whoami > /dev/null 2>&1; then
    echo "⚠️  Not logged in to Fly.io. Running fly auth login..."
    flyctl auth login
fi

# Create app if it doesn't exist
if ! flyctl status --app indigo-tree-consulting > /dev/null 2>&1; then
    echo "📦 Creating new Fly.io app..."
    flyctl launch --name indigo-tree-consulting --region ord --no-deploy
fi

# Deploy
echo "🚀 Deploying..."
flyctl deploy

echo "✅ Deployed successfully!"
echo ""
echo "Your site should be available at: https://indigo-tree-consulting.fly.dev"
echo ""
echo "To view logs: fly logs"
echo "To open dashboard: fly dashboard"