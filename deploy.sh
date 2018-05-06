#!/bin/bash

set -e

echo Logging in to Amazon ECR...
$(aws ecr get-login --no-include-email --region $AWS_DEFAULT_REGION)

./build.sh

RepositoryName='codepipelineexample'
RepositoryUrl=$(aws ecr describe-repositories --query "repositories[?repositoryName=='${RepositoryName}'].repositoryUri" --output text)

RANDOM_TAG=$(date +%s"_$RANDOM")
TAG=$RANDOM_TAG
if [ -z "$RepositoryUrl" ]; then
  RepositoryUrl=$(aws ecr create-repository --repository-name "${RepositoryName}" --query "repository.repositoryUri" --output text)

fi

#aws ecr set-repository-policy --repository-name "${RepositoryName}" --policy-text file://$(dirname $0)/repository-policy.json

ECR_TAG=$RepositoryUrl:$TAG
docker tag codepipelineexample:latest $ECR_TAG
echo "Image taggged: $ECR_TAG"
docker push $ECR_TAG
echo "Image pushed"