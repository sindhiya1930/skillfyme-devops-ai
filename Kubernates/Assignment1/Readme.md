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
   root@ip-172-31-18-234:~# aws eks update-kubeconfig --name skillfyme
Added new context arn:aws:eks:us-east-1:248167063816:cluster/skillfyme to /root/.kube/config

Metric server

<img width="636" alt="image" src="https://github.com/user-attachments/assets/3ac40870-d455-49e4-b305-17fd6c02b72b" />

Application.yml
<img width="632" alt="image" src="https://github.com/user-attachments/assets/b0f6a8b8-98a2-45c7-b11e-31e427539d4f" />

deploy HPA min 3 max 10 per:50%
kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10
<img width="925" alt="image" src="https://github.com/user-attachments/assets/06aa5b2c-5ac4-41a2-b783-e8b82fa8a690" />

HPA deployed


<img width="660" alt="image" src="https://github.com/user-attachments/assets/f5a07119-9cf2-4164-92c8-f763a515919c" />

Stress test

kubectl run -i --tty load-generator --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://php-apache; done"
![image](https://github.com/user-attachments/assets/1121db6b-cfaa-41c5-9187-6f7570e2c809)

Replicas incresed to 7
<img width="894" alt="image" src="https://github.com/user-attachments/assets/3afdb747-6ebb-4933-a2fb-e467da1e9fd8" />

evenly distributed and is stable
<img width="866" alt="image" src="https://github.com/user-attachments/assets/8ddec625-7999-4525-8b4b-fd7544679156" />









