# Webserver in Go on Podman

To experiment with different Webprojects it is good to go with templates.

And use a Webserver, beacause of CORS is disable loading file URLs.

In this Project there are 2 main directories.

And on the root directory 2 Dockerfiles.

## the **server** directory

In this directory is the Go Webserver and the Podman / Docker Files.

## the **web-projects** directory

In this directory are all the Websites Projects in its own subdirectories i.e. web-project1.

## on the root directory the 2 Podman / Docker Files

### the Podman / Docker Files

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

## run / install in podman desktop / podman

local install first Podman Desktop

from https://podman-desktop.io/

then start it.

In the main GUI, there is a message **no podman is running / installed**

Here you can install Podman with one Click.

Now Podman and Podman Desktop are installed.

Great - lets go ahead.

### Build image from a Containerfile

if you cloned this Github Repo

in Podman Desktop open **Images**

then **Build an Image** ...

select Containerfile path server/Dockerfile

change Build context directory to the Parent of server directory: **Webserver-in-Go-on-Podman**

change Image Name to (all lowercase) **webserver-in-go-on-podman**

press **Build**

one minute later ...

on a Error a new **<none>** Image is created. Delete it.

on PASS a new **webserver-in-go-on-podman** Image is created.



### create and run a container

