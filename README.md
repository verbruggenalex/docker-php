![example workflow name](https://github.com/verbruggenalex/docker-php/workflows/Docker%20Image%20CI/badge.svg)
![GitHub last commit](https://img.shields.io/github/last-commit/verbruggenalex/docker-php)
![Docker Pulls](https://img.shields.io/docker/pulls/verbral/php)

# Docker PHP

## About

A Docker image based on [thecodingmachine/php:7.x-v4-apache-node12](https://github.com/thecodingmachine/docker-images-php#general-purpose-php-images-for-docker)
**This is not an official docker image!** Subject to change as
it is used for personal development purposes.

## Versions

### From Dockerhub
```bash
docker pull docker.io/verbral/php:7.2
docker pull docker.io/verbral/php:7.3
docker pull docker.io/verbral/php:7.4
```

### From Github
```bash
docker pull docker.pkg.github.com/verbruggenalex/docker-php/php:7.2
docker pull docker.pkg.github.com/verbruggenalex/docker-php/php:7.3
docker pull docker.pkg.github.com/verbruggenalex/docker-php/php:7.4
```

## Usage:

<details>
 <summary>Setup a docker-compose.yml file with the following contents:</summary>

```yaml
version: '3'
services:
  web:
    image: verbral/php:7.4
    working_dir: ${PWD}
    ports:
      - 80:80
    environment:
      APACHE_DOCUMENT_ROOT: ${PWD}
      # Set your Git user and name for commit purposes.
      GIT_USER_NAME:
      GIT_USER_EMAIL:
      # Set your Github API token for Composer usage.
      GITHUB_API_TOKEN:
      # Set your Wakatime API key if you use the plugin.
      WAKATIME_API_KEY:
    volumes:
      # Mount path as is for xdebug.
      - ${PWD}:${PWD}
      # Mount your SSH folder for git purposes.
      - ~/.ssh:/home/docker/.ssh
```
</details>

```
docker-compose up -d
```

After this your application will be available on port 80.

## Development

```
git clone git@github.com:verbruggenalex/docker-php.git
cd docker-php
PHP_VERSION=7.4 docker-compose up -d --build
```
