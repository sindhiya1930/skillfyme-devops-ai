# Assignment3 Blue-Green Deployment for Payment Gateway

This guide outlines the process of implementing a Blue-Green deployment strategy for a payment gateway application using Kubernetes.

## Prerequisites
* Kubernetes cluster (Minikube, Kind, GKE, EKS, AKS, etc.)
* kubectl installed and configured to connect to your cluster.
* git installed.
* Docker (if you need to build the payment gateway application images).
* A containerized payment gateway application (we'll assume a basic one for this example).

## Step-by-Step Process
### 1) Deploy Two Environments
#### a. Create Kubernetes Deployments:
   blue deployment.yml
   green deployment.yaml
   
#### b. Service to expose it 
   service.yml with blue environment configuration
   
#### c. Apply the deplotment files and service files
   <img width="418" alt="image" src="https://github.com/user-attachments/assets/51871226-4a23-4b3f-9d6a-e1f5a0cb7974" />
   
#### d. Check the curent service : Blue deployment should be done
   Accessing of Nodeport-external-ip:port -> in nodes security group allow the port inbound rule
   <img width="577" alt="image" src="https://github.com/user-attachments/assets/f04e3491-ad5b-4487-a1cf-c8b78939b514" />
   
### 2) Traffic Management
#### a. Switch the service to green env
Once testing of the Green environment is complete, you'll update the selector of your payment-gateway-service to point to the Green environment.
   <img width="291" alt="image" src="https://github.com/user-attachments/assets/99627bb2-6a23-4920-8ce1-e96379cb99ae" />
   <img width="506" alt="{CBFD1F04-48F3-46A4-87BC-99B0FC68DA9B}" src="https://github.com/user-attachments/assets/979b0c21-e3c0-4da9-a2bc-e6429434db2b" />

#### b.Now test the service : Green deployment should be done

<img width="524" alt="{F66DA46D-B277-4EE4-969A-064372D4EFF1}" src="https://github.com/user-attachments/assets/80f60aed-7c98-4447-bc0f-9c068381b44d" />

### 3) Switch Verification
This is a critical phase to ensure the new version is stable.
#### a. Test the Traffic Switch:
Continuously access your payment gateway's external IP. You should now see "Version 2.0.0 (Green)".
Perform functional tests on the new version (e.g., make a test payment if it's a real payment gateway).
If possible, use automated tests to verify functionality.

#### b. Rollback Plan (Important!)
If any issues are detected during verification, immediately switch traffic back to the Blue environment by reverting the selector in payment-gateway-service.yaml to env: blue and reapplying.

> apiVersion: v1
> kind: Service
> metadata:
>  name: payment-gateway-service
>  labels:
>    app: payment-gateway
> spec:
>  selector:
>    app: payment-gateway
>    env: blue # Rollback to Blue
>  ports:
>    - protocol: TCP
>      port: 80
>      targetPort: 80
>  type: LoadBalancer

