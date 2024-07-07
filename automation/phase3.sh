#!/bin/bash

# Create the ECR 
sh automation/create/ecr.sh

# # Create the RDS
# sh automation/create/rds.sh

# Create any S3 buckets required for CodePipeline
sh automation/create/s3.sh
