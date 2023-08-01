// from https://stackoverflow.com/questions/12905426/what-is-a-faster-alternative-to-pythons-http-server-or-simplehttpserver
// Run this source using go run webserver.go or to build an executable go build webserver.go
// go install from https://go.dev/dl/

package main

// https://pkg.go.dev/fmt
// https://pkg.go.dev/flog
// https://pkg.go.dev/net/http

import (
	"fmt"
	"log"
	"net/http"
)

func main() {
	fmt.Println("Serving files in the current directory on port 8080")
	http.Handle("/", http.FileServer(http.Dir(".")))
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}
