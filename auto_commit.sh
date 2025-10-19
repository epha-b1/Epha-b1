#!/bin/bash

# Auto Commit Script to Maintain GitHub Streak
# This script creates a meaningful commit and pushes to GitHub

# Navigate to the repository directory
cd /home/someone/Documents/Fetan_System_Technology/Epha-b1 || exit 1

# Get current date and time
CURRENT_DATE=$(date '+%Y-%m-%d')
CURRENT_TIME=$(date '+%H:%M:%S')
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Create or update a streak tracker file
STREAK_FILE="streak_tracker.log"

# Add entry to streak tracker
echo "[$TIMESTAMP] Auto-commit executed - Keeping the streak alive! 🔥" >> "$STREAK_FILE"

# Configure git (if not already configured)
# Uncomment and update these lines with your details if needed
# git config user.email "your-email@example.com"
# git config user.name "Your Name"

# Stage the changes
git add "$STREAK_FILE"

# Check if there are any changes to commit
if git diff --staged --quiet; then
    echo "[$TIMESTAMP] No changes to commit. Creating a small update..."
    # If no changes, update the file to ensure there's something to commit
    echo "[$TIMESTAMP] Streak maintenance commit" >> "$STREAK_FILE"
    git add "$STREAK_FILE"
fi

# Create commit with timestamp
COMMIT_MESSAGE="🔥 Auto-commit: Maintaining streak on $CURRENT_DATE at $CURRENT_TIME"
git commit -m "$COMMIT_MESSAGE"

# Push to remote repository
git push origin main 2>&1

# Check if push was successful
if [ $? -eq 0 ]; then
    echo "[$TIMESTAMP] ✅ Successfully pushed to GitHub!"
    echo "[$TIMESTAMP] ✅ Successfully pushed to GitHub!" >> "$STREAK_FILE"
else
    echo "[$TIMESTAMP] ❌ Failed to push to GitHub. Check your connection and credentials."
    echo "[$TIMESTAMP] ❌ Failed to push to GitHub." >> "$STREAK_FILE"
    
    # Try to push to master branch as fallback
    git push origin master 2>&1
    if [ $? -eq 0 ]; then
        echo "[$TIMESTAMP] ✅ Successfully pushed to GitHub (master branch)!"
        echo "[$TIMESTAMP] ✅ Successfully pushed to GitHub (master branch)!" >> "$STREAK_FILE"
    fi
fi

# Log the execution
echo "----------------------------------------" >> "$STREAK_FILE"

