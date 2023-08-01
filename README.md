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

    // copy only the first of the web-projects
    COPY web-projects/README.md web-projects/
    COPY web-projects/web-project1/index.html web-projects/web-project1/
    COPY web-projects/web-project1/images/* web-projects/web-project1/images/
    COPY web-projects/web-project1/scripts/* web-projects/web-project1/scripts/
    COPY web-projects/web-project1/styles/* web-projects/web-project1/styles/

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

    // copy only the first of the web-projects
    COPY web-projects/README.md web-projects/
    COPY web-projects/web-project1/index.html web-projects/web-project1/
    COPY web-projects/web-project1/images/* web-projects/web-project1/images/
    COPY web-projects/web-project1/scripts/* web-projects/web-project1/scripts/
    COPY web-projects/web-project1/styles/* web-projects/web-project1/styles/

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

select Containerfile path Dockerfile

let Build context directory to Webserver-in-Go-on-Podman

change Image Name to (all lowercase) **webserver-in-go-on-podman**

press **Build**

one minute later ...

on a Error a new **\<none\>** Image is created. Delete it.

on PASS a new **docker.io/library/webserver-in-go-on-podman** Image is created.

press **Done**

### create and run a static container

in Podman Desktop open **Images**

on the new Image **docker.io/library/webserver-in-go-on-podman** press the play icon.

change Container Name to (all lowercase) **webserver-in-go-on-podman**

for now you do not will experiment with changes is your LOCAL web-projects directory

on Volumes do not define someting (remark for developing see **create and run a development container**)

let Port mapping on 8080

Environments variales: no additional Variables needed.

press **Start Container**

5 seconds later ...

on PASS a new running **webserver-in-go-on-podman** Container in Containers is created.

why running ? = because there is a stop icon displayed.

### open the Browser to see the web-projects

on running Container **webserver-in-go-on-podman** press the tree dots icon / menu

then **Open Browser**

now you can choose:

press **Yes** open the link in your default browser.

press **Copy link** copies the link in the clipboard, the you have to open a browser and copy (Ctrl-C) the link in the URL.

### surprise

in the browser there are the files

current not optimal because all files (webserver and projects) are there:

change to directory web-projects

change to directory web-project1

then the index.html file will be rendered and shows

### inspect the image directories

on running Container **webserver-in-go-on-podman** press the tree dots icon / menu

then **Open Terminal**

in the terminal enter **bash** to have a bash shell

    pwd<Enter> // or cd /app<Enter>
    /app

    ls -al<Enter>
    web-projects

    cd web-projects<Enter>
    ls -al<Enter>
    web-project1

    cd web-project1<Enter>
    ls -al<Enter>
    images
    index.html
    scripts
    styles

    ls -al *<Enter>
    all files are here

    exit<Enter>
    ends bash

    exit<Enter>
    ends terminal

### create and run a development container

in Podman Desktop open **Images**

on the new Image **docker.io/library/webserver-in-go-on-podman** press the play icon.

change Container Name to (all lowercase) **webserver-in-go-on-podman-develop**

yes you would experiment with changes is your LOCAL web-projects directory

on Volumes on **Path on the host** select the **web-projects** directory and on **Path inside the contatiner** select **/app/web-projects/** (see Dockerfile)

let Port mapping on 8080

Environments variales: no additional Variables needed.

press **Start Container**

5 seconds later ...

on PASS a new running **webserver-in-go-on-podman-develop** Container in Containers is created.

why running ? = because there is a stop icon displayed.

Open Browser and open Terminal is same as described above.

### develop / experiment with your web-projects

But now you change the files in web-projects lacal and ther are mapped to the docker image, becaus of the Volume mapping.

enjoy

Robert Halter
