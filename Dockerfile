FROM ruby:2.7.2-alpine AS builder

ARG RAILS_ROOT=/app
ARG BUILD_PACKAGES="build-base curl-dev git curl bash"
ARG DEV_PACKAGES="postgresql-dev nodejs yarn"
ARG RUBY_PACKAGES="tzdata"

#ENV BUNDLE_APP_CONFIG="$RAILS_ROOT/.bundle"

WORKDIR $RAILS_ROOT

RUN apk update \
        && apk upgrade \
        && apk add --update --no-cache $BUILD_PACKAGES $DEV_PACKAGES $RUBY_PACKAGES

COPY Gemfile* package.json /app/

RUN gem update --system
RUN gem install bundler
RUN bundle config --global frozen 1 \
    && bundle config set --local path $BUNDLE_APP_CONFIG \
    && bundle install -j4 --retry 3 \
    #Remove unneeded files (cached *.gem, *.o, *.c)
    && rm -rf $BUNDLE_APP_CONFIG/ruby/2.7.0/cache/*.gem \
    && find $BUNDLE_APP_CONFIG/ruby/2.7.0/gems/ -name "*.c" -delete \
    && find $BUNDLE_APP_CONFIG/ruby/2.7.0/gems/ -name "*.o" -delete

RUN bundle exec rails webpacker:install
RUN yarn install --production

COPY . ./

RUN bundle package
RUN bundle exec rake assets:precompile

RUN rm -rf node_modules tmp/cache
#RUN rm -rf node_modules tmp/cache app/assets vendor/assets spec

FROM ruby:2.7.2-alpine
ARG RAILS_ROOT=/app
ARG PACKAGES="tzdata postgresql-dev nodejs bash"

ENV BUNDLE_APP_CONFIG="$RAILS_ROOT/.bundle"

WORKDIR $RAILS_ROOT

RUN apk update \
        && apk upgrade \
        && apk add --update --no-cache $PACKAGES

COPY --from=builder $RAILS_ROOT $RAILS_ROOT

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
EXPOSE 80

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]