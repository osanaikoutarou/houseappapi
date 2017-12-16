FROM ruby:2.4.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# App specific installations are run separatelly so previous is a rehused container
RUN apt-get install -y imagemagick && rm -rf /var/lib/apt/lists/*

ENV INSTALL_PATH /api
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

RUN gem install bundler

#COPY Gemfile Gemfile
#COPY Gemfile.lock Gemfile.lock

#RUN gem install bundler && bundle install --jobs 20 --retry 5
