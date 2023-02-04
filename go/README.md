# Golang

framework: go-resty  
OS: Fedora Linux 36

## Install environment

1. Download go installer from [this](https://go.dev/doc/install).

2. Add /usr/local/go/bin to the PATH

	```sh
	export PATH=$PATH:/usr/local/go/bin
	```

3. Install framework go-resty

	```sh
	go get github.com/go-resty/resty/v2
	```

## Run tests

```sh
go test
```

## Create new empty project

```sh
go mod init
```
