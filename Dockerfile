# Create a minimal container to run a Golang static binary

FROM centurylink/ca-certs
MAINTAINER Travis Reeder "travis@iron.io"
EXPOSE 8080

WORKDIR /app

# copy binary into image
COPY hello /app/

ENTRYPOINT ["./hello"]
