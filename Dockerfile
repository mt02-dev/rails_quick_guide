FROM ruby:3.2.2-alpine
RUN apk update && apk add git g++ make tzdata libpq-dev nodejs
WORKDIR /taskleaf
COPY Gemfile Gemfile.lock ./
RUN bundle install
