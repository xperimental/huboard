FROM ruby:2.2-onbuild

RUN apt-get update &&\
  apt-get install -y nodejs npm &&\
  apt-get clean

CMD foreman start
