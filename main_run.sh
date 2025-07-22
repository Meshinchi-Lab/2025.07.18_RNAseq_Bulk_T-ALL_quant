#!/bin/bash

set -eu
DATE=$(date +%F)
NXF_CONFIG=./nextflow.config
# Options: 
NXF_PROFILE='local_docker'
# Options:  rnaseq_count, prep_genome, or sra_download
NXF_ENTRY='rnaseq_count'
# The output prefix on filenames for reports/logs
REPORT=${1:-"rnaseq_star_counts"}

# Set Debug > 0 to increase verbosity in nextflow logs
export NXF_DEBUG=2

# Nextflow run to execute the workflow
PREFIX="${REPORT}_${DATE}"
nextflow -c ${NXF_CONFIG} \
    -log reports/${PREFIX}_nextflow.log \
    run main.nf \
    -entry ${NXF_ENTRY} \
    -profile ${NXF_PROFILE} \
    -with-report reports/${PREFIX}.html \
    -with-dag dag/${PREFIX}_dag.pdf \
    -cache TRUE \
    -with-trace \
    -resume
