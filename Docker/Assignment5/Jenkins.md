jenkins install 
Docker pull jenkins image

<img width="865" alt="image" src="https://github.com/user-attachments/assets/8be648ad-ec7e-4572-aa55-facec2fe5484" />

Create a docker volume

<img width="408" alt="image" src="https://github.com/user-attachments/assets/311fa8f3-f58a-49a9-b4ea-d105a2c0b223" />

Docker run jenkins image

docker run -d --name jenkins -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock jenkins/jenkins:lts

<img width="943" alt="image" src="https://github.com/user-attachments/assets/3c349b37-e995-44f0-81c1-072f7998c2d0" />

Allow port 8080

Instance -> Instance name -> Security -> Security group -> add rule

<img width="886" alt="image" src="https://github.com/user-attachments/assets/d25d8038-e5a6-4142-bff5-5171bc0772fa" />

Get jenkins password for : /var/jenkins_home/secrets/initialAdminPassword --> execute into docker container

<img width="702" alt="image" src="https://github.com/user-attachments/assets/c6904909-e4eb-4088-be0b-f7e9b539b328" />

Install plugins
<img width="766" alt="image" src="https://github.com/user-attachments/assets/5b472d93-0f33-4390-adc2-8e8f83f962c8" />

Jenkins Dashboard
<img width="950" alt="image" src="https://github.com/user-attachments/assets/8c3a6ef3-06bc-4717-b503-0244a23cb22d" />


