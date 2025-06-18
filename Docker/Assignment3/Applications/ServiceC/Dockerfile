# Use an official Go runtime as a parent image
FROM golang:1.22-alpine AS builder

# Set the working directory to /app
WORKDIR /app

# Copy the Go module files
COPY go.mod ./

# Download Go modules
RUN go mod download

# Copy the source code
COPY . .

# Build the Go application
RUN go build -o /service-c-app ./main.go

# Use a minimal Alpine image for the final stage
FROM alpine/git:latest

# Set the working directory to /app
WORKDIR /app

# Copy the compiled application from the builder stage
COPY --from=builder /service-c-app .

# Set environment variables (these will be overridden by docker-compose)
ENV TARGET_A=service-a:8080
ENV TARGET_B=service-b:8081

# Run the executable
CMD ["./service-c-app"]
