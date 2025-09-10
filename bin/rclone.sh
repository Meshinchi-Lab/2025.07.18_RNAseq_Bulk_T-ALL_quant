#!/bin/bash


PROJECT="2025-07-18_RNAseq_Bulk_T-ALL_quant"
INPUTS="$HOME/github_repos/$PROJECT/data/rnaseq_quant"

# ensure that rclone sftp config has been set-up for Storage-NGSONCO
# OUTDIR="ngsonco:/Storage-NGSONCO/NGS"
# SUBDIR='Francesca Benini/T-ALL/$PROJECT/data/rnaseq_quant'
OUTDIR="/mnt/network_drives/storage-bioinfo_labq/0004_ngs_analysis"
SUBDIR="quintarelli_c/benini_f/T-ALL/$PROJECT/data/rnaseq_quant"


# if [[ ! -e "$OUTDIR/$SUBDIR" ]]
# then
#     mkdir -p "$OUTDIR/$SUBDIR"
# fi

echo "Syncing results from: $INPUTS"
echo "Writing to: $OUTDIR/$SUBDIR"

rclone copy \
    --copy-links \
    -cv \
    --progress \
    "$INPUTS" "$OUTDIR/$SUBDIR/"

