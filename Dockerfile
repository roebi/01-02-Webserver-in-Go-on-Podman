# use go as base Image
# https://hub.docker.com/_/golang
FROM golang:latest

# 868 MB big - singlestage

# Labels
LABEL "author"="Robert Halter"
LABEL "description"="Webserver in Go on Podman"

# Set destination for COPY
WORKDIR /app

# Download Go modules
# COPY go.mod go.sum ./
COPY go.mod ./
# COPY go.sum ./
# RUN go mod download
COPY webserver.go ./

# Copy the source code. Note the slash at the end, as explained in
# https://docs.docker.com/engine/reference/builder/#copy
COPY ../web-projects/* ./
# COPY index.html ./
# COPY style.css ./
# COPY script.js ./

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

# CMD is the command the container executes by default when you launch the built image.
CMD [ "./webserver-in-go-on-podman" ]

# CMD [ "go version" ]
# CMD [ "go run ./webserver.go" ]

# ENTRYPOINT ["./webserver-in-go-on-podman"]
