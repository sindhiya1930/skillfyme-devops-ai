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
RUN go build -o /service-a-app ./main.go

# Use a minimal Alpine image for the final stage
FROM alpine/git:latest

# Set the working directory to /app
WORKDIR /app

# Copy the compiled application from the builder stage
COPY --from=builder /service-a-app .

# Expose port 8080
EXPOSE 8080

# Set environment variables
ENV PORT=8080
ENV SERVICE_NAME=Service-A

# Run the executable
CMD ["./service-a-app"]
