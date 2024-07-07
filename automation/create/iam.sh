#!/bin/bash

export CURRENT_STACK_NAME=iam

aws cloudformation create-stack --stack-name $CURRENT_STACK_NAME \
    --template-body file://templates/iam/iam.yml \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameters \
        ParameterKey=DeploymentUserName,ParameterValue=$AWS_DEPLOY_PROFILE \
        ParameterKey=ECRUserName,ParameterValue=$AWS_ECR_PROFILE \
    --profile $AWS_ADMIN_PROFILE

# Create Output for Stack creation in progress
echo STACK_CREATION_IN_PROGRESS
# Wait for the stack creation to be complete 
aws cloudformation wait stack-create-complete \
    --stack-name $CURRENT_STACK_NAME \
    --profile $AWS_ADMIN_PROFILE
echo CREATE_STACK_COMPLETED
