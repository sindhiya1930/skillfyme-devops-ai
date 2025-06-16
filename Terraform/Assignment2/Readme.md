# Enterprise Terraform State Management with S3 Backend

## Assignment #2 Implementation

This repository contains the Terraform configuration and associated documentation for implementing an enterprise-grade Terraform state management solution using AWS S3 for remote state storage and AWS DynamoDB for state locking, as per "Assignment #2: Enterprise Terraform State Management with S3 Backend" from Skillfyme's "Terraform - Practical Workflows and Collaboration Strategies."

### Table of Contents

1.  [Overview](#1-overview)
2.  [Prerequisites](#2-prerequisites)
3.  [AWS IAM](#3-aws-iam)
4.  [Deployment Instructions](#4-deployment-instructions)
    * [Authentication Details](#authentication-details)
    * [Initial Setup (Backend Creation)](#initial-setup-backend-creation)
    * [Terraform Initialization](#terraform-initialization)
    * [Applying the Configuration](#applying-the-configuration)
    * [Environment Customization (Workspaces)](#environment-customization-workspaces)
5.  [Validation Steps and Outcomes](#5-validation-steps-and-outcomes)
    * [S3 Bucket Properties](#s3-bucket-properties)
    * [DynamoDB Lock Table Activity](#dynamodb-lock-table-activity)
    * [State File Encryption](#state-file-encryption)
    * [Least Privilege IAM](#least-privilege-iam)
6.  [Operational Documents & Procedures](#6-operational-documents--procedures)
    * [Incident Response for State Corruption](#incident-response-for-state-corruption)
    * [Cross-Team Access Procedure](#cross-team-access-procedure)
    * [Backup & Recovery Strategy (State)](#backup--recovery-strategy-state)
    * [Compliance Considerations](#compliance-considerations)
7.  [Cleanup](#7-cleanup)
8.  [Next Steps (Future Enhancements)](#8-next-steps-future-enhancements)

---

### 1. Overview

This project establishes a secure, collaborative, and compliant environment for managing Terraform state in an enterprise setting. Key features implemented include:

* **Remote State Storage:** Leveraging AWS S3 to centralize Terraform state files, facilitating team collaboration and providing robust durability.
* **State Locking:** Utilizing an AWS DynamoDB table to prevent concurrent Terraform operations on the same state, thereby avoiding race conditions and state corruption.
* **Encryption at Rest:** Implementing Server-Side Encryption with AWS Key Management Service (KMS) for the S3 state bucket, ensuring data confidentiality.
* **Versioning for Recovery:** Enabling S3 bucket versioning to maintain a historical record of all state file changes, crucial for rollbacks and disaster recovery.
* **Secure Access:** Applying granular IAM policies based on the principle of least privilege, combined with S3 bucket policies to enforce secure transport (TLS 1.2+) and restrict access to authorized IP ranges.
* **Data Durability & Recoverability:** Configuring DynamoDB Point-in-Time Recovery (PITR) for the state lock table and detailing S3-based state recovery procedures.

### 2. Prerequisites

* An AWS Account with an IAM User or Role having sufficient permissions to create:
    * S3 Buckets and manage bucket policies.
    * DynamoDB Tables.
    * AWS KMS Keys and aliases.
    * IAM Roles, Policies, and Instance Profiles.
* AWS CLI installed and configured with programmatic access keys or assumed role credentials.
* Terraform installed (v1.0.0 or later recommended).
* **Network Access:** Ensure your execution environment has outbound access to AWS S3, DynamoDB, IAM, and KMS endpoints in your chosen region. If behind a corporate firewall, ensure the necessary proxy configurations are in place for the AWS CLI and Terraform.

### 3.AWS IAM
Manages AWS Identity and Access Management (IAM) resources:
* **`aws_iam_policy.terraform_state_s3_policy`**: Grants least-privilege permissions (`s3:ListBucket`, `s3:GetObject`, `s3:PutObject`, `s3:DeleteObject`, `s3:GetObjectVersion`, `s3:DeleteObjectVersion`, `kms:Decrypt`, `kms:GenerateDataKey`) for interaction with the S3 state bucket and its associated KMS key.
* **`aws_iam_policy.terraform_state_dynamodb_policy`**: Grants least-privilege permissions (`dynamodb:GetItem`, `dynamodb:PutItem`, `dynamodb:DeleteItem`) for state locking operations on the DynamoDB table.
* **`aws_iam_role.terraform_executor_role`**: A dedicated IAM role designed to be assumed by the entity running Terraform (e.g., CI/CD pipeline, EC2 instance, or federated user). This role has the two policies above attached.
    * **`assume_role_policy`**: Configured to allow an EC2 service principal to assume this role by default. **This should be customized based on your execution environment (e.g., GitHub Actions OIDC, dedicated IAM user, other AWS services).**
* **`aws_iam_instance_profile.terraform_executor_profile`**: An instance profile, used if the `terraform_executor_role` is assumed by an EC2 instance.
* Includes minimal IAM setup for the example EC2 instance (`EC2InstanceRole`, `EC2InstancePolicy`, `EC2InstanceProfile`).

### 4. Deployment Instructions

Follow these steps to deploy and manage your Terraform state backend.

#### Authentication Details

Terraform and the AWS CLI will need AWS credentials to interact with your account. It is highly recommended to use **temporary credentials** via IAM Roles whenever possible, especially in CI/CD environments.

**Order of Credential Precedence (Terraform/AWS CLI):**
1.  **Environment Variables:** `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_SESSION_TOKEN` (for temporary credentials).
2.  **Shared Credentials File:** `~/.aws/credentials` (and `AWS_PROFILE` environment variable).
3.  **AWS Config File:** `~/.aws/config`.
4.  **IAM Roles for EC2 Instances:** If running on an EC2 instance, the associated IAM role's credentials will be used.
5.  **ECS/EKS Task Roles, Lambda Execution Roles, etc.**

**Recommended Authentication Methods:**

* **For CI/CD Pipelines:** Use OIDC (OpenID Connect) with your CI/CD provider (e.g., GitHub Actions, GitLab CI/CD) to assume the `TerraformExecutorRole`. This avoids static credentials.
* **For EC2 Instances:** Attach the `TerraformExecutorInstanceProfile` to your EC2 instance.
* **For Local Development (Least Preferred for Production):** Configure your `~/.aws/credentials` file with an IAM User's access keys, and ensure this user has permissions to assume the `TerraformExecutorRole`. Alternatively, directly assign the necessary S3/DynamoDB/KMS permissions to your IAM user for initial setup.

#### Initial Setup (Backend Creation)

**Crucial:** The S3 bucket and DynamoDB table for the backend must exist *before* you run `terraform init` with the `backend` configuration.

1.  **Set `terraform_state_bucket_name` variable:**
    Edit `variables.tf` and provide a **globally unique name** for `terraform_state_bucket_name`. Example: `anglo-terraform-state-backend-skillfy`.
    Also, ensure the `bucket` value in `backend.tf` matches this unique name.

2.  **Create S3 Bucket:**
    ```bash
    aws s3 mb s3://<your-unique-skillfyme-tf-state-bucket> --region <your-aws-region>
    # Example: aws s3 mb s3://anglo-terraform-state-backend-skillfy --region eu-west-3
    ```
    *Note: If `object_lock_enabled` is uncommented in `s3-bucket.tf`, you must create the bucket with `--object-lock-enabled` via CLI or console at this step.*

3.  **Create DynamoDB Table:**
    ```bash
    aws dynamodb create-table \
      --table-name terraform-state-lock \
      --attribute-definitions AttributeName=LockID,AttributeType=S \
      --key-schema AttributeName=LockID,KeyType=HASH \
      --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
      --region eu-west-3 \
      --tags Key=Name,Value=terraform-state-lock Key=Environment,Value=backend Key=ManagedBy,Value=TerraformAssignment
    ```

#### Terraform Initialization

1. Terraform init /
<img width="713" alt="image" src="https://github.com/user-attachments/assets/54cb7ac9-147e-493f-baaf-0864be7beb37" />
2. terraform plan /
3. terraform apply /
<img width="756" alt="image" src="https://github.com/user-attachments/assets/dca0e447-6c15-4007-b3e9-b7eae83c6d9b" />
4. S3 in AWS /
<img width="700" alt="image" src="https://github.com/user-attachments/assets/6a62bd21-5cef-4207-b9d6-b28605d4f269" />
5. dynamodb /
<img width="737" alt="image" src="https://github.com/user-attachments/assets/cf6a09f9-d103-436f-a022-ec003dcfddf6" />
6. uncommenting the backend block to make terraform use the s3 bucket /
<img width="649" alt="image" src="https://github.com/user-attachments/assets/0f5b5b80-8c5e-4fbf-817c-9ab1aaacf8c3" />


