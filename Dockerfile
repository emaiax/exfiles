FROM ruby:2.5-alpine
MAINTAINER emaiax

RUN apk add --no-cache --update bash build-base git
RUN gem update --system && gem install bundler

COPY . /app/exfiles

RUN cd /app/exfiles && bundle install

WORKDIR /app/exfiles

CMD ["/bin/bash"]
