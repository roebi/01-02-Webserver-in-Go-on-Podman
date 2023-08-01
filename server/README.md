# server part of project

In this directory is the Go Webserver.

## the Go Webserver

see in webserver.go

    http.Handle("/", http.FileServer(http.Dir(".")))

The go module http handle on root URL '/' all the file in the current directory.

see in go.mod

    module webserver-in-go-on-podman

with this the name of the Webserver is defined: **webserver-in-go-on-podman**
