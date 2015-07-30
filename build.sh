CGO_ENABLED=${CGO_ENABLED:-0} go build -a --installsuffix cgo --ldflags="-s" -o hello
