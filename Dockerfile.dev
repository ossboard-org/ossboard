FROM ruby:2.4.1-slim

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 68576280 \
  && echo 'deb http://deb.nodesource.com/node_8.x trusty main' > /etc/apt/sources.list.d/nodesource.list \
  && apt-get update -qq \
  && apt-get install -y --no-install-recommends \
    build-essential \
    nodejs \
    locales \
    git-core \
    libpq-dev \
    libfontconfig \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

WORKDIR /app
