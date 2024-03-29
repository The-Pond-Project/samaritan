FROM ruby:2.7.2

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y postgresql-client nodejs yarn vim nano

WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
COPY package.json /app/package.json

RUN gem update --system
RUN gem install bundler
RUN bundle install
RUN bundle exec rails webpacker:install
run bundle exec rails webpacker:install:react 
RUN bundle exec rails generate react:install
RUN yarn install
RUN yarn add react_ujs

COPY . ./

RUN bundle package
RUN bundle exec rails generate react:install
RUN bundle exec rails assets:precompile

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["entrypoint.sh"]