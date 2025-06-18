#  Implementing Secure Container Networking with Docker CNIs

## Problem Statement
A financial services company is running Golang-based microservices in a containerized environment. Due to security concerns, they want to implement network isolation between different services while ensuring inter-service communication is still possible where necessary.

## Step-by-Step Commands to Build and Run the Docker Image

### Prerequisites
* Multiple Linux VMs or physical machines (e.g., 1 manager, 1+ workers).
* Docker Engine installed on all machines (Docker CE or EE).
* sudo privileges on all machines.
* Basic understanding of Docker, Docker Swarm, and Go.


## Setup Instructions
### 1. Docker Swarm Initialization
On your designated manager node:
![image](https://github.com/user-attachments/assets/3632e14d-4f4e-4e35-945e-8f8097747ed3)

Verify Swarm (on manager):
![image](https://github.com/user-attachments/assets/fadb194c-2203-4217-8423-ce18443d7a54)

### 2. etcd Cluster Setup (Calico Datastore)
docker run -d --name etcd-calico --publish 2379:2379 --publish 2380:2380 --mount type=volume,source=etcd-data,target=/etcd-data quay.io/coreos/etcd:v3.5.0 etcd --name etcd-0 --data-dir /etcd-data --initial-cluster-state new --initial-cluster-token etcd-cluster-1 --initial-advertise-peer-urls http://52.91.71.238:2380 --listen-peer-urls http://0.0.0.0:2380 --advertise-client-urls http://52.91.71.238:2379 --listen-client-urls http://0.0.0.0:2379 --initial-cluster etcd-0=http://52.91.71.238:2380

![image](https://github.com/user-attachments/assets/38ff14f2-ad72-4feb-9131-f443d7c3b89e)

### 3. Install Calico Node on Each Swarm Node
#### 1. Download calicoctl and configure calico
> sudo curl -L https://github.com/projectcalico/calico/releases/download/v3.27.0/calicoctl-linux-amd64 -o /usr/local/bin/calicoctl
> sudo chmod +x /usr/local/bin/calicoctl

> mkdir -p /etc/calico 
> cat <<EOF | sudo tee /etc/calico/calicoctl.cfg 
> apiVersion: projectcalico.org/v3 
> kind: CalicoAPIConfig 
> metadata: 
> 	name: calicoctl-config 
> spec: 
> 	datastoreType: etcdv3 
> 	etcdEndpoints: http://52.91.71.238:2379 
> EOF


#### 2. Run calico/node Container:
docker run --net=host --privileged --name=calico-node  --restart=always  -e ETCD_ENDPOINTS=http://52.91.71.238:2379  -e CALICO_NODENAME=$(hostname)  -e IP_AUTODETECTION_METHOD=interface=eth.*,enp.*,ens.*  -e CALICO_LIBNETWORK_LABEL_ENDPOINTS=true  -v /var/run/docker.sock:/var/run/docker.sock  -d calico/node:v3.27.0

<img width="942" alt="{A987D10B-2CE7-4431-99B4-EC4A8B3EFF28}" src="https://github.com/user-attachments/assets/3c5a1d6e-dab9-42e4-9e18-8825ce8d376d" />

#### 3. Verify status of calico node
<img width="317" alt="{7A422951-87A1-4433-A6FE-96337AD68521}" src="https://github.com/user-attachments/assets/b2cc64df-84fd-453e-855f-609b0116972d" />

#### 4. Create Docker Overlay Network

<img width="567" alt="{2333268B-8B21-478D-AEE0-D2A40E2301E8}" src="https://github.com/user-attachments/assets/2afafd9f-7d9f-4b47-8422-5cd4394e817b" />

### 4. Docker image creation and stack deployment
* SERVICE A: 
<img width="831" alt="{7BBEBE1E-601A-460F-B42E-70E244042DF7}" src="https://github.com/user-attachments/assets/53c38d7d-f556-4c78-a083-add7f96d3fe1" />

* SERVICE B:
<img width="817" alt="{7026695F-D8DE-484F-9CEB-95FD58A8F355}" src="https://github.com/user-attachments/assets/fad7ccf2-c0fa-4d1e-ac41-aa9e6a0ae8be" />

* SERVICE C:
<img width="943" alt="{07A57FFD-B138-4456-92ED-FAB0C420B689}" src="https://github.com/user-attachments/assets/a507cc59-50b3-4739-81ad-9e5535879a10" />

DOCKER IMAGES:
<img width="642" alt="{E665AA04-1737-4D9E-97F7-A5F73D3D6091}" src="https://github.com/user-attachments/assets/3fdd4f38-738e-4769-9690-ea4a5506cb73" />

### 5. Deploy the Services:
> docker stack deploy -c docker-compose.yml my-app
<img width="773" alt="{CEFE4B40-8DF5-4322-A34E-5B378F41A515}" src="https://github.com/user-attachments/assets/af9d1d9b-3774-4ac6-93ea-77072ee7d77f" />

### 6. Calico Network Policy Definition and Application
#### 1. Policies
* **Policy 1:** Allow Service A and Service B to communicate. Create allow-a-b.yaml
* **Policy 2:** Restrict Service C from communicating with Service A. Create deny-c-to-a.yaml

#### 2. Apply the Policies (on Swarm Manager):
> calicoctl apply -f allow-a-b.yaml
> calicoctl apply -f deny-c-to-a.yaml

### 7. Verification
#### 1. Docker services

A: 
<img width="846" alt="{D2BE8BE0-FA68-45A7-BC68-0CD895BD2C8B}" src="https://github.com/user-attachments/assets/36118a55-14ef-4b21-9bce-d1d591091b35" />
B:
<img width="942" alt="{B2FD3C7C-8D50-4795-8634-ACA35BDE8E36}" src="https://github.com/user-attachments/assets/7e714292-ba9b-49dc-b967-78523f8f1240" />
C:
<img width="952" alt="{7CAE5979-4353-42AE-9DE5-E08A812FD96C}" src="https://github.com/user-attachments/assets/60745a42-26c9-45cb-89fa-dd91ad18652b" />

#### 2. Monitor Service C Logs (on Swarm Manager):
> docker service logs -f my-app_service-c

<img width="942" alt="{D4B67BCC-C54E-419E-94EA-35E155FB023D}" src="https://github.com/user-attachments/assets/d6d3e100-604f-462f-8b18-5bcb100f7aac" />

---
### 8. Deep Dive Question 
#### How does Swarm mode handle node failures and ensure high availability?
**Docker Swarm mode ensures high availability through:**
Manager Redundancy (Raft Consensus): Managers replicate the Swarm state using Raft. An odd number (e.g., 3 or 5) maintains a quorum, allowing the Swarm to function even if some managers fail. A new leader is elected automatically if the current one goes down.
Worker Self-Healing: The Swarm scheduler continuously monitors service replicas. If a worker node or a task on it fails, the scheduler automatically reschedules the affected tasks onto healthy worker nodes, maintaining the desired service state.
Resilient Overlay Networks: Swarm's built-in overlay networks allow containers across nodes to communicate and are resilient to node failures, cleaning up and re-establishing endpoints as tasks move.
Rolling Updates & Load Balancing: Services can be updated without downtime via rolling updates. Swarm's routing mesh provides load balancing across healthy replicas, further enhancing availability.

#### Justification of Design Choices
**Docker Swarm for Orchestration:**
Simplicity: Easier to set up and manage for smaller to medium-sized deployments compared to Kubernetes.
Native Integration: Seamlessly integrates with Docker Engine's existing features.
High Availability: Offers built-in manager redundancy and service self-healing.

**Calico for Network Policy:**
Fine-grained Control: Enables detailed service-to-service communication rules beyond basic network segmentation.
Label-based Policies: Policies can be defined using Docker service labels, making them dynamic, scalable, and easy to manage.
Layer 3 Networking: Operates efficiently at the IP layer, often improving performance and simplifying troubleshooting.
Industry Standard: A widely adopted, robust CNI solution for containerized environments.

**Go Microservices:**
Lightweight and Efficient: Go binaries are small and compiled statically, ideal for minimal container images.
Concurrency: Go's built-in concurrency features are well-suited for network services.
Simplicity: The services are kept simple to clearly demonstrate the core networking and policy concepts.
This combination allows for a robust, scalable, and secure containerized environment with clear network segmentation based on application roles and requirements.
---
