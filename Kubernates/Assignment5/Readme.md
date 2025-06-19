# Assignment5-Implementing Horizontal Pod Autoscaling
## 1. Problem statement
Modern applications frequently experience fluctuating user traffic, leading to inconsistent resource demands. Without dynamic scaling, applications can either suffer performance degradation during peak loads or incur unnecessary costs due to over-provisioned resources during low demand. This assignment demonstrates how Horizontal Pod Autoscaling (HPA) in Kubernetes automatically adjusts the number of application pods based on CPU utilization, ensuring optimal performance, high availability, and efficient resource allocation in response to real-world traffic patterns.

## 2. Steps to build and run the application

### 1. Install Metric server in Kubernates cluster
Here is the GitHub link for the Kubernetes Metrics Server:  https://github.com/kubernetes-sigs/metrics-server

This is the official repository maintained by Kubernetes SIGs (Special Interest Groups). You'll find the components.yaml manifest for installation under the releases section or by navigating to the manifests/ directory within the specific release tag.

<img width="636" alt="image" src="https://github.com/user-attachments/assets/3ac40870-d455-49e4-b305-17fd6c02b72b" />

### 2. Deploy the hpa-application.yaml file
Contains the Deployment, Service in a single file
<img width="632" alt="image" src="https://github.com/user-attachments/assets/b0f6a8b8-98a2-45c7-b11e-31e427539d4f" />

### 3. Deploy the POD Autoscalar
Deploy HPA with min pods: 3, max pods: 10, and Threshold Percentage:50%
> kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10
<img width="925" alt="image" src="https://github.com/user-attachments/assets/06aa5b2c-5ac4-41a2-b783-e8b82fa8a690" />

### 4. HPA deployment Verification
<img width="660" alt="image" src="https://github.com/user-attachments/assets/f5a07119-9cf2-4164-92c8-f763a515919c" />

### 5. Stimulation of high traffic using kubectl run command with high CPU usage

> kubectl run -i --tty load-generator --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://php-apache; done"
![image](https://github.com/user-attachments/assets/1121db6b-cfaa-41c5-9187-6f7570e2c809)

### 6. Monitoring
* Replicas increased to 7 on high traffic
<img width="894" alt="image" src="https://github.com/user-attachments/assets/3afdb747-6ebb-4933-a2fb-e467da1e9fd8" />

* Evenly distributed and is stable
<img width="866" alt="image" src="https://github.com/user-attachments/assets/8ddec625-7999-4525-8b4b-fd7544679156" />

## 3. Optimization Techniques Used
The primary optimization is Horizontal Pod Autoscaling (HPA) itself.
**Adaptive Resource Allocation**: HPA dynamically scales the number of pod replicas up during high demand (e.g., when CPU utilization exceeds a threshold) and scales them down during low demand. This prevents both resource wastage and performance bottlenecks.
**Cost Efficiency**: By scaling down when not needed, HPA helps reduce infrastructure costs associated with idle compute resources.
**Improved Reliability and Availability**: Automatically adding more instances ensures the application remains responsive and available even under unexpected traffic surges, distributing the load across more pods.
**Resource Requests and Limits**: Setting cpu.requests and cpu.limits in the Deployment is fundamental. Requests tell Kubernetes the guaranteed minimum CPU, which is the baseline against which HPA calculates utilization percentages. Limits prevent a single pod from consuming all node resources, ensuring cluster stability.

## 4. Challenges Faced and Solutions Implemented
This section reflects on the practical difficulties encountered during the assignment and how they were resolved, highlighting real-world problem-solving skills. Common challenges in HPA implementation include:
**Metrics Server Availability**: HPA relies on the Kubernetes Metrics Server to collect resource utilization data. A common initial challenge is ensuring the Metrics Server is correctly installed and functioning in the cluster.
**Load Generation**: Effectively simulating sufficient and consistent load to trigger HPA scaling can be tricky. Simple tools might not always generate enough pressure, requiring more robust load testing methods.
**HPA Configuration Tuning**: Deciding on optimal minReplicas, maxReplicas, and the targetAverageUtilization for CPU (or other metrics) often requires experimentation and understanding of the application's performance characteristics. Incorrect values can lead to over- or under-scaling.
**Debugging Scaling Behavior**: Understanding why HPA did or did not scale can be challenging. Leveraging kubectl describe hpa and kubectl get events is crucial for inspecting the HPA's status, events, and metrics to diagnose issues.
