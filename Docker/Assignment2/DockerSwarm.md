# Deploying a Scalable Web App using Docker Swarm

## Assignment #2

### Problem Statement:

A startup wants to launch a Node.js-based web application in a highly available and scalable manner. They want to deploy it on multiple nodes using Docker Swarm with proper service discovery and load balancing.

---

## Table of Contents

1.  [Introduction](#introduction)
2.  [Prerequisites](#prerequisites)
3.  [Task Steps & Explanation](#task-steps--explanation)
    * [Task 1: Create a Dockerfile for the Node.js web application](#task-1-create-a-dockerfile-for-the-nodejs-web-application)
    * [Task 2: Set up Docker Swarm and configure at least three services (Web, API, Database)](#task-2-set-up-docker-swarm-and-configure-at-least-three-services-web-api-database)
    * [Task 3: Deploy the services using Docker Compose and Swarm mode](#task-3-deploy-the-services-using-docker-compose-and-swarm-mode)
    * [Task 4: Configure overlay networks to enable communication between services](#task-4-configure-overlay-networks-to-enable-communication-between-services)
    * [Task 5: Implement rolling updates and service scaling](#task-5-implement-rolling-updates-and-service-scaling)
    * [Task 6: Demonstrate load balancing with multiple instances](#task-6-demonstrate-load-balancing-with-multiple-instances)
4.  [Deep Dive Question](#deep-dive-question)
5.  [DockerHub Links (Placeholder)](#dockerhub-links-placeholder)

---


### 1. Introduction

This assignment focuses on deploying a scalable and highly available Node.js web application using Docker Swarm. Docker Swarm is a native clustering solution for Docker that allows you to turn a pool of Docker hosts into a single, virtual Docker host. This enables the deployment and management of applications across multiple machines, providing features like service discovery, load balancing, and fault tolerance.

The project will involve containerizing a Node.js application, setting up a Docker Swarm cluster, defining services for different application components (Web, API, Database), and demonstrating key Swarm features such as scaling, rolling updates, and load balancing.

### 2. Prerequisites

Before you begin, ensure you have the following installed on your system(s):

* **Docker Desktop (for Windows/macOS)** or **Docker Engine (for Linux)**: Make sure Docker is installed and running.
* **Multiple machines (VMs or physical)**: For a true Swarm demonstration, it's recommended to have at least three machines (one manager, two workers). For a basic setup, you can simulate a multi-node environment on a single machine using Docker Desktop's built-in Swarm capabilities or by creating multiple Docker Machine instances.
* **Node.js application**: A simple Node.js application with a basic API is required. For this assignment, a "sample Node.js application with a simple API" is sufficient (as per Dataset Requirement).

### 3. Task Steps & Explanation

This section details each task and provides a clear explanation of the steps involved.

### Task 1: Create a Dockerfile for the Node.js web application

**Goal**: To containerize your Node.js web application.

**Explanation**: A `Dockerfile` is a text document that contains all the commands a user could call on the command line to assemble an image. For a Node.js application, this typically involves:
1.  Specifying a base image
2.  Setting a working directory.
3.  Copying `package.json` and `package-lock.json` (if used) to install dependencies.
4.  Installing dependencies.
5.  Copying the rest of the application code.
6.  Exposing the port the application listens on.
7.  Defining the command to run the application.

### Task 2: Set up Docker Swarm and configure at least three services (Web, API, Database)

**Goal**: To initialize a Docker Swarm cluster and define the core services for your application.

**Explanation**:

Docker Swarm Initialization: You need to initialize one of your Docker hosts as a Swarm manager. Other hosts will then join this manager as workers.
Services: In Docker Swarm, a "service" is the definition of the tasks to be executed on the manager or worker nodes. Services are defined in a docker-compose.yml file (for Docker Swarm, this is often referred to as a "stack file").

**Steps**

1. Initialize Swarm Manager:

<img width="959" alt="{C061C1A0-38E7-44B4-B6EC-F9F4EA33474D}" src="https://github.com/user-attachments/assets/99c7a3c3-f986-439f-bd61-d49d251919aa" />

2. Verify Swarm Status:

<img width="913" alt="image" src="https://github.com/user-attachments/assets/996421f6-9b0c-4a8c-9dd4-4ceb36be9faf" />


3. Configure Services in docker-compose.yml
   
### Task 3: Deploy the services using Docker Compose and Swarm mode
**Goal**: To deploy your defined services as a stack on the Docker Swarm cluster.

**Explanation**: Once your docker-compose.yml is ready, you can deploy it as a "stack" in Docker Swarm mode. This command parses the Compose file, creates the services, and schedules them across the Swarm nodes.

**Step**:

* **Deploy the Stack**:
Navigate to the directory containing your docker-compose.yml file on the Swarm manager and run:

> docker stack deploy -c docker-compose.yml myapp

<img width="949" alt="{B8FAD436-5FC1-491A-B7E4-4C9DD96135ED}" src="https://github.com/user-attachments/assets/6e145022-a4f0-4dfe-9b1d-4c1a4c4a7c88" />

* **Verify Deployment:**
Check the deployed services:

>docker stack services myapp
> docker service ls

You should see your web, api, and mongodb services running.

<img width="950" alt="{C22CA134-EE87-44EE-AACA-D951D6944CEF}" src="https://github.com/user-attachments/assets/6125e3bf-fa59-4d84-a759-443e2e855b9a" />

### Task 4: Configure overlay networks to enable communication between services
**Goal**: To ensure that your services can communicate with each other across different nodes in the Swarm.

**Explanation**: Docker Swarm uses overlay networks for inter-service communication. When you define a network with driver: overlay in your docker-compose.yml, Docker Swarm automatically creates and manages this network across all participating nodes. Services connected to the same overlay network can communicate with each other using their service names as DNS hostnames.

**Steps**:

This was already implicitly covered in Task 2 and 3 by defining app_network with driver: overlay in docker-compose.yml and attaching all services to it.
Verification: You can verify the network creation:
> docker network ls

You should see myapp_app_network (or similar, based on your stack name and network name). You can also inspect the network:

> docker network inspect myapp_app_network

### Task 5: Implement rolling updates and service scaling
**Goal**: To demonstrate how Docker Swarm handles updates to services without downtime and how to dynamically adjust the number of service replicas.

**Explanation**:

Rolling Updates: Docker Swarm allows you to update a service by deploying a new image or configuration. It replaces old tasks with new ones one by one, ensuring that the application remains available during the update process. The update_config in docker-compose.yml helps control this process.

**Steps for Rolling Updates**:

* **Make a Change to your Application**:
Modify your web-app or api-service code (e.g., change a message, update a dependency) to simulate a new version.

* **Rebuild and Push (if using a registry like DockerHub)**:
If you're using DockerHub or a private registry, build the new image and push it

* **Deploy the Update**:
Redeploy the stack. Swarm will detect the image change and perform a rolling update.
> docker stack deploy -c docker-compose.yml myapp

<img width="947" alt="{F22AF5F1-65A6-4404-8DA6-BBAB467A584A}" src="https://github.com/user-attachments/assets/2dcbaa8f-0858-4026-8362-4a6cdd160af8" />

* Rollback Strategy:

Be prepared to roll back to a previous stable version in case a new deployment introduces critical errors. Docker Swarm allows for easy rollback using 

> docker service update --rollback <service_name>.

### 5. Deep Dive Question
**How does Swarm mode handle node failures and ensure high availability?**
Docker Swarm is designed with high availability and fault tolerance in mind. It handles node failures primarily through the following mechanisms:

Decentralized Orchestration and Consensus (Raft Consensus Algorithm):

Swarm managers maintain the cluster state using the Raft consensus algorithm. This means the cluster state is replicated across multiple manager nodes.
If a manager node fails, the remaining managers can elect a new leader, ensuring that the Swarm cluster itself remains operational and can continue to manage services. For high availability of the Swarm manager, it's recommended to have an odd number of manager nodes (e.g., 3 or 5).
Desired State Reconciliation:

Docker Swarm constantly monitors the actual state of the cluster (which tasks are running on which nodes) and compares it to the desired state (defined in your docker-compose.yml or service configuration).
If a node fails (e.g., crashes, loses network connectivity), the tasks running on that node will become unhealthy or disappear from the actual state.
Swarm's orchestrator detects this discrepancy and automatically reschedules those failed tasks onto healthy worker nodes in the cluster. This happens transparently, ensuring that the desired number of replicas for a service is maintained.
Ingress Routing Mesh (Load Balancing):

The ingress routing mesh ensures that even if a node hosting a service fails, incoming requests to that service's published port can still be received by any healthy node in the Swarm.
If the original node handling the request is no longer available, the routing mesh will redirect the traffic to a healthy replica of the service running on another node. This provides resilience at the network entry point.
Health Checks and Restart Policies:

Services can be configured with health checks (healthcheck in docker-compose.yml). If a container within a service becomes unhealthy, Swarm can detect this and restart the container or reschedule it.
restart_policy in deploy section (e.g., on-failure) ensures that if a container exits with an error, Swarm will attempt to restart it.
Service Discovery:

Swarm's built-in DNS-based service discovery allows services to find each other by name, regardless of which node they are running on. If a service's task moves to a different node due to a failure, other services can still resolve its name and connect to it.

### DockerHub Links








