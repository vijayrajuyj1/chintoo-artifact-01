# DevOps Assignment Vijayaraju

## Overview
This repository contains Infrastructure as Code (IaC) and CI/CD pipelines for deploying a Spring Boot application built with Gradle. The goal is to automate infrastructure provisioning, application packaging, and deployment to AWS.

## Project Structure
```
├── infra/                # Infrastructure as Code (Terraform, CloudFormation, etc.)
├── ci-cd/                # CI/CD pipeline configuration (GitHub Actions, Jenkins, etc.)
├── app/                  # Application source code
├── scripts/              # Deployment scripts
└── README.md             # Project documentation
```

## Prerequisites
Ensure you have the following installed:
- Terraform (or preferred IaC tool)
- AWS CLI configured with appropriate credentials
- Jenkins/GitHub Actions/GitLab CI/CD setup
- Docker (if containerizing the application)
- Gradle (for building the application)

## Steps to Deploy

### Step 1: Infrastructure Setup
Use Terraform (or another IaC tool) to provision the required AWS infrastructure. Run:
```sh
cd infra/
terraform init
terraform apply -auto-approve
```
This will create the necessary VPC, subnets, security groups, EC2 instances, and S3 bucket.

### Step 2: Build the Application
Package the Spring Boot application using Gradle:
```sh
cd app/
gradle build
```
This will generate a `.jar` file inside `build/libs/`.

### Step 3: CI/CD Pipeline
CI/CD is configured to:
1. Build the application (`gradle build`)
2. Upload the artifact to an S3 bucket
3. Deploy the artifact to EC2 instances

#### Using GitHub Actions:
- The workflow is defined in `.github/workflows/deploy.yml`.
- Push your changes to trigger the pipeline automatically.



### Step 4: Deploy to EC2
Deployment can be handled via a script:

This will:
- Download the artifact from S3
- Deploy it on EC2 instances in both public and private subnets

## Notes
- If using Docker, the image is pushed to Docker Hub before deployment.
- The EC2 instances have public IPs assigned.

## Repository
Find the source code and CI/CD pipelines at:
[GitHub Repo](https://github.com/hvk2123/chintoo)

## License
This project is open-source and licensed under the MIT License.

