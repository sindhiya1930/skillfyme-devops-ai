package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"time"
)

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = "8081" // Different port
	}
	serviceName := os.Getenv("SERVICE_NAME")
	if serviceName == "" {
		serviceName = "Service-B"
	}

	http.HandleFunc("/ping", func(w http.ResponseWriter, r *http.Request) {
		log.Printf("Received /ping request at %s from %s", serviceName, r.RemoteAddr)
		fmt.Fprintf(w, "Hello from %s!\n", serviceName)
	})

	log.Printf("%s listening on :%s", serviceName, port)
	log.Fatal(http.ListenAndServe(":"+port, nil))
}
