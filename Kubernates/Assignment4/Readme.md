# Assignment #4: Configuring Persistent Storage for Stateful Applications

## Problem Statement
Containers and Kubernetes pods are inherently ephemeral; they can be created, destroyed, or rescheduled at any time. For stateful applications (e.g., databases, message queues, content management systems) that require data to persist across these pod lifecycles, this ephemeral nature presents a critical challenge: without a dedicated storage solution, all application data would be lost upon a pod's termination. This assignment focuses on addressing this by implementing Kubernetes' Persistent Volumes (PVs) and Persistent Volume Claims (PVCs) to ensure that application data remains durable, accessible, and reliably maintained regardless of underlying pod operations.

### 1. Create and Deploy the yaml files
<img width="516" alt="image" src="https://github.com/user-attachments/assets/400741c2-0cc5-4ae0-be85-f5526567dd2c" />

### 2. Check all the resources created
> kubectl get all

<img width="578" alt="{AFD9E0D5-A971-4194-83EF-EAD6FD9B8EC0}" src="https://github.com/user-attachments/assets/e8aa3787-15f1-49bd-b178-7369762ee885" />

### 3. Create table and insert values to postgres sql

<img width="713" alt="{31978D9C-3D45-491F-879D-111A6DE6CF1A}" src="https://github.com/user-attachments/assets/dd015513-4a19-486a-81a3-92a452899399" />

### 4. Validation
* Delete pod
  Delete the Pod and the Pod recreates
<img width="558" alt="{AEDFB5A2-861E-4838-A1AE-0C29981DFF6A}" src="https://github.com/user-attachments/assets/458f7eae-d604-4872-bc36-4d922e97d4e0" />

* Checking on the persistent data
  Data still remains
<img width="428" alt="{3AF4679B-77F8-4CDE-A249-03E6443EFEFC}" src="https://github.com/user-attachments/assets/3c482161-3ce8-4860-b0f7-89465afcd86d" />



