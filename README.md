This is an example for how to build a teeny, tiny Docker image for your golang programs.

This example is an web server that prints Hello World and ends up in a **4.7MB** Docker image.

## 0. Clone this repo into your GOPATH

Clone it into `$GOPATH/src/github.com/treeder`.

And be sure you have [godep](https://github.com/tools/godep) installed to vendor dependencies. Install it with `go get github.com/tools/godep`.

## 1. Get dependencies

We only have one dependency, so let's get it and vendor it:

```
go get github.com/gorilla/mux
godep save -r
```

## 2. Build program

We want this to be static because we're running it inside a container with nothing in it, so this command is a bit long, but
just copy and paste it into your console.

```
docker run --rm -it -v "$GOPATH":/gopath -v "$(pwd)":/app -e "GOPATH=/gopath" -w /app golang:1.4.2 sh -c 'CGO_ENABLED=0 go build -a --installsuffix cgo --ldflags="-s" -o hello'
```

<!--
Can test this before building full image:
docker run --rm -it -v "$(pwd)":/app -w /app -p 8080:8080 centurylink/ca-certs ./hello
-->

## 3. Build Docker image with program in it

The Dockerfile in this repo will take care of this, it's really simple (take a look).
It's based off an image that is just the Docker scratch image + certificate files to support SSL so it's
as small as it can be.

```
docker build -t treeder/go-hello-http .
```

## 4. Run it

Now that we built the image, let's run it.

```
docker run --rm -it -p 8080:8080 treeder/go-hello-http
```

Surf to: http://localhost:8080/

Boom.

## Further Reading

If you want to cross compile a Go program to a bunch of different platforms, see this: https://medium.com/iron-io-blog/how-to-cross-compile-go-programs-using-docker-beaa102a316d.
