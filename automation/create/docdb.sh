#!/bin/bash

# Create the AWS stack for the DocumentDB
export CURRENT_STACK_NAME=docdb2
export CREATE_STACK_COMPLETED="Stack ${CURRENT_STACK_NAME} Creation Completed"

aws cloudformation create-stack \
    --stack-name $CURRENT_STACK_NAME \
    --template-body file://templates/docdb/docdb.yml \
    --parameters \
        ParameterKey=ProjectName,ParameterValue=$PROJECT_NAME \
        ParameterKey=AppEnv,ParameterValue=$AppEnv \
    --profile $AWS_DEPLOY_PROFILE


# Wait for the stack creation to be complete 
aws cloudformation wait stack-create-complete \
    --stack-name $CURRENT_STACK_NAME \
    --profile $AWS_DEPLOY_PROFILE
echo $CREATE_STACK_COMPLETED