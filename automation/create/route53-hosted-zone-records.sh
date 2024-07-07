#!/bin/bash

# Create the AWS stack for the RDS
export CURRENT_STACK_NAME=hosted-zone-records
export CREATE_STACK_COMPLETED="Stack ${CURRENT_STACK_NAME} Creation Completed"
export STACK_CREATION_IN_PROGRESS="Stack ${CURRENT_STACK_NAME} Creation in progress"

# templates/networking/route53/records/hosted-zone-records.yml
aws cloudformation create-stack \
    --stack-name $CURRENT_STACK_NAME \
    --template-body file://templates/route53/records/create/hosted-zone-records.yml\
    --parameters \
        ParameterKey=ServerDomainName,ParameterValue=$SERVER_SUBDOMAIN_NAME.$DOMAIN_NAME \
        ParameterKey=GameResultServerDomainName,ParameterValue=$GAME_RESULT_SERVER_SUBDOMAIN_NAME.$DOMAIN_NAME \
        ParameterKey=ClientDomainName,ParameterValue=$REDIRECT_TO_DOMAIN \
        ParameterKey=ProjectName,ParameterValue=$PROJECT_NAME \
    --profile $AWS_DEPLOY_PROFILE

# Create Output for Stack creation in progress
echo $STACK_CREATION_IN_PROGRESS
# Wait for the stack creation to be complete 
aws cloudformation wait stack-create-complete \
    --stack-name $CURRENT_STACK_NAME \
    --profile $AWS_DEPLOY_PROFILE
echo $CREATE_STACK_COMPLETED