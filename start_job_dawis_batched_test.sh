#!/usr/bin/env bash

# Create a temporary file list for this batch
BATCH_ID=$(date +%s%N | cut -b1-13)  # Unique timestamp
TEMP_FILE="/n03data/ellien/Euclid_LSB_DR1/logs/batch_${BATCH_ID}.txt"

# Write all file arguments to temp file
for file in "$@"; do
    echo "$file" >> "$TEMP_FILE"
done

sbatch <<EOT
#!/bin/bash
#SBATCH --job-name=lsb_dr1_batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --time=48:00:00
#SBATCH --output /n03data/ellien/Euclid_LSB_DR1/logs/%x.%j.batch_${BATCH_ID}.out 
#SBATCH --error  /n03data/ellien/Euclid_LSB_DR1/logs/%x.%j.batch_${BATCH_ID}.err

source /home/ellien/.bashrc
conda activate dawis

# Process files in parallel
python -W"ignore" /home/ellien/Euclid_LSB_DR1/process_batch.py $TEMP_FILE

# Clean up temp file
rm -f $TEMP_FILE

exit 0
EOT
