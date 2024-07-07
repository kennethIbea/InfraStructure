#!/bin/bash


# Declare all the variables to be used in the stack
export CURRENT_STACK_NAME=ssl
export CREATE_STACK_COMPLETED="Stack ${CURRENT_STACK_NAME} Creation Completed"
export STACK_CREATION_IN_PROGRESS="Stack ${CURRENT_STACK_NAME} Creation in progress"

# # Check first the NS's are created
# # Server
# echo "Look up NS for server domain name"
# nslookup -type=ns $SERVER_SUBDOMAIN_NAME.$DOMAIN_NAME
# #Client
# echo "Look up NS for client domain name"
# nslookup -type=ns $CLIENT_SUBDOMAIN_NAME.$DOMAIN_NAME

# Create the SSL stack
aws cloudformation create-stack \
    --stack-name $CURRENT_STACK_NAME \
    --template-body file://templates/ssl/ssl.yml \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameters \
        ParameterKey=ServerDomainName,ParameterValue=$SERVER_SUBDOMAIN_NAME.$DOMAIN_NAME \
        ParameterKey=ClientDomainName,ParameterValue=$CLIENT_SUBDOMAIN_NAME.$DOMAIN_NAME \
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