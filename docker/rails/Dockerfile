FROM ruby:2.4.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

ENV app /rails
RUN mkdir $app
WORKDIR $app

ADD . $app
