# Assignment #5: Enterprise-Grade Environment Management with Terraform Workspace

This repository contains the deliverables for Assignment #5, focusing on establishing enterprise-grade environment management practices using Terraform Workspaces. The assignment demonstrates the ability to manage multiple environments (e.g., development, staging, production) with distinct configurations, ensure compliance, and provide robust operational procedures.

## Setup and Usage (Detailed Steps based on Tasks)

1.  **Prerequisites:**
    * Terraform installed (version X.Y.Z)
    * AWS CLI configured with appropriate credentials
    * An AWS S3 bucket for Terraform state backend
    * An AWS DynamoDB table for state locking (highly recommended)
    * (Optional) Terraform Cloud account configured if using TFC for state management and runs.



terraform init
<img width="670" alt="{76F1B406-CCE1-4DA3-84AC-D7FEC16772D5}" src="https://github.com/user-attachments/assets/1ec9fb3e-a674-49be-9753-85752bfc721a" />
<img width="670" alt="{76F1B406-CCE1-4DA3-84AC-D7FEC16772D5}" src="https://github.com/user-attachments/assets/1ec9fb3e-a674-49be-9753-85752bfc721a" />

tf_workspace variale
<img width="748" alt="{9037C450-8B1C-42B1-9D5A-B74C52D60DA8}" src="https://github.com/user-attachments/assets/1b0ffd1f-78ea-45e6-b5cd-31feabe9203c" />
<img width="748" alt="{9037C450-8B1C-42B1-9D5A-B74C52D60DA8}" src="https://github.com/user-attachments/assets/1b0ffd1f-78ea-45e6-b5cd-31feabe9203c" />

list
<img width="723" alt="{4CF3C98A-BD49-42C0-AD2A-BA01ED6B7FEE}" src="https://github.com/user-attachments/assets/0ddc8894-f327-4587-a5ea-dfc7bf14d22b" />
<img width="723" alt="{4CF3C98A-BD49-42C0-AD2A-BA01ED6B7FEE}" src="https://github.com/user-attachments/assets/0ddc8894-f327-4587-a5ea-dfc7bf14d22b" />



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
