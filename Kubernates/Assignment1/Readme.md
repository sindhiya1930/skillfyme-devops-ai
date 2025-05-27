#Kubernates
Installation in EKS
1. **IAM Roles to be created**
***1. Roles: EKS***
   
   EKS:Cluster
   
   Policy:
   
     AmazonEKSClusterPolicy
   
***2. Roles: EC2***
   
   Policy:
   
     AmazonEKS_CNI_Policy
   
     AmazonEKSWorkerNodePolicy
   
     AmazonEc2ContainerRegistryReadOnlyPOlicy

2. **Create Cluster**

![image](https://github.com/user-attachments/assets/08f70db7-cc5e-4423-9275-73ce03390776)

![image](https://github.com/user-attachments/assets/9137620f-b4d5-44fc-be34-41d02b37aa2b)

![image](https://github.com/user-attachments/assets/dfb935c8-893f-4ceb-b276-6c678ab5bc37)

![image](https://github.com/user-attachments/assets/c716c662-ff1d-4d55-b1ad-d2d3ee2b08fa)

3. **Add node group under compute**

![image](https://github.com/user-attachments/assets/5e7bda2b-2212-4cf6-8292-caa3bd3b0f08)

![image](https://github.com/user-attachments/assets/bf4a5f57-0e59-47db-adc0-c2f6e68fb115)

![image](https://github.com/user-attachments/assets/5f33fd52-1e07-4784-a5b7-4ffa19a1d631)

4. install in local -> aws cli and kubectl
   configure aws
   root@ip-172-31-18-234:~# aws eks update-kubeconfig --name sk
Added new context arn:aws:eks:us-east-1:248167063816:cluster/skillfyme to /root/.kube/config

5.






