# PHP

framework: Codecept  
OS: Fedora Linux 36

## Install environment

1. Install php

    ```sh
    sudo dnf install php-cli php-mbstring php-curl php-xml
    ```

2. Install Codecept

    Download from [this]()

## Run tests

```sh
codecept run
```

## Create new empty project

```sh
codecept init Api
codecept generate:suite api
```
