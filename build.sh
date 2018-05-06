#!/bin/bash

echo Build started on `date`
echo Building the Docker image...          
echo "Account ID: $AWS_ACCOUNT_ID"
echo "Region: $AWS_DEFAULT_REGION"
docker build -t codepipelineexample:latest .
