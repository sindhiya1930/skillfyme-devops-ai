# Assignment #5: Enterprise-Grade Environment Management with Terraform Workspace

This repository contains the deliverables for Assignment #5, focusing on establishing enterprise-grade environment management practices using Terraform Workspaces. The assignment demonstrates the ability to manage multiple environments (e.g., development, staging, production) with distinct configurations, ensure compliance, and provide robust operational procedures.

## Setup and Usage (Detailed Steps based on Tasks)

1.  **Prerequisites:**
    * Terraform installed (version X.Y.Z)
    * AWS CLI configured with appropriate credentials
    * An AWS S3 bucket for Terraform state backend
    * An AWS DynamoDB table for state locking (highly recommended)
    * (Optional) Terraform Cloud account configured if using TFC for state management and runs.


**Terraform Workspace**

***dataset***
1.three workspaces
2.environment specific *.auto.tfvars

****Tasks****
***initialise workspaces***

<img width="614" alt="image" src="https://github.com/user-attachments/assets/a8fdd749-8d13-4efe-ae84-a0dbd7a40fe9" />

***Tagging***

***dev***

<img width="740" alt="image" src="https://github.com/user-attachments/assets/c4b59b35-9a50-435d-a89e-7ed409ea77dc" />

***staging***

<img width="440" alt="image" src="https://github.com/user-attachments/assets/0ab756f2-f125-4887-ba20-8fb293b3636e" />

***prod***

<img width="522" alt="image" src="https://github.com/user-attachments/assets/63086d17-05ea-4ebb-9e7b-22321318f583" />


***deploy infra***

<img width="761" alt="image" src="https://github.com/user-attachments/assets/c6e74a4b-6671-458e-9c79-7b8634774394" />
