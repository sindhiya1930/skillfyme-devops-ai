FROM maven:3.9-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn clea package -DskipTests

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY -from=builder /app/target/*.jar aap.jar
RUN adduser --system --group appuser
USER appuser
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
