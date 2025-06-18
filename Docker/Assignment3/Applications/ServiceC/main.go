package main

import (
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
	"time"
)

func main() {
	targetA := os.Getenv("TARGET_A")
	if targetA == "" {
		targetA = "service-a:8080"
	}
	targetB := os.Getenv("TARGET_B")
	if targetB == "" {
		targetB = "service-b:8081"
	}

	log.Printf("Service-C client starting. Will attempt to reach %s and %s", targetA, targetB)

	client := &http.Client{Timeout: 5 * time.Second}

	for {
		// Attempt to connect to Service A
		resp, err := client.Get(fmt.Sprintf("http://%s/ping", targetA))
		if err != nil {
			log.Printf("ERROR: Could not reach %s: %v", targetA, err)
		} else {
			defer resp.Body.Close()
			body, _ := io.ReadAll(resp.Body)
			log.Printf("SUCCESS: Response from %s (%d): %s", targetA, resp.StatusCode, string(body))
		}

		time.Sleep(2 * time.Second) // Small delay between requests

		// Attempt to connect to Service B
		resp, err = client.Get(fmt.Sprintf("http://%s/ping", targetB))
		if err != nil {
			defer resp.Body.Close()
			body, _ := io.ReadAll(resp.Body)
			log.Printf("SUCCESS: Response from %s (%d): %s", targetB, resp.StatusCode, string(body))
		} else {

			log.Printf("ERROR: Could not reach %s: %v", targetB, err)
		}

		time.Sleep(5 * time.Second) // Main delay
	}
}
