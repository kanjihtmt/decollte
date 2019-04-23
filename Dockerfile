FROM ruby:2.6.0

ENV APP_ROOT /decollte_app

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get install -y nodejs
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-client

RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

RUN gem install rails
ADD Gemfile ${APP_ROOT}/Gemfile
ADD Gemfile.lock ${APP_ROOT}/Gemfile.lock
RUN bundle install

ADD . $APP_ROOT
