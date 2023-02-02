# JavaScript

framework: [Playwright](https://playwright.dev/docs/intro)  
OS: Fedora Linux 36

## Установка

1. Ставим NodeJS

    ```sh
    sudo dnf module install nodejs:18/common
    ```

2. Npm должен был установиться автоматически. Проверяем

    ```sh
    npm --version
    ```

3. Создаем новый проект playwright (пропустить, если запускаем клонированный проект)

    ```sh
    npm init playwright@latest
    ```

## Запуск тестов

```sh
npx playwright test
```
