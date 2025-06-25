# Kubernates Cluster Architecture

## Diagram

![image](https://github.com/user-attachments/assets/01abfbc0-2a70-44fa-8c9e-ac8aca4300da)


## Brief Explanation of Components:
A Kubernetes cluster is broadly divided into two main parts: the Control Plane (formerly Master Node) and Worker Nodes (formerly Minion Nodes).

### I. Control Plane (Master Node)
The Control Plane is the brain of the Kubernetes cluster. It manages and orchestrates the worker nodes and the pods running on them. Ideally, for high availability, you'd have multiple control plane nodes.

#### Key Components of the Control Plane:

* **kube-apiserver:**

Acts as the frontend for the Kubernetes control plane.

Exposes the Kubernetes API, which is used by all other components and external users (via kubectl).

Validates and configures data for API objects like pods, services, and deployments.

* **etcd:**

A highly available, distributed, and consistent key-value store.

Stores all cluster data, including configuration data, state, and metadata of all Kubernetes objects.

Crucial for the cluster's health and operation.

* **kube-scheduler:**

Watches for newly created pods with no assigned node.

Selects the optimal node for the pod to run on, considering factors like resource requirements, hardware constraints, policy constraints, and affinity/anti-affinity specifications.

* **kube-controller-manager:**

Runs various controller processes that regulate the state of the cluster.

Each controller is a separate process, but they are compiled into a single binary to reduce complexity.

**Examples of controllers:**

*Node Controller*: Responsible for noticing and responding when nodes go down.

*Replication Controller*: Maintains the desired number of pods for a replication controller object.

*Endpoints Controller*: Populates the Endpoints object, which joins Services and Pods.

*Service Account & Token Controllers*: Create default accounts and API access tokens for new namespaces.

### II. Worker Nodes (Minion Nodes)
Worker nodes are the machines (VMs or physical servers) where the actual containerized applications (Pods) run. Each worker node has the necessary components to run and communicate with the Control Plane.

#### Key Components of Worker Nodes:

* **Kubelet:**

An agent that runs on each node in the cluster.

Ensures that containers are running in a Pod.

Receives Pod specifications from the API server and ensures that the described containers are healthy and running.

Reports the health and status of the node and its pods to the Control Plane.

* **Kube-proxy:**

A network proxy that runs on each node.

Maintains network rules on nodes, allowing network communication to your Pods from inside or outside of the cluster.

Handles service discovery and load balancing for pods.

Container Runtime (e.g., Docker, containerd, CRI-O):

The software responsible for running containers.

Kubernetes supports various container runtimes that implement the Container Runtime Interface (CRI). Docker was traditionally popular, but containerd and CRI-O are also widely used.

* **Pods:**

The smallest deployable units of computing that can be created and managed in Kubernetes.

A Pod represents a single instance of a running process in your cluster.

Pods encapsulate one or more containers (e.g., a web server and a helper sidecar), storage resources, a unique network IP, and options that govern how the containers should run.

**How they interact:**

Users interact with the cluster primarily through the kubectl command-line tool, which communicates with the kube-apiserver.

The kube-apiserver is the central hub for all communication and state changes within the cluster.

The kube-scheduler places new pods on suitable worker nodes.

The kube-controller-manager ensures that the desired state of the cluster is maintained (e.g., if a node fails, it reschedules pods).

On the worker nodes, kubelet manages the lifecycle of pods and their containers, while kube-proxy handles network connectivity to these pods.

etcd stores all the cluster's persistent state, making it resilient to control plane component failures.
