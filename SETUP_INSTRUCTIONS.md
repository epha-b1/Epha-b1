# 🔥 GitHub Streak Auto-Commit Setup Guide

This guide will help you set up automatic commits twice a day to maintain your GitHub contribution streak!

## 📋 Prerequisites

1. Git installed on your system
2. GitHub repository already initialized
3. SSH key configured for GitHub (recommended) or HTTPS with credential storage

## 🚀 Quick Setup

### Step 1: Make the Script Executable

```bash
chmod +x /home/someone/Documents/Fetan_System_Technology/Epha-b1/auto_commit.sh
```

### Step 2: Test the Script Manually

```bash
/home/someone/Documents/Fetan_System_Technology/Epha-b1/auto_commit.sh
```

### Step 3: Set Up GitHub Authentication

#### Option A: SSH (Recommended)

If you haven't already, set up SSH keys:

```bash
# Generate SSH key (if you don't have one)
ssh-keygen -t ed25519 -C "your-email@example.com"

# Start ssh-agent
eval "$(ssh-agent -s)"

# Add your SSH key
ssh-add ~/.ssh/id_ed25519

# Copy your public key and add it to GitHub
cat ~/.ssh/id_ed25519.pub
```

Then add the public key to GitHub: Settings → SSH and GPG keys → New SSH key

#### Option B: HTTPS with Credential Storage

```bash
# Store credentials (you'll be prompted once)
git config --global credential.helper store

# Or use cache (credentials expire after 15 minutes by default)
git config --global credential.helper cache
```

### Step 4: Configure Git (if not already done)

```bash
git config --global user.email "your-email@example.com"
git config --global user.name "Your Name"
```

### Step 5: Set Up Cron Jobs (2 times per day)

Open your crontab:

```bash
crontab -e
```

Add these two lines to run the script twice daily (at 10 AM and 6 PM):

```bash
# Auto-commit at 10:00 AM every day
0 10 * * * /home/someone/Documents/Fetan_System_Technology/Epha-b1/auto_commit.sh >> /home/someone/Documents/Fetan_System_Technology/Epha-b1/cron.log 2>&1

# Auto-commit at 6:00 PM every day
0 18 * * * /home/someone/Documents/Fetan_System_Technology/Epha-b1/auto_commit.sh >> /home/someone/Documents/Fetan_System_Technology/Epha-b1/cron.log 2>&1
```

**Alternative times you can use:**

```bash
# Option 1: Morning and Evening (9 AM and 9 PM)
0 9 * * * /home/someone/Documents/Fetan_System_Technology/Epha-b1/auto_commit.sh >> /home/someone/Documents/Fetan_System_Technology/Epha-b1/cron.log 2>&1
0 21 * * * /home/someone/Documents/Fetan_System_Technology/Epha-b1/auto_commit.sh >> /home/someone/Documents/Fetan_System_Technology/Epha-b1/cron.log 2>&1

# Option 2: Early Morning and Late Night (8 AM and 11 PM)
0 8 * * * /home/someone/Documents/Fetan_System_Technology/Epha-b1/auto_commit.sh >> /home/someone/Documents/Fetan_System_Technology/Epha-b1/cron.log 2>&1
0 23 * * * /home/someone/Documents/Fetan_System_Technology/Epha-b1/auto_commit.sh >> /home/someone/Documents/Fetan_System_Technology/Epha-b1/cron.log 2>&1

# Option 3: Noon and Midnight (12 PM and 12 AM)
0 12 * * * /home/someone/Documents/Fetan_System_Technology/Epha-b1/auto_commit.sh >> /home/someone/Documents/Fetan_System_Technology/Epha-b1/cron.log 2>&1
0 0 * * * /home/someone/Documents/Fetan_System_Technology/Epha-b1/auto_commit.sh >> /home/someone/Documents/Fetan_System_Technology/Epha-b1/cron.log 2>&1
```

### Step 6: Verify Cron Jobs are Set

```bash
# List your cron jobs
crontab -l

# Check if cron service is running
sudo systemctl status cron
```

## 📊 Understanding Cron Syntax

```
* * * * * command
│ │ │ │ │
│ │ │ │ └─── Day of week (0-7, Sunday = 0 or 7)
│ │ │ └───── Month (1-12)
│ │ └─────── Day of month (1-31)
│ └───────── Hour (0-23)
└─────────── Minute (0-59)
```

## 🔍 Monitoring and Troubleshooting

### Check Cron Logs

```bash
# View cron execution log
cat /home/someone/Documents/Fetan_System_Technology/Epha-b1/cron.log

# View streak tracker log
cat /home/someone/Documents/Fetan_System_Technology/Epha-b1/streak_tracker.log

# Check system cron logs
grep CRON /var/log/syslog
```

### Common Issues and Solutions

#### Issue 1: Script doesn't have execution permission

```bash
chmod +x /home/someone/Documents/Fetan_System_Technology/Epha-b1/auto_commit.sh
```

#### Issue 2: Authentication fails

- Make sure SSH keys are added to GitHub
- Or configure credential.helper for HTTPS

#### Issue 3: Cron not running

```bash
# Start cron service
sudo systemctl start cron

# Enable cron to start on boot
sudo systemctl enable cron
```

#### Issue 4: Wrong branch name

- Edit `auto_commit.sh` and change `main` to `master` if needed (line 36)

## 🎯 Additional Tips

1. **Keep your computer on**: Cron jobs only run when your computer is on
2. **Use a server**: For 100% reliability, deploy this on a VPS or cloud server
3. **Monitor regularly**: Check the logs weekly to ensure everything is working
4. **Backup**: Keep a backup of your repository

## 🌟 GitHub Actions Alternative

If you want a more reliable solution that doesn't require your computer to be on, consider using GitHub Actions:

Create `.github/workflows/auto-commit.yml`:

```yaml
name: Auto Commit

on:
  schedule:
    - cron: "0 10 * * *" # 10 AM UTC
    - cron: "0 18 * * *" # 6 PM UTC
  workflow_dispatch: # Allow manual trigger

jobs:
  auto-commit:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Make changes
        run: |
          date >> streak_tracker.log
          echo "Auto-commit from GitHub Actions" >> streak_tracker.log

      - name: Commit and push
        run: |
          git config user.name "GitHub Actions Bot"
          git config user.email "actions@github.com"
          git add .
          git commit -m "🔥 Auto-commit: $(date '+%Y-%m-%d %H:%M:%S')"
          git push
```

## 📝 Notes

- The script creates a `streak_tracker.log` file to track all commits
- All executions are logged in `cron.log`
- The script handles both `main` and `master` branch names
- Running twice a day provides redundancy in case one execution fails

## 🎉 Success!

Once set up, you'll never miss your GitHub streak again! 🔥

---

**Created by**: Ephrem Belaineh
**Repository**: https://github.com/epha-b1
