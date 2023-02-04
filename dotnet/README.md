# Dotnet

framework: NUnit + RestSharp  
OS: Fedora Linux 36

## Install environment

Install dotnet

```sh
sudo dnf install dotnet-sdk-6.0
```

## Run tests

```sh
dotnet test
```

## Create new empty project

```sh
dotnet new nunit
dotnet add package RestSharp
```
