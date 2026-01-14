#!/bin/bash

set -eou 


# inputs
PROJECT="2025-07-18_RNAseq_Bulk_T-ALL_quant"
DATA_DIR="$PROJECT"

# input files to transfer
INPUTS="$HOME/github_repos/$DATA_DIR"

# outputs
OUTDIR="/mnt/network_drives/storage-bioinfo_labq/0004_ngs_analysis"
SUBDIR="quintarelli_c/benini_f/T-ALL/$DATA_DIR"
DESTINATION="$OUTDIR/$SUBDIR"

if [[ ! -e "$DESTINATION" ]]
then
    mkdir -p "$DESTINATION"
fi

echo "Syncing results from: $INPUTS"
echo "Writing to: $DESTINATION"

# copy the files 
FILTER_LIST="/bioinformatics_resources/rclone_filter-list.txt"
rclone copy \
    --filter-from $FILTER_LIST \
    --local-no-set-modtime \
    --copy-links \
    -cv \
    --exclude-if-present './git' \
    --progress \
    $INPUTS $DESTINATION/

