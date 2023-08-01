# server part of project

In this directory is the Go Webserver and the Podman / Docker Files.

## the Go Webserver

see in webserver.go

    http.Handle("/", http.FileServer(http.Dir(".")))

The go module http handle on root URL '/' all the file in the current directory.

see in go.mod

    module webserver-in-go-on-podman

with this the name of the Webserver is defined: **webserver-in-go-on-podman**


## the Podman / Docker Files

see in Dockerfile

    // copy alle the web-projects
    COPY ../web-projects/* ./

    // build the go application webserver-in-go-on-podman
    RUN CGO_ENABLED=0 GOOS=linux go build

    // run the go application webserver-in-go-on-podman
    CMD [ "./webserver-in-go-on-podman" ]

see in Dockerfile.multistage

    // in the go image
    FROM golang:latest AS build-stage

    // build the go application webserver-in-go-on-podman
    RUN CGO_ENABLED=0 GOOS=linux go build

    // in the base-debian11 image

    // copy the go application webserver-in-go-on-podman
    COPY --from=build-stage /app/webserver-in-go-on-podman /app/webserver-in-go-on-podman

    // copy alle the web-projects
    COPY ../web-projects/* ./

    // expose port 8080
    EXPOSE 8080

    // run as nonroot
    USER nonroot:nonroot

    // run the go application webserver-in-go-on-podman
    CMD [ "./webserver-in-go-on-podman" ]

The multistage Dockerfile is at the end the smaller image / container because of the small run base image base-debian11.
