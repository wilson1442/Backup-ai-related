AI Server Backup Script
Overview

This script is designed to safely and repeatably back up all critical AI server data required to rebuild the system from scratch in the event of hardware failure, OS reinstall, or migration.

It focuses on data that cannot be easily recreated, while assuming the OS and base tooling can be reprovisioned.

What This Script Backs Up

✅ User home directory

✅ Ollama models

✅ Custom / fine-tuned AI models

✅ RAG data and vector database

✅ Preserves permissions, ownership, and directory structure

The backups are timestamped so you always have multiple restore points.

Supported Environment

OS: Ubuntu 22.04 / 24.04 (or similar Linux distros)

Shell: Bash

Required tools:

rsync

coreutils

Directory Layout Assumptions

Update these paths in the script to match your environment:

Purpose	Default Path (Example)
Home directory	/home/yourusername
Ollama models	/var/lib/ollama/models
Custom AI models	/opt/ai/models
RAG / Vector DB	/opt/ai/rag
Backup destination	/mnt/ai-backups

💡 Tip: The backup destination should be:

A separate physical NVMe

OR a NAS mount

OR a snapshot-protected volume
Never the same disk as your source data.

Script Behavior

Uses rsync with archive mode:

Preserves permissions, ownership, timestamps

Creates timestamped directories for each run

Deletes files in the backup that no longer exist in the source
(keeps backups clean and accurate)

Logs basic completion status to stdout

Installation

Place the script on your AI server:

nano ai-backup.sh


Paste the script contents.

Make it executable:

chmod +x ai-backup.sh

Usage

Run manually:

./ai-backup.sh


Example output:

Backup completed at 2025-11-29_18-42-10

Automating with Cron (Recommended)

To run nightly at 2:00 AM:

crontab -e


Add:

0 2 * * * /path/to/ai-backup.sh >> /var/log/ai-backup.log 2>&1

Restore Process (Disaster Recovery)

Rebuilding the server is straightforward:

Reinstall Ubuntu

Reinstall dependencies (Ollama, CUDA, etc.)

Mount backup storage

Restore data with rsync:

rsync -av /mnt/ai-backups/home_YYYY-MM-DD_HH-MM-SS/ /home/yourusername/
rsync -av /mnt/ai-backups/ollama_models_YYYY-MM-DD_HH-MM-SS/ /var/lib/ollama/models/
rsync -av /mnt/ai-backups/custom_ai_models_YYYY-MM-DD_HH-MM-SS/ /opt/ai/models/
rsync -av /mnt/ai-backups/rag_vector_db_YYYY-MM-DD_HH-MM-SS/ /opt/ai/rag/


Restart services

Resume work

⏱️ Typical rebuild time: 30–60 minutes assuming backups are intact.
