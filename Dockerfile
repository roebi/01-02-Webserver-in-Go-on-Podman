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
COPY server/go.mod ./
# COPY server/go.sum ./
# RUN go mod download
COPY server/webserver.go ./

# Copy the source code. Note the slash at the end, as explained in
# https://docs.docker.com/engine/reference/builder/#copy
# https://pkg.go.dev/path/filepath#Match
COPY web-projects/README.md web-projects/
COPY web-projects/web-project1/index.html web-projects/web-project1/
COPY web-projects/web-project1/images/* web-projects/web-project1/images/
COPY web-projects/web-project1/scripts/* web-projects/web-project1/scripts/
COPY web-projects/web-project1/styles/* web-projects/web-project1/styles/
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

# CMD is the command the container executes by default when you launch the built image.
CMD [ "./webserver-in-go-on-podman" ]

# CMD [ "go version" ]
# CMD [ "go run ./webserver.go" ]

# ENTRYPOINT ["./webserver-in-go-on-podman"]
