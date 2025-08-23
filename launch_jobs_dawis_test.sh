#!/bin/bash

# Create array of all files to process
FILES=()
while IFS= read -r -d '' file; do
    FILES+=("$file")
done < <(find /n03data/ellien/Euclid_LSB_DR1/data/EUC_EDF_N_bin4_2.5k2/ -name "*_scaled.cut*[1234567890].fits" -print0)

echo "Found ${#FILES[@]} files to process"

# Function to check if file already processed
check_if_processed() {
    local file=$1
    local n=$(basename "$file")
    local idtile=${n:18:4}
    local idcut=$(echo $n | sed -n 's/.*cut\([0-9]\+\)\.fits/\1/p')
    
    if [ -f "/n08data/ellien/Euclid_LSB_DR1/wavelets/out4/${idtile}/EUC_VIS_LSB_ObsID_${idtile}_scaled.cut${idcut}.log.txt" ]; then
        return 0  # Already processed
    else
        return 1  # Not processed
    fi
}

# Create batches of 8 files (excluding already processed ones)
BATCH_SIZE=8
batch=()
batch_count=0

for file in "${FILES[@]}"; do
    if ! check_if_processed "$file"; then
        batch+=("$file")
        
        if [ ${#batch[@]} -eq $BATCH_SIZE ]; then
            # Launch job for this batch
            echo "Launching batch $((++batch_count)) with ${#batch[@]} files"
            bash start_batched_job.sh "${batch[@]}"
            batch=()
        fi
    else
        echo "Skipping already processed: $(basename "$file")"
    fi
done

# Launch remaining files if any
if [ ${#batch[@]} -gt 0 ]; then
    echo "Launching final batch $((++batch_count)) with ${#batch[@]} files"
    bash start_job_dawis_batched_test.sh "${batch[@]}"
fi

echo "Launched $batch_count batches total"
