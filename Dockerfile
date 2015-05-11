FROM ruby:2.2.2

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update &&\
  apt-get install -y nodejs npm locales &&\
  apt-get clean &&\
  echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen &&\
  dpkg-reconfigure locales

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install

COPY . /usr/src/app

ENV HUBOARD_ENV=oss

ENV MEMCACHIER_SERVERS=memcache:11211

ENV COUCH_DATABASE=huboard
ENV COUCH_URL=http://couchdb:5984

ENV REDIS_URL=redis://redis:6379

ENV GITHUB_API_ENDPOINT=https://api.github.com/
ENV GITHUB_WEB_ENDPOINT=https://github.com/

ENV GITHUB_CLIENT_ID="set a client id"
ENV GITHUB_SECRET="set a client secret"

ENV SESSION_SECRET="set a session key"

EXPOSE 5000

CMD foreman start web
