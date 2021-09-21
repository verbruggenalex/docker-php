# The PHP_EXTENSIONS ARG will apply to the "slim" image
ARG PHP_EXTENSIONS="apcu bcmath gd mysqli opcache pdo_mysql soap zip"
ARG PHP_VERSION=7.4
ARG NODE_VERSION=node12
ARG IMAGE_VERSION=v4
ARG IMAGE_TYPE=apache

FROM thecodingmachine/php:$PHP_VERSION-$IMAGE_VERSION-$IMAGE_TYPE-$NODE_VERSION

USER root

RUN apt-get update \
 && apt-get install -y mysql-client rsync wget --no-install-recommends

COPY apache2/sites-available/* /etc/apache2/sites-available/

RUN if [[ "$IMAGE_TYPE" = "apache" ]]; then a2ensite web.conf; fi && \
    if [[ "$IMAGE_TYPE" = "apache" ]]; then a2ensite production.conf; fi && \
    if [[ "$IMAGE_TYPE" = "apache" ]]; then  pre-production.conf; fi && \
    if [[ "$IMAGE_TYPE" = "apache" ]]; then a2ensite post-production.conf; fi

USER docker

ENV STARTUP_COMMAND_1='[ -z "$GIT_USER_NAME" ] || git config --global user.name "$GIT_USER_NAME"'
ENV STARTUP_COMMAND_2='[ -z "$GIT_USER_EMAIL" ] || git config --global user.email "$GIT_USER_EMAIL"'
ENV STARTUP_COMMAND_3='sed -i "s/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXX/$WAKATIME_API_KEY/g"  /home/docker/.wakatime.cfg'
