# Optimizing Docker Images for Production: Java Microservice

## Problem Statement

This project addresses the problem by implementing a multi-stage Dockerfile to build a lightweight and secure Docker image for a Java-based microservice. It leverages best practices such as using a minimal JRE base image, creating a non-root user, and incorporating a health check for robust deployment.

## Step-by-Step Commands to Build and Run the Docker Image

### Prerequisites

Before you begin, ensure you have the following installed:

* **Docker Desktop** (or Docker Engine)
* **Maven** (if you need to build the project locally before Docker)
* **A Docker Hub account** (if you plan to push the image)

### 1. DockerHub login
   > docker login
   <img width="719" alt="{A8D4EA7B-92AD-4849-95A3-84996B20E7FE}" src="https://github.com/user-attachments/assets/3a6dcb54-245f-46f2-a297-8da1fd00265d" />

### 2. Build the Docker Image <br>
Navigate to the root directory of your project (where `Dockerfile` and `pom.xml` are located) in your terminal. <br>
   > docker build -t sindhiya1930/skillfyme-java-microservice:latest .

* docker build: The command to build a Docker image.
* -t sindhiya1930/skillfyme-java-microservice:latest: Tags your image with a name and a tag. Replace sindhiya1930 with        * your Docker Hub username. :latest is a common tag, but you could use a version number (e.g., :1.0.0).
* .: Specifies the build context, which is the current directory.
  This command will execute the instructions in your Dockerfile, performing the multi-stage build. You should see output         indicating each step of the build process.   
<img width="886" alt="{F38265C2-8823-41F7-9968-9892B96BAB4E}" src="https://github.com/user-attachments/assets/77abdc7d-a283-4d4c-b60f-dec002505fd0" />

### 3. Push image to Docker Hub: 
   > docker push sindhiya1930/skillfyme-java-microservice:latest
   <img width="878" alt="{9BE7DED4-260F-44F7-9863-7EB04EA387F5}" src="https://github.com/user-attachments/assets/35e1fb4a-cdf5-41f2-bd34-2f732d5e5114" />

### 4. Image in the Docker Hub
   ![image](https://github.com/user-attachments/assets/d02831ef-88e8-4732-9760-edd0a61b9848)



