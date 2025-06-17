# Standardizing Terraform Configurations for Enterprise Reuse

## Assignment #3 Implementation

This assignment focuses on establishing standardized Terraform configurations suitable for enterprise-wide reuse, emphasizing variable standardization, output visibility, and robust validation/deployment processes.

### Table of Contents

1.  [Overview](#1-overview)
2.  [Pre Requisite](#2-pre-requisite)
3.  [Deliverables](#3-deliverables)
    * [Validation Screenshots](#validation-screenshots)
    * [Reference Guide to Validation](#initial-setup-backend-creation)
    * [Compliance Evidence](#complaince-evidence)
      * [Terraform Output Screenshot](#applying-the-configuration)
      * [AWS Console Screenshot](#environment-customization-workspaces)

### 1. Overview

In enterprise environments, consistent and secure infrastructure provisioning is paramount. This assignment focuses on key aspects of achieving this through Terraform:

* **Variable Standardization**: Defining clear, validated input variables to ensure consistent and controlled resource deployments.
* **Output Visibility**: Exposing critical information about deployed resources for downstream consumption and integration.
* **Validation & Deployment**: Implementing robust validation rules to prevent misconfigurations and demonstrating controlled deployments across different environments.

### 2. Pre Requisite
* Organization creation
<img width="944" alt="image" src="https://github.com/user-attachments/assets/c61dfb5d-0227-42dc-a3ad-6d07774fbad2" />

* Create api token in Terraform cloud
<img width="941" alt="image" src="https://github.com/user-attachments/assets/75dbdaff-b2eb-4696-b905-174280b8f6b4" />

* terraform login and provide token
<img width="748" alt="image" src="https://github.com/user-attachments/assets/dd61534c-8a2b-4137-b2f2-b99a1284cbf1" />

* Add AWS credentials as ENV variabels to Workspace to Cloud to access
<img width="716" alt="{CC8A84DC-CCF1-4D19-93DD-7AE2E7B4835B}" src="https://github.com/user-attachments/assets/aad50c81-1a25-453d-a120-cd908f2da660" />

* Terraform apply
<img width="655" alt="image" src="https://github.com/user-attachments/assets/dac99c93-5582-4798-8986-e42048c5dd82" />

### 3. Deliverables

#### Validation Screenshots
<img width="484" alt="{FA21C2AE-5CDF-4649-AB91-CB5DA1438991}" src="https://github.com/user-attachments/assets/de4b5eb4-ceb0-4825-ad3d-94d2ba143fd1" />

#### Reference Guide to Validation
* **Cost Policy CP-2023-45 (Instance Types**) <br>
  **Purpose:** <br>
  A Cost Policy like CP-2023-45 is established by an organization to control and optimize cloud spending. Specifically for      "instance types," it aims to prevent the over-provisioning of resources and ensure that infrastructure deployments align      with budget constraints and performance requirements.
  **Approved List:** <br>
  CP-2023-45 would define a list of approved instance types for different use cases or environments (e.g.,   t2.micro for     
  development/testing, m5.large for general-purpose production, r5.xlarge for memory-intensive workloads). It      might also 
  explicitly prohibit certain expensive or legacy instance types.

  > variable "instance_type" {
  > description = "The EC2 instance type to deploy."
  > type        = string
  > default     = "t2.micro"
  > validation {
  > condition     = contains(["t2.micro", "t3.micro", "m5.large"], var.instance_type)
  >  error_message = "The specified instance type is not approved by Cost Policy CP-2023-45. Please choose from: t2.micro, 
  > t3.micro, m5.large."
  > }
  > }

* **Security Standard SS-205 (region restrictions)** <br>
  **Purpose** <br>
  Security Standard SS-205 (Region Restrictions) is a policy designed to enforce where an organization's data and       
  infrastructure can reside geographically. This is crucial for compliance, data sovereignty, disaster recovery, and network 
  latency considerations.

  > variable "aws_region" {
  > description = "The AWS region to deploy resources into. Must be one of XYZ's enabled regions."
  > type        = string
  > default     = "us-east-1"
  > validation {
  >  condition     = contains(["us-east-1", "us-east-2", "us-west-1", "ap-south-1"], var.aws_region)
  > error_message = "The specified AWS region is not one of XYZ's enabled regions. Please choose from: us-east-1, us-east-2, 
  > us-west-1, ap-south-1."
  > }
  > }

#### Compliance Evidence

##### Terraform Output Screenshot
##### AWS Console Screenshot








