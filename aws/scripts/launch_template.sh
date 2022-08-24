#!/bin/bash -ex

# Running Amazon Linux 2 AMI

# add aws package
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# upgrade yum
sudo yum upgrade -y

# install unzip to extract aws folder
sudo yum install unzip -y

# unzip aws cli file
unzip awscliv2.zip

# instal aws cli
sudo ./aws/install


# define cluster name
# and add it to ecs config
# echo ECS_CLUSTER=cluster-${app_tagname} >> /etc/ecs/ecs.config;

# PULL DOCKER IMAGE

## DEFINE ENVIRONMENT VARIABLES
DOCKER_REPOSITORY_NAME=llmatos
AWS_DEFAULT_REGION=sa-east-1

## ADD ACCOUNT ID TO VARIABLE
aws_account_id=$(aws sts get-caller-identity --query "Account" --output text)

## ATTACH ELASTIC IP TO INSTANCE FOR PREVENT IP CHANGES
## 1 - GET THE CURRENT INSTANCE IF
ec2_instance_id=$(ec2-metadata --instance-id | cut -d " " -f 2)
## 2 - ALLOCATE ELASTIC-IP TO EC2-INSTANCE
aws ec2 associate-address --instance-id $ec2_instance_id --public-ip 54.233.122.237


## *************************************************************************** ##
## -------------------------------> ATTENTION <------------------------------- ##
## *************************************************************************** ##
## CONNECT TO ECR REPOSITORY
## DOES IT IS NECESSARY TO RUN INSIDE AN EC2-INSTANCE?
## - once this command is called from an ec2-instance, the instance already have permission
## - to access ECR by IAM-ROLE attached to it.
## + If erc get-login-password needs AWS credentials, it will failure because at this moment
## + the instance does not have credentials, only permission to access ECR.
## **************************************************************************** ##
## --> SHOULD BE MADE A LOGIN TEST FROM EC2-SSH TO CHECK IF IT IS POSSIBLE. <-- ##
## **************************************************************************** ##
aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${aws_account_id}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com

## PULL IMAGE FROM EC2 REPOSITORY
docker pull ${aws_account_id}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/$DOCKER_REPOSITORY_NAME:latest

## RUN DOCKER IMAGE
docker run -d --name $DOCKER_REPOSITORY_NAME \
-p 80:1337 \
--restart always \
${aws_account_id}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/$DOCKER_REPOSITORY_NAME:latest npm run start
