FROM ruby:3.1.2

RUN apt-get update && apt-get install nano

WORKDIR /var/app

# COPY Gemfile Gemfile
# COPY Gemfile.lock Gemfile.lock

# RUN bundle install

COPY . /var/app

CMD ["rspec"]