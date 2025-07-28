# use go as base Image
# https://hub.docker.com/_/golang
FROM golang:1.25rc2

# 868 MB big - singlestage

# Labels
LABEL "author"="Robert Halter"
LABEL "description"="Webserver in Go on Podman"

# Set destination for COPY
WORKDIR /app

# Download Go modules
# COPY go.mod go.sum ./
COPY server/go.mod ./
# COPY server/go.sum ./
# RUN go mod download
COPY server/webserver.go ./

# Copy the source code. Note the slash at the end, as explained in
# https://docs.docker.com/engine/reference/builder/#copy
# https://pkg.go.dev/path/filepath#Match
# https://stackoverflow.com/questions/30215830/dockerfile-copy-keep-subdirectory-structure
COPY web-projects/ ./web-projects/
# just to document which files and directories are copied:
# COPY web-projects/README.md web-projects/
# COPY web-projects/web-project1/index.html web-projects/web-project1/
# COPY web-projects/web-project1/images/* web-projects/web-project1/images/
# COPY web-projects/web-project1/scripts/* web-projects/web-project1/scripts/
# COPY web-projects/web-project1/styles/* web-projects/web-project1/styles/
# same for web-projects/web-project2 if exist
# same for web-projects/web-project3 if exist
# same for web-projects/web-project4 if exist
# same for web-projects/web-project5 if exist

# Build
RUN CGO_ENABLED=0 GOOS=linux go build

# 944 MB big - singlestage

# To bind to a TCP port, runtime parameters must be supplied to the docker command.
# But we can (optionally) document in the Dockerfile what ports
# the application is going to listen on by default.
# https://docs.docker.com/engine/reference/builder/#expose
EXPOSE 8080

# RUN is an image build step, the state of the container after a RUN command will be committed to the container image.
# A Dockerfile can have many RUN steps that layer on top of one another to build the image.
RUN chmod +x ./webserver-in-go-on-podman

# important: to run the image NOT as a root user
# from https://gist.github.com/avishayp/33fcee06ee440524d21600e2e817b6b7
# and https://wiki.alpinelinux.org/wiki/Setting_up_a_new_user#Options

ENV USER nonroot
# adduser uses the SHELL variable in file /etc/default/useradd
# this change does not work
# ENV SHELL /bin/bash

# do not define a own id, because of
# useradd warning:
# nonroot's uid 65532 outside of the UID_MIN 1000 and UID_MAX 60000 range
# ENV NONROOT 65532
# --uid $NONROOT \

# add new user
# do not define guid, default is to create a guid with same id as uid and add this user to this group
# --ingroup $NONROOT \
# --shell /bin/bash sets the SHELL variable in /etc/default/useradd

RUN adduser --disabled-password \
            --no-create-home \
            $USER

# unused info about sudoers
# RUN adduser -D $USER \
#         && mkdir -p /etc/sudoers.d \
#         && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER \
#         && chmod 0440 /etc/sudoers.d/$USER

# unused info from the base image golang:latest its base image is a alpine image
# passwd_entry(
#     name = "nonroot_user",
#     gid = NONROOT,
#     uid = NONROOT,
#     username = "nonroot",
# )
# ("nonroot", NONROOT, "/home/nonroot")

# change the owner and group
# of current dir / workdir 'app' recursively down
# to $USER user id and its group id
RUN chown --recursive $USER: .

# with this following 'set permission' command
# you can show the external files with a Web Developer Tool
# without this, the page and its external files will run but it blocks
# MIME type sniffing
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Content-Type-Options?utm_source=mozilla&utm_medium=firefox-console-errors&utm_campaign=default
# mean you can NOT show in the external files with a Web Developer Tool

# set permission
# of current dir / workdir 'app' recursively down
# to drwxr-xr-x
RUN chmod --recursive 755 .

USER $USER:$USER

# CMD is the command the container executes by default when you launch the built image.
CMD [ "./webserver-in-go-on-podman" ]

# CMD [ "go version" ]
# CMD [ "go run ./webserver.go" ]

# ENTRYPOINT ["./webserver-in-go-on-podman"]
