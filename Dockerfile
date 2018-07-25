FROM ruby:2.5.1-slim

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y curl git-core gnupg

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y -qq --no-install-recommends \
    build-essential nodejs libpq-dev

ENV INSTALL_PATH /app

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile ./

ENV BUNDLE_PATH /gems

COPY . .