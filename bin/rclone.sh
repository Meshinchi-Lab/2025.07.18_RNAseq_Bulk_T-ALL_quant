#!/bin/bash

set -eou 


# inputs
PROJECT="2025-07-18_RNAseq_Bulk_T-ALL_quant"
DATA_DIR="$PROJECT/data/rnaseq_quant/trimgalore"

# input files to transfer
INPUTS="$HOME/github_repos/$DATA_DIR"

# outputs
OUTDIR="/mnt/network_drives/storage-bioinfo_labq/0004_ngs_analysis"
SUBDIR="quintarelli_c/benini_f/T-ALL/$DATA_DIR"


if [[ ! -e "$OUTDIR/$SUBDIR" ]]
then
    mkdir -p "$OUTDIR/$SUBDIR"
fi

echo "Syncing results from: $INPUTS"
echo "Writing to: $OUTDIR/$SUBDIR"

rclone copy \
    --local-no-set-modtime \
    --copy-links \
    -cv \
    --exclude-if-present './git' \
    --progress \
    "$INPUTS" "$OUTDIR/$SUBDIR/"

