# LifeBuild Baseball Game Project Infra in Development Environment

## Environments

| Environment | Admin Email                                    | URL                               |
| ----------- | ---------------------------------------------- | --------------------------------- |
| production  | admin.p_client_lifebuild@viven.inc             | https://www.our-stars.com         |
| development | admin.development.p_client_lifebuild@viven.inc | https://development.our-stars.com |

## Phase 0
- Notion

### Phase 0 for Software Install 

- Install AWS CLI
```
~/D/xxxxxxx-yyyyyy-infra ❯❯❯ aws --version                                                            ✘ 252 deployment/production ✚ ✱
aws-cli/2.10.1 Python/3.9.11 Darwin/22.3.0 exe/x86_64 prompt/off
```

### Phase 0 in README 

| FIELD_NAME                | FIELD_VALUE             |
| ------------------------- | ----------------------- |
| {{ PROJECT_NAME_DETAIL }} | LifeBuild Baseball Game |

### Phase 0 in run.sh

| FIELD_NAME                   | FIELD_VALUE                         |
| ---------------------------- | ----------------------------------- |
| {{ PROJECT_NAME }}           | lifebuild-baseball-game             |
| {{ APP_ENV }}                | development                         |
| {{ DOMAIN_NAME }}            | development.ours-stars.com          |
| {{ SERVER_SUBDOMAIN_NAME }}  | api                                 |
| {{ CLIENT_SUBDOMAIN_NAME }}  | www                                 |
| {{ REDIRECTED_FROM_DOMAIN }} | $DOMAIN_NAME                        |
| {{ REDIRECT_TO_DOMAIN }}     | $CLIENT_SUBDOMAIN_NAME.$DOMAIN_NAME |

## Phase 1 - IAM Layer

- Create `{{ PROJECT_NAME }}-{{ APP_ENV }}-admin` User with IAMFullAccess Permission and CloudFormaitonFullAccess Permission.
- Generate AccessKey and SecretKey of the user which is created above.
  - Create access Key in Security Credential Tab of User Detail Page.
  - Step 1
    - Choose `Command Line Interface (CLI)`
    - Check `I understand the above recommendation and want to proceed to create an access key.`
  - Step 2
    - Add any key name for Description tag value
  - Click `Create access key`

- Run 
``` 
sh automation/run.sh 1
```

- Generate AccessKey and SecretKey of the user `{{ PROJECT_NAME }}-{{ APP_ENV }}-deployment`  . 
  - processes are same.

## Phase 2 - Network Layer

- [Commit 5](https://github.com/viven-inc/belebel-ec-infra/commit/774d8e66086cbb0474047b71396b70ae38036481)
- [Commit 6](https://github.com/viven-inc/belebel-ec-infra/commit/52f02873c5c98ed0bfae25529165ff875e495f20)

- Run 
```
sh automation/run.sh 2
```
- Please register the name servers in the onamae.com to complete this phase
- Please wait for 
  - DNS to finish the NameServerRecords(NS Record) and check `nslookup -type=NS {{ DOMAIN_NAME }}`
  - SSL to certificate the issue. 

## Phase 3

- Run 

```
sh automation/run.sh 3
```

- After ECR service is created, we build the Image by CodeBuild
- Docker images for both the server and the client must be pushed to their repositories before the next phase.
- Run the two SQL Queries


## Phase 4 

- Run ```sh automation/run.sh 4```

- Deployment completed

## Warning
- Image Size should be less than 20MB.
- appspec / task definition is wrong position
- appspec / task definition path is wrong

## MongoDB Tutorial 
- https://docs.aws.amazon.com/documentdb/latest/developerguide/quick_start_cfn.html

## Connect to MongoDB
- Connect
- Getting Started Guide  |Enabling/Disabling TLS  |Connecting programmatically 
- Download the Amazon DocumentDB Certificate Authority (CA) certificate required to authenticate to your clusterCopy
```
wget https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem
```
- Connect to this cluster with the mongo shellCopy
```
mongo --ssl --host dm6ctzfuperuhrp97ch3.cluster-ckcz2fd1qsij.ap-northeast-1.docdb.amazonaws.com:27017 --sslCAFile rds-combined-ca-bundle.pem --username JM7EcRiQ93MVD8UXXHiU --password <insertYourPassword>
```
- Connect to this cluster with an applicationCopy
```
mongodb://JM7EcRiQ93MVD8UXXHiU:<insertYourPassword>@dm6ctzfuperuhrp97ch3.cluster-ckcz2fd1qsij.ap-northeast-1.docdb.amazonaws.com:27017/?ssl=true&ssl_ca_certs=rds-combined-ca-bundle.pem&replicaSet=rs0&readPreference=secondaryPreferred&retryWrites=false
```
