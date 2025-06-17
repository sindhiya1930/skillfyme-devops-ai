# Stage 1: Build the Java application using Maven
FROM maven:3.9-eclipse-temurin-17 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the project's Maven configuration file
COPY pom.xml .

# Download project dependencies to ensure they are cached and to speed up subsequent builds
RUN mvn dependency:go-offline -B

# Copy the source code into the container
COPY src ./src

# Compile the application and package it into a JAR file, skipping tests
RUN mvn clean package -DskipTests

---

# Stage 2: Create the final production-ready image
FROM eclipse-temurin:17-jre

# Set the working directory for the application inside the container
WORKDIR /app

# Copy the built JAR file from the 'builder' stage to the current stage
COPY --from=builder /app/target/*.jar app.jar

# Install 'curl' which is needed for the health check later.
# 'apt-get update' refreshes package lists, 'apt-get install -y curl' installs curl,
# and 'rm -rf /var/lib/apt/lists/*' cleans up the cache to keep the image small.
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Create a non-root system user and group named 'appuser' for security best practices
RUN adduser --system --group appuser

# Switch to the 'appuser' to run the application, enhancing security by not running as root
USER appuser

# Expose port 8080 to the outside world, indicating where the application listens
EXPOSE 8080

# Configure a health check for the container:
# --interval=30s: Check every 30 seconds.
# --timeout=10s: Fail if the check takes longer than 10 seconds.
# --retries=3: Mark as unhealthy after 3 consecutive failures.
# --start-period=30s: Give the app 30 seconds to start up before health check failures count.
# CMD curl -f http://localhost:8080/actuator/health || exit 1:
# This command uses curl to hit the Spring Boot Actuator health endpoint.
# '-f' makes curl fail on HTTP errors (4xx/5xx).
# '|| exit 1' ensures the health check command returns a non-zero exit code if curl fails,
# signaling an unhealthy state to Docker.
HEALTHCHECK --interval=30s --timeout=10s --retries=3 --start-period=30s \
  CMD curl -f http://localhost:8080/actuator/health || exit 1

# Define the command to run when the container starts, executing the Java application
ENTRYPOINT ["java", "-jar", "app.jar"]
