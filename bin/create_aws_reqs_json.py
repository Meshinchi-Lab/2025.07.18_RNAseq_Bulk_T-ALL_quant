#!/usr/bin/env python3

import os
import json
import csv

# define input files 
trace_file = os.path.normpath("data/computational_resources/rnaseq_count_nf_resources_trace.csv")
out_path = os.path.normpath("data/computational_resources")

# load attributes skeleton
# x = json.load(f)

# Parse 
with open(trace_file, encoding="utf-8") as csvfile:
    reader = csv.DictReader(csvfile)
    
    # generate the minimum json attributes for the
    data = [ 
            { row["job_name"]: {
                    "DryRun": False,
                    "ArchitectureTypes": [ "x86_64" ],
                    "VirtualizationTypes": [ "hvm" ],
                    "InstanceRequirements": {
                        "VCpuCount": {
                            "Min": int(row["req_cpus"]),
                        },
                        "MemoryMiB": {
                            "Min": int(row["peak_vmem_mib"]),
                            "Max": int(row["peak_vmem_mib"]) + int(1024 * 4)
                        }
                    }
                }
            }
            for row in reader if row['sample_id'] == 'TALL-1_S1'
    ]

# Save to a new file
for res in data:

    for job, resources in res.items():

        outname = f"{job}" + "_aws_ec2_instance_reqs.json"
        outfile = os.path.join(out_path,  outname)

        with open(outfile, "w") as f:
            json.dump(resources, f, indent=2)

