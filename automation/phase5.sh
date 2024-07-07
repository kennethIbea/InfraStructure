#!/bin/bash

# Create the CodeBuild Project
sh automation/create/code-build.sh

# Create the CodeDeploy Project
sh automation/create/code-deploy.sh
