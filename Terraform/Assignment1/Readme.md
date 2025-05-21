**Creation of AWS IAM Credentials**
1.Sign in to the AWS Management Console using your AWS account credentials.
2.Open the IAM (Identity and Access Management) service from the console.
<img width="937" alt="image" src="https://github.com/user-attachments/assets/2d0b5c98-5628-4843-a846-3089d8a8626c" />

3.In the IAM dashboard, navigate to “Users” in the left-hand navigation pane.
<img width="959" alt="image" src="https://github.com/user-attachments/assets/b01e6c4d-ac51-49cc-ae51-faed86ff8fef" />

4.Select the IAM user for which you want to generate or retrieve the Access Key ID and Secret Access Key.
5.Under the “Security credentials” tab for the selected user, you will find a section labeled “Access keys.”
<img width="927" alt="image" src="https://github.com/user-attachments/assets/842c9eee-fdf9-4e78-a438-1ad28322b784" />

6.If the user doesn’t have any access keys, you can click on the “Create access key” button to generate a new pair of access keys.
7.After creating or selecting an existing access key, you will be able to view the Access Key ID. To view the Secret Access Key, click on the “Show” button in the “Secret access key” column.
8.Make sure to record the Secret Access Key immediately, as AWS will only show it once.
9. Provide necessary permissions to the user
<img width="721" alt="image" src="https://github.com/user-attachments/assets/d08f592f-388f-4c53-96db-f5217819c7bf" />



**Access key best practices**
Never store your access key in plain text, in a code repository, or in code.
Disable or delete access key when no longer needed.
Enable least-privilege permissions.
Rotate access keys regularly.


**Configure AWS Cli - Authentication Methodology**
<img width="700" alt="image" src="https://github.com/user-attachments/assets/6786fabb-66df-400e-8866-0546342ef6eb" />

**Deployment steps**
1.terraform init
<img width="809" alt="image" src="https://github.com/user-attachments/assets/1a344cda-1e33-4b83-8891-0736b2a82346" />

2.terraform plan
<img width="884" alt="image" src="https://github.com/user-attachments/assets/514f44db-9965-4699-bd9e-8403c5c0f858" />

3.terraform apply
<img width="614" alt="image" src="https://github.com/user-attachments/assets/15ae4a57-f11a-4b1b-83dc-65cdf93091a5" />

**Successfully created**
<img width="749" alt="image" src="https://github.com/user-attachments/assets/aa4ae681-e998-435f-a124-8a84a0261c7b" />

**Terraform destroy**
1.terraform destroy
<img width="719" alt="image" src="https://github.com/user-attachments/assets/8ad85564-4fe6-4d0a-a2e1-3473d0717316" />

2.After destroying
<img width="494" alt="image" src="https://github.com/user-attachments/assets/018ae4bc-f852-4f2f-b0f5-8f0e9e126e06" />



