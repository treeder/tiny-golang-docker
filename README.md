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

We want this to be static because we're running it inside a container with nothing in it.
I've put all the commands in build.sh, so just run that to build.

```
./build.sh
```

## 3. Build Docker image with program in it

See the Dockerfile in this repo to see how simple it is. It's based off an image that is just the Docker
scratch image + certificate files to support SSL so it's super tiny.

```
docker build -t treeder/go-hello-http .
```

## 4. Run it

```
docker run --rm -it -p 8080:8080 treeder/go-hello-http
```

Now check out http://localhost:8080/

Boom.

## Further Reading

If you want to cross compile this to a bunch of different platforms, see this: https://medium.com/iron-io-blog/how-to-cross-compile-go-programs-using-docker-beaa102a316d.
