FROM python:3-alpine

LABEL Maintainer="Paul Bargewell <paul.bargewell@opusvl.com" \
    License="SPDX-License-Identifier: AGPL-3.0-or-later" \
    Copyright="2021, Opus Vision Limited, T/A OpusVL"

RUN adduser -H -D www-data

RUN mkdir -p /var/www/html && \
  chown www-data: /var/www -R && \
  chmod 755 /var/www -R

ADD --chown=www-data /html /var/www/html

EXPOSE 8080

VOLUME /var/www/html

USER www-data

WORKDIR /var/www/html

ENTRYPOINT [ "python3", "-m", "http.server", "8080", "--directory", "/var/www/html" ]