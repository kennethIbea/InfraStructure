#!/bin/bash


# Declare all the variables to be used in the stack
export CURRENT_STACK_NAME=ssl
export CREATE_STACK_COMPLETED="Stack ${CURRENT_STACK_NAME} Creation Completed"
export STACK_CREATION_IN_PROGRESS="Stack ${CURRENT_STACK_NAME} Creation in progress"

# Create the SSL stack
aws cloudformation update-stack \
    --stack-name $CURRENT_STACK_NAME \
    --template-body file://templates/ssl/ssl.yml \
    --parameters \
        ParameterKey=ServerDomainName,ParameterValue=$SERVER_SUBDOMAIN_NAME.$DOMAIN_NAME \
        ParameterKey=ClientDomainName,ParameterValue=$REDIRECT_TO_DOMAIN \
        ParameterKey=GameResultServerDomainName,ParameterValue=$GAME_RESULT_SERVER_SUBDOMAIN_NAME.$DOMAIN_NAME \
        ParameterKey=ProjectName,ParameterValue=$PROJECT_NAME \
    --profile $AWS_DEPLOY_PROFILE

# # Create Output for Stack creation in progress
echo $STACK_CREATION_IN_PROGRESS
echo "Please register the name servers in the demo account to complete this phase"
echo "Please wait for aws to then issue the certificates for this phase to be completed"
# Wait for the stack creation to be complete 
aws cloudformation wait stack-create-complete \
    --stack-name $CURRENT_STACK_NAME \
    --profile $AWS_DEPLOY_PROFILE
echo $CREATE_STACK_COMPLETED