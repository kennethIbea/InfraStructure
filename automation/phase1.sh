#!/bin/bash

# Configure admin user for AWS CLI
echo "- setting up the $AWS_ADMIN_PROFILE AWS Profile for AWS CLI."
aws configure --profile $AWS_ADMIN_PROFILE

# Set up IAM for a deployment user
sh automation/create/iam.sh
echo "- Create the programatic access for the $AWS_DEPLOY_PROFILE profile"

# Configure deployment user for AWS CLI
echo "- setting up the $AWS_DEPLOY_PROFILE AWS Profile for AWS CLI."
aws configure --profile $AWS_DEPLOY_PROFILE
