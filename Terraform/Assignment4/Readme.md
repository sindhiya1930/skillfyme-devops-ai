# Standardizing Terraform Configurations for Enterprise Reuse

## Assignment #4 Implementation

This repository contains the Terraform configurations and supporting documentation for **Assignment #4: Standardizing Terraform Configurations for Enterprise Reuse**. This assignment focuses on implementing dynamic blocks in Terraform to manage security group rules efficiently and compliantly, addressing common enterprise challenges related to port exposures and manual configuration efforts.

---

### Table of Contents

1.  [Overview](#overview)
2.  [Deliverables](#deliverables)
    * [Compliance Documentation](#2-compliance-documentation)
3.  [Setup and Execution](#setup-and-execution)
    * [Prerequisites](#prerequisites)
    * [Configuration](#configuration)
    * [Execution Steps](#execution-steps)

---

## Overview

In enterprise environments, managing network access and security group rules can be complex and error-prone, especially when dealing with multiple applications and changing port requirements. This assignment demonstrates the use of **Terraform dynamic blocks** to:

* Dynamically generate security group ingress/egress rules based on a list of allowed ports.
* Enforce security policies (Port Standards, Flow Control) through code.
* Reduce manual configuration and review efforts.
* Provide robust validation for non-compliant port definitions.

This approach ensures that security group configurations are standardized, maintainable, and aligned with organizational compliance requirements.

---

## Deliverables

### Compliance Documentation

* **Mapping of dynamic rules to:**

    * **BSS-2024-01 Section 3.2 (Port Standards):**
        * The `allowed_ports` variable directly reflects the list of approved ports as defined in BSS-2024-01 Section 3.2 (Port Standards).
        * The dynamic `ingress` block iterates over this list, ensuring that only these explicitly approved ports are opened. Any attempt to introduce non-standard ports via `security_rules.tfvars` would be caught by validation.

    * **NIST Control AC-4 (Flow Control):**
        * The use of dynamic blocks to explicitly define allowed ingress/egress rules enforces network flow control by ensuring that only necessary and approved traffic paths are established.
        * This direct mapping of approved ports into security group rules directly supports AC-4, which mandates controlling information flow between system components.

* **Exception request process for additional ports:**
    * To add an additional port not currently in the `allowed_ports` list, an formal exception request process must be followed.
    * This typically involves:
        1.  Submitting a request to the Security Review Board (SRB) or equivalent.
        2.  Providing a business justification, risk assessment, and compensating controls.
        3.  Upon approval, the `allowed_ports` list in the `security_rules.tfvars` (or environment-specific `tfvars` file) would be updated by an authorized engineer, followed by a Terraform apply.
        4.  Documentation of the approval (e.g., ticket ID, change record) must be maintained.

---

## Setup and Execution

### Prerequisites

* Terraform CLI installed.
* AWS account configured with appropriate credentials (e.g., via `~/.aws/credentials` or environment variables).
* A VPC and subnet where the security group can be deployed.

### Configuration

1.  **Clone the Repository:**
    ```bash
    git clone <repository-url>
    cd <repository-directory>
    ```
2.  **Define Variables:**
    * Open `security_rules.tfvars` (or `security_rules.tfvars.example` and rename it).
    * Update `allowed_ports` with the list of ports allowed by BSS-2024-01 Section 3.2.

    ```terraform
    # security_rules.tfvars
    allowed_ports = [80, 443, 22] # XYZ's approved ports
    ```

3.  **Add validation for `allowed_ports` in `variables.tf` (if not already present):**
    * To enforce the "invalid port" check, you'd typically have a validation block on the `allowed_ports` variable itself, comparing it against a master list.

    ```terraform
    # variable "allowed_ports" {
    description = "Ports to be added"
    type = list(number)
    validation {
    condition = alltrue([for port in var.allowed_ports: contains([22,443,80],ports)])
    error_message= "Valid ports are 22,80,443"
    }
    }  
    ```

### Execution Steps

1.  **Initialize Terraform:**
    ```bash
    terraform init
    ```
       <img width="696" alt="image" src="https://github.com/user-attachments/assets/c6fff7c4-9ef8-4297-b916-f8e654a6212a" />

2.  **Test Invalid Port (Validation):**
    * Temporarily modify `security_rules.tfvars` to include a non-compliant port (e.g., `allowed_ports = [80, 443, 22, 10000]`).
    * Run `terraform plan` to observe the validation error.
    ```bash
    terraform plan
    ```
    <img width="736" alt="{8FA6386D-2102-48C9-B259-F22F7259DB70}" src="https://github.com/user-attachments/assets/5bdcbbc9-2717-444d-bd67-e7932e3d4352" />

3.  **Test Valid Ports and Plan Expansion:**
    * Ensure `security_rules.tfvars` contains only valid ports (e.g., `allowed_ports = [80, 443, 22]`).
    * Run `terraform plan` to see the dynamic block expand into individual ingress rules.
    ```bash
    terraform plan
    ```
   <img width="624" alt="{2EC5E850-8355-43F2-BAD6-6C74029E2C7B}" src="https://github.com/user-attachments/assets/47abb8b3-1298-4faf-b96b-d2cff4e1f0b4" />

   <img width="861" alt="image" src="https://github.com/user-attachments/assets/1a77ed2f-95d2-47de-9e90-b1a766aa290a" />

<img width="836" alt="image" src="https://github.com/user-attachments/assets/687e9ba8-ad7a-4258-9ae7-51a8d036b573" />

4.  **Apply Configuration:**
    ```bash
    terraform apply --auto-approve
    ```

5.  **Verify in AWS Console:**
    * Go to the EC2 -> Security Groups section in the AWS console and inspect the created security group to confirm the ingress rules match the `allowed_ports`.
   <img width="716" alt="image" src="https://github.com/user-attachments/assets/20b2c2cb-a97e-46bf-8660-2e00ed6cdb02" />


7.  **Clean Up:**
    ```bash
    terraform destroy --auto-approve
    ```
---











