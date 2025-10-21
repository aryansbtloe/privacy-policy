#!/bin/bash

# Privacy Policy Deployment Script
# This script helps deploy the privacy policy to GitHub Pages

echo "🚀 Privacy Policy Deployment Script"
echo "=================================="

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "❌ Error: Not in a git repository"
    echo "Please run this script from the privacy-policy directory"
    exit 1
fi

# Check if we have uncommitted changes
if [ -n "$(git status --porcelain)" ]; then
    echo "⚠️  Warning: You have uncommitted changes"
    echo "Please commit your changes before deploying"
    echo ""
    echo "To commit changes:"
    echo "  git add ."
    echo "  git commit -m 'Update privacy policy'"
    echo "  git push origin main"
    exit 1
fi

# Get current branch
CURRENT_BRANCH=$(git branch --show-current)
echo "📋 Current branch: $CURRENT_BRANCH"

# Check if we're on main branch
if [ "$CURRENT_BRANCH" != "main" ] && [ "$CURRENT_BRANCH" != "master" ]; then
    echo "⚠️  Warning: You're not on main/master branch"
    echo "Current branch: $CURRENT_BRANCH"
    echo "GitHub Pages typically deploys from main/master branch"
    echo ""
    read -p "Do you want to continue? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Deployment cancelled"
        exit 1
    fi
fi

# Push to remote
echo "📤 Pushing to remote repository..."
git push origin $CURRENT_BRANCH

if [ $? -eq 0 ]; then
    echo "✅ Successfully pushed to remote"
    echo ""
    echo "🌐 Your privacy policy will be available at:"
    echo "   https://yourusername.github.io/your-repo-name/"
    echo "   https://yourusername.github.io/your-repo-name/?app=YourAppName"
    echo ""
    echo "⏱️  GitHub Pages typically takes 1-10 minutes to update"
    echo "📧 Check your repository settings to ensure GitHub Pages is enabled"
else
    echo "❌ Failed to push to remote"
    exit 1
fi
