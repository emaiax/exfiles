FROM ruby:2.5-alpine
MAINTAINER emaiax

RUN apk add --no-cache --update bash build-base git
RUN gem update --system && gem install bundler

COPY . /root/.exfiles

RUN cd /root/.exfiles && bundle install

WORKDIR /root/.exfiles

CMD ["/bin/bash"]
