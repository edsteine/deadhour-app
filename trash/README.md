# Trash Folder

This folder contains files that were moved here instead of being permanently deleted.

## Purpose
- **Safety**: Preserve all user work and prevent accidental data loss
- **Recovery**: Allow easy restoration if files were moved by mistake
- **Version History**: Keep timestamped backups when needed

## Usage
- AI assistants should NEVER use `rm` or delete commands
- Instead, use: `mv filename /Users/edsteine/AndroidStudioProjects/deadhour/trash/`
- For multiple files: `mv filename /trash/filename_$(date +%Y%m%d_%H%M%S)`
- User can manually review and permanently delete files when appropriate

## Contents
Files moved here will be dated and organized for easy recovery.

*This folder was created to implement the "Never Delete Files" safety rule.*