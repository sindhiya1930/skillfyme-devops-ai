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


**Access key best practices**
Never store your access key in plain text, in a code repository, or in code.
Disable or delete access key when no longer needed.
Enable least-privilege permissions.
Rotate access keys regularly.


**Configure AWS Cli**
<img width="700" alt="image" src="https://github.com/user-attachments/assets/6786fabb-66df-400e-8866-0546342ef6eb" />




