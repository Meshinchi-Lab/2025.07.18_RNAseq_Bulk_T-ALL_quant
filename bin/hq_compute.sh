#!/bin/bash

set -eou pipefail

echo "Running the command"
env | grep -Ei "HQ"

echo "##################"
eval ${HQ_ENTRY}

echo "Completed"