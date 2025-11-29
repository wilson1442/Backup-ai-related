#!/bin/bash

# Define your source directories
HOME_DIR="/home/yourusername"
OLLAMA_MODELS_DIR="/path/to/ollama/models"
CUSTOM_AI_MODELS_DIR="/path/to/custom/ai/models"
RAG_VECTOR_DB_DIR="/path/to/rag/vector/database"

# Define your backup destination
BACKUP_DEST="/path/to/backup/location"

# Create a timestamp for the backup
TIMESTAMP=$(date +" %Y-%m-%d_%H-%M-%S")

# Use rsync to back up each directory into a timestamped folder
rsync -av --delete "$HOME_DIR" "$BACKUP_DEST/home_$TIMESTAMP"
rsync -av --delete "$OLLAMA_MODELS_DIR" "$BACKUP_DEST/ollama_models_$TIMESTAMP"
rsync -av --delete "$CUSTOM_AI_MODELS_DIR" "$BACKUP_DEST/custom_ai_models_$TIMESTAMP"
rsync -av --delete "$RAG_VECTOR_DB_DIR" "$BACKUP_DEST/rag_vector_db_$TIMESTAMP"

echo "Backup completed at $TIMESTAMP"
