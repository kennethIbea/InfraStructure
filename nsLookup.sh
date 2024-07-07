#!/bin/bash

export DOMAIN_NAME=shinko.demo.viven.inc

# Check first the NS's are created
# Server
echo "Look up NS record for domain name"
nslookup -type=NS $DOMAIN_NAME

