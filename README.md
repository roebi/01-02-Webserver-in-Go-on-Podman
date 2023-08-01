# Webserver in Go on Podman

To experiment with different Webprojects it is good to go with templates.

And use a Webserver, beacause of CORS is disable loading file URLs.

In this Project there are 2 main directories.

## the **server** directory

In this directory is the Go Webserver and the Podman / Docker Files.

## the **web-projects** directory

In this directory are all the Websites Projects in its own subdirectories i.e. web-project1.

# run / install in podman desktop / podman

local install first Podman Desktop

from https://podman-desktop.io/

then start it.

In the main GUI, there is a message **no podman is running / installed**

Here you can install Podman with one Click.

Now Podman and Podman Desktop are installed.

Great - lets go ahead.

# Build image from a Containerfile

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



# create and run a container

