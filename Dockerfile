FROM ruby:3.1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN bundle lock --update && \
    bundle install --jobs=4

# COPY config.ru app.rb db models ./
COPY . ./

STOPSIGNAL SIGINT

EXPOSE 2408

CMD ["rackup", "-p2408", "--host", "0.0.0.0", "-s", "puma"]
