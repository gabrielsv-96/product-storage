FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /product-storage
COPY Gemfile /product-storage/Gemfile
COPY Gemfile.lock /product-storage/Gemfile.lock
RUN bundle install
COPY . /product-storage

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]