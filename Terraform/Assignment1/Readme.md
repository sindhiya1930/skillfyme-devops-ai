**INFRASTRUCTURE AS CODE IMPLEMENTATION USING TERRAFORM**  <br> <br>
**Authentication Methodology** <br>
**Creation of AWS IAM Credentials** <br>
1.Sign in to the AWS Management Console using your AWS account credentials. <br>
2.Open the IAM (Identity and Access Management) service from the console. <br>
<img width="937" alt="image" src="https://github.com/user-attachments/assets/2d0b5c98-5628-4843-a846-3089d8a8626c" />

3.In the IAM dashboard, navigate to “Users” in the left-hand navigation pane.  <br>
<img width="959" alt="image" src="https://github.com/user-attachments/assets/b01e6c4d-ac51-49cc-ae51-faed86ff8fef" />

4.Select the IAM user for which you want to generate or retrieve the Access Key ID and Secret Access Key. <br>
5.Under the “Security credentials” tab for the selected user, you will find a section labeled “Access keys.” <br>
<img width="927" alt="image" src="https://github.com/user-attachments/assets/842c9eee-fdf9-4e78-a438-1ad28322b784" />

6.If the user doesn’t have any access keys, you can click on the “Create access key” button to generate a new pair of access keys. <br>
7.After creating or selecting an existing access key, you will be able to view the Access Key ID. To view the Secret Access Key, click on the “Show” button in the “Secret access key” column. <br>
8.Make sure to record the Secret Access Key immediately, as AWS will only show it once. <br>
9. Provide necessary permissions to the user <br>
<img width="721" alt="image" src="https://github.com/user-attachments/assets/d08f592f-388f-4c53-96db-f5217819c7bf" />



**Access key best practices**  <br>
Never store your access key in plain text, in a code repository, or in code.  <br>
Disable or delete access key when no longer needed.  <br>
Enable least-privilege permissions.  <br>
Rotate access keys regularly.  <br>


**Configure AWS Cli - Authentication Methodology**  <br>
<img width="700" alt="image" src="https://github.com/user-attachments/assets/6786fabb-66df-400e-8866-0546342ef6eb" />

S3/Dynamod DB creation
aws s3 mb s3://your-terraform-state-bucket --region us-east-1
**Deployment steps** <br>
1.terraform init <br>
<img width="809" alt="image" src="https://github.com/user-attachments/assets/1a344cda-1e33-4b83-8891-0736b2a82346" />

2.terraform plan <br>
<img width="884" alt="image" src="https://github.com/user-attachments/assets/514f44db-9965-4699-bd9e-8403c5c0f858" />

3.terraform apply output <br>
<img width="614" alt="image" src="https://github.com/user-attachments/assets/15ae4a57-f11a-4b1b-83dc-65cdf93091a5" />

**AWS Console EC2 Verification** <br>
<img width="749" alt="image" src="https://github.com/user-attachments/assets/aa4ae681-e998-435f-a124-8a84a0261c7b" />

**AWS Console S3 Verification**<br>
<img width="916" alt="{3E088E96-B8F6-494F-A2E0-D0D4C7A3C756}" src="https://github.com/user-attachments/assets/d34c660b-cd5e-447a-9274-e5a7880bee71" />

**State file in S3**<br>
<img width="744" alt="{662818B0-D41A-4238-9556-1D9327F047F3}" src="https://github.com/user-attachments/assets/6f1f801a-947b-4b55-ab01-3a218a053ecb" />

**Security Group Validation in AWS** <br>
<img width="760" alt="{B9189033-2988-4FB1-B95D-6C421E3A6746}" src="https://github.com/user-attachments/assets/56009f67-0d4c-4736-8cf3-89aec4e64b61" />

**Terraform destroy** <br>
1.terraform destroy <br>
<img width="719" alt="image" src="https://github.com/user-attachments/assets/8ad85564-4fe6-4d0a-a2e1-3473d0717316" />

2.After destroying <br>
<img width="494" alt="image" src="https://github.com/user-attachments/assets/018ae4bc-f852-4f2f-b0f5-8f0e9e126e06" />



