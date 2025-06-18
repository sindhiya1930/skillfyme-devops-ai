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
RUN go build -o /service-b-app ./main.go

# Use a minimal Alpine image for the final stage
FROM alpine:latest

# Set the working directory to /app
WORKDIR /app

# Copy the compiled application from the builder stage
COPY --from=builder /service-b-app .

# Expose port 8081
EXPOSE 8081

# Set environment variables
ENV PORT=8081
ENV SERVICE_NAME=Service-B

# Run the executable
CMD ["./service-b-app"]
