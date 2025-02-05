
FROM ruby:3.3.0
RUN apt-get update -qq && apt-get install -y sqlite3 nodejs
WORKDIR /cofee_app
COPY Gemfile /cofee_app/Gemfile
COPY Gemfile.lock /cofee_app/Gemfile.lock
RUN bundle install
COPY . /cofee_app
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]