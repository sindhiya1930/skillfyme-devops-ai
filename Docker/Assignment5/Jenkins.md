# CICD Pipeline
## 1. Github repository
https://github.com/sindhiya1930/simple-python-webapp.git

## 2. Configure Jenkins for Docker Hub and AWS EKS

### 2.1 Install Required Plugins
**In Jenkins UI:**

> Go to Dashboard -> Manage Jenkins -> Plugins -> Available plugins.

**Search and install the following plugins:**

* Docker

* Docker Pipeline

* Amazon EC2 Container Service (ECS) (even though we use EKS, this might be useful for underlying AWS integrations, or we might just use AWS CLI directly)

* Kubernetes

* Pipeline: AWS Steps (might be helpful for eksctl or direct AWS SDK calls)

Restart Jenkins after installing plugins if prompted.

### 2.2 Add Docker Hub Credentials
> Go to Dashboard -> Manage Jenkins -> Manage Credentials.

* Click on (global) under Stores scoped to Jenkins.

* Click Add Credentials.

* Select Username with password.

* Scope: Global

    Username: Your Docker Hub username

    Password: Your Docker Hub password

    ID: docker-hub-credentials (This ID will be used in the Jenkinsfile)

    Description: Docker Hub Credentials

### 2.3 Add AWS Credentials
You'll need AWS Access Key ID and Secret Access Key for an IAM user that has permissions to create/update EKS resources, push to ECR (if using ECR instead of Docker Hub, but we are using Docker Hub here, so just EKS permissions are needed), and manage Kubernetes deployments.

> Go to Dashboard -> Manage Jenkins -> Manage Credentials.

* Click on (global) under Stores scoped to Jenkins.

* Click Add Credentials.

* Select AWS Credentials.

    ID: aws-credentials (This ID will be used in the Jenkinsfile)

    Access Key ID: Your AWS Access Key ID

    Secret Access Key: Your AWS Secret Access Key

    Description: AWS Credentials for EKS Deployment

<img width="796" alt="{B428FF9D-5CA4-4360-A606-757AEEDED57D}" src="https://github.com/user-attachments/assets/2461b659-9b2c-4890-a509-b34a7ea112a8" />

### 2.4 Install AWS CLI and kubectl on Jenkins Host
Since the Jenkins container is mounted with /var/run/docker.sock, it can leverage the host's Docker daemon. For kubectl and aws commands, the easiest way is to install them on the Jenkins host machine where Docker is running. Alternatively, you could create a custom Jenkins agent Docker image that includes these tools, or install them dynamically within the pipeline (which can be slower). For this guide, we assume they are on the host.

> Install AWS CLI v2
> curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
> sudo apt install unzip -y
> unzip awscliv2.zip
> sudo ./aws/install
> rm -rf awscliv2.zip aws

> Verify AWS CLI installation
> aws --version
> Install kubectl
> curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
> sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
> Verify kubectl installation
> kubectl version --client
> Install eksctl (recommended for EKS cluster management, though kubectl can be enough for simple deployments)
> For EKS cluster creation, use eksctl. For deployment, kubectl is sufficient.
> You might want to create your EKS cluster beforehand using eksctl or AWS Console.
> curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
> sudo mv /tmp/eksctl /usr/local/bin
> eksctl version
> Configure AWS CLI with your credentials (on the host machine)
> These are the credentials the host's Docker daemon uses, which Jenkins can then leverage via its socket mount.
> This setup is critical for 'aws eks update-kubeconfig' to work inside the pipeline.
> aws configure
> Enter your AWS Access Key ID, Secret Access Key, default region, and default output format.

## 3. Create Jenkins Pipeline (Jenkinsfile)
