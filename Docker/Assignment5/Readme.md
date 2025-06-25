# Implementing CICD PIpeline with Docker and Jenkins

## 1. Install Docker and Jenkins 

### 1. Docker pull jenkins image
> sudo docker volume create jenkins_home
<img width="865" alt="image" src="https://github.com/user-attachments/assets/8be648ad-ec7e-4572-aa55-facec2fe5484" />

### 2. Create a docker volume
> sudo docker volume create jenkins_home

<img width="408" alt="image" src="https://github.com/user-attachments/assets/311fa8f3-f58a-49a9-b4ea-d105a2c0b223" />

### 3. Docker run jenkins image
> docker run -d --name jenkins -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock jenkins/jenkins:lts

<img width="943" alt="image" src="https://github.com/user-attachments/assets/3c349b37-e995-44f0-81c1-072f7998c2d0" />

### 4. Docker Logs check for jenkins container
> sudo docker logs jenkins

<img width="950" alt="{6E109844-B9F4-4860-AB3A-500151B01256}" src="https://github.com/user-attachments/assets/b8705f48-0fc4-438f-9df9-bbd7831bb7c0" />

### 5. Allow port 8080
Instance -> Instance name -> Security -> Security group -> add rule

<img width="886" alt="image" src="https://github.com/user-attachments/assets/d25d8038-e5a6-4142-bff5-5171bc0772fa" />

### 6. Get Jenkins Password
Get jenkins password for : /var/jenkins_home/secrets/initialAdminPassword 
execute into docker container
> docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword

<img width="702" alt="image" src="https://github.com/user-attachments/assets/c6904909-e4eb-4088-be0b-f7e9b539b328" />

### 7. Install plugins
<img width="766" alt="image" src="https://github.com/user-attachments/assets/5b472d93-0f33-4390-adc2-8e8f83f962c8" />

### 8. Jenkins Dashboard
<img width="950" alt="image" src="https://github.com/user-attachments/assets/8c3a6ef3-06bc-4717-b503-0244a23cb22d" />


