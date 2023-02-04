# JavaScript

framework: [Playwright](https://playwright.dev/docs/intro)  
OS: Fedora Linux 36

## Install environment

1. Install NodeJS

    ```sh
    sudo dnf module install nodejs:18/common
    ```

2. Check Npm

    ```sh
    npm --version
    ```

## Run tests

```sh
npx playwright test
```

## Create new empty project

```sh
npm init playwright@latest
```
