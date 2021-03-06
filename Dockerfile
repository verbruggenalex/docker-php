ARG PHP_VERSION=8.0
ARG NODE_VERSION=node14
ARG IMAGE_VERSION=v4
ARG IMAGE_TYPE=apache

FROM thecodingmachine/php:$PHP_VERSION-$IMAGE_VERSION-$IMAGE_TYPE-$NODE_VERSION

USER root

RUN apt-get update \
 && apt-get install -y mysql-client rsync wget --no-install-recommends

ADD --chown=docker:docker .wakatime.cfg /home/docker/.wakatime.cfg

COPY apache2/sites-available/* /etc/apache2/sites-available/

RUN if [ "$IMAGE_TYPE" = "apache" ]; then a2ensite web.conf; a2ensite production.conf; a2ensite pre-production.conf; a2ensite post-production.conf; fi

USER docker

ENV PHP_EXTENSIONS="apcu bcmath gd mysqli opcache pdo_mysql soap zip"
ENV STARTUP_COMMAND_1='[ -z "$GIT_USER_NAME" ] || git config --global user.name "$GIT_USER_NAME"'
ENV STARTUP_COMMAND_2='[ -z "$GIT_USER_EMAIL" ] || git config --global user.email "$GIT_USER_EMAIL"'
ENV STARTUP_COMMAND_3='sed -i "s/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXX/$WAKATIME_API_KEY/g"  /home/docker/.wakatime.cfg'
