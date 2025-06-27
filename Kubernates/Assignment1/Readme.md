# Setting up of kubernates Cluster
## Problem statement 
Setting up of the kubernates cluster with AWS and Checkig on Node failure

## Installation in EKS
### 1. **IAM Roles to be created**
***1. Roles: EKS***
   
   EKS:Cluster
   
   Policy:
   
     AmazonEKSClusterPolicy
   
***2. Roles: EC2***
   
   Policy:
   
     AmazonEKS_CNI_Policy
   
     AmazonEKSWorkerNodePolicy
   
     AmazonEc2ContainerRegistryReadOnlyPOlicy

### 2. **Create Cluster**

![image](https://github.com/user-attachments/assets/08f70db7-cc5e-4423-9275-73ce03390776)

![image](https://github.com/user-attachments/assets/9137620f-b4d5-44fc-be34-41d02b37aa2b)

![image](https://github.com/user-attachments/assets/dfb935c8-893f-4ceb-b276-6c678ab5bc37)

![image](https://github.com/user-attachments/assets/c716c662-ff1d-4d55-b1ad-d2d3ee2b08fa)

### 3. **Add node group under compute**

![image](https://github.com/user-attachments/assets/5e7bda2b-2212-4cf6-8292-caa3bd3b0f08)

![image](https://github.com/user-attachments/assets/bf4a5f57-0e59-47db-adc0-c2f6e68fb115)

![image](https://github.com/user-attachments/assets/5f33fd52-1e07-4784-a5b7-4ffa19a1d631)

### 4. Install AWS LI and Kubectl, Configure AWS and Update kubeconfig
   > configure aws
   > aws eks update-kubeconfig --name skillfyme

Added new context arn:aws:eks:us-east-1:248167063816:cluster/skillfyme to /root/.kube/config


## Node Failure stimulation
### Phase 1: Pre-Failure Observation
#### Check Node Status: Verify all your nodes are in Ready state.
> kubectl get nodes

#### Check Pod Distribution and Status: Observe which nodes your application pods are running on.
> kubectl get pods -o wide

![image](https://github.com/user-attachments/assets/7f3ee948-2ee4-4b76-956c-73e943331547)

### Phase 2: Simulate Node Failure
#### Identify an EC2 Instance ID
Choose one of the worker nodes you noted in the previous step. Get its corresponding EC2 Instance ID. You can find this by:
Looking at the NODE column from kubectl get pods -o wide. The node name is typically the private DNS name of the EC2 instance.
Go to the EC2 console in AWS, search for instances by their private DNS name, and copy the Instance ID.
Alternatively, use the AWS CLI:
> (Replace <node-private-dns-name> with one of your node names from 'kubectl get nodes')
> aws ec2 describe-instances --filters "Name=private-dns-name,Values=<node-private-dns-name>" --query "Reservations[*].Instances[*].InstanceId" --output text
*Example output: i-0abcdef1234567890*

![image](https://github.com/user-attachments/assets/0511282a-e707-436e-86ab-0f1b181e4e2f)

#### Stop the EC2 Instance: This simulates a sudden, unexpected node failure (e.g., power loss).
> (Replace <your-instance-id> with the actual ID you found)
> aws ec2 stop-instances --instance-ids <your-instance-id>

![image](https://github.com/user-attachments/assets/8a8ecc9b-c9c3-4178-b7db-b6c6985d77a0)

### Phase 3: Observe Kubernetes Recovery
#### Monitor Node Status: Immediately start watching the node status.
> watch kubectl get nodes
*Expected observations:*
*Initially, the node might still show Ready.*
*After a short period (usually a minute or two), the node status will change to NotReady. This means kubelet on that node is no longer communicating with the control plane.*
*After a default pod-eviction-timeout (typically 5 minutes for EKS), Kubernetes will mark the pods on the NotReady node as Unknown or NodeLost.*

![image](https://github.com/user-attachments/assets/330bc9b8-a4cd-42e2-b660-83caba0f24e5)

#### Monitor Pod Status: In a separate terminal, watch your application pods.
> watch kubectl get pods -o wide
*Expected observations:
Pods on the failed node will eventually show Terminating or Unknown status.
Crucially, new pods for your nginx-deployment (if you have replicas > 1) will be scheduled on the remaining healthy nodes. You will see new pods enter ContainerCreating and then Running states on the healthy nodes.
The ReplicaSet associated with your Deployment ensures that the desired number of replicas (3 in our nginx-deployment example) is maintained.*

![image](https://github.com/user-attachments/assets/c6edf099-2274-4336-8e88-887f981ffb98)


### Observe EKS Managed Node Group Auto-Repair
If you are using EKS Managed Node Groups with "Node Auto Repair" enabled (which is recommended and often enabled by default for new node groups), observe what happens to the stopped EC2 instance:
* Go to your AWS EC2 console. You might see the stopped instance eventually changing status back to Running (if it was a soft failure) or a new EC2 instance being provisioned to replace it (if the original instance was deemed irrecoverable). EKS Managed Node Groups will try to bring the node count back to the desired state.
* You can also check the EKS console for your cluster, under "Node groups," to see the health and desired/current node count.

### Confirm Full Recovery:
Continue watching kubectl get nodes and kubectl get pods -o wide until:
All desired nodes are Ready again (either the old one came back, or a new one replaced it).
All your application pods are Running and distributed across the healthy nodes, maintaining the desired replica count
> kubectl get nodes
> kubectl get pods -o wide











