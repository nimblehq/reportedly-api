FROM ruby:2.7.1-slim

ARG BUILD_ENV=development
ARG RUBY_ENV=development
ARG APP_HOME=/reportedly_api

# Define all the envs here
ENV BUILD_ENV=$BUILD_ENV \
    RACK_ENV=$RUBY_ENV \
    RAILS_ENV=$RUBY_ENV \
    PORT=80 \
    BUNDLE_JOBS=4 \
    BUNDLE_PATH="/bundle" \
    LANG="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8" \
    LANGUAGE="en_US:en"

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends apt-transport-https curl gnupg net-tools && \
    apt-get install -y --no-install-recommends build-essential libpq-dev && \
    apt-get install -y --no-install-recommends rsync locales chrpath pkg-config libfreetype6 libfontconfig1 git cmake wget unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR $APP_HOME

# Skip installing gem documentation
RUN mkdir -p /usr/local/etc \
	&& { \
    echo '---'; \
    echo ':update_sources: true'; \
    echo ':benchmark: false'; \
    echo ':backtrace: true'; \
    echo ':verbose: true'; \
    echo 'gem: --no-ri --no-rdoc'; \
		echo 'install: --no-document'; \
		echo 'update: --no-document'; \
	} >> /usr/local/etc/gemrc

# Copy all denpendencies from app and engines into tmp/docker to install
COPY tmp/docker ./

# Install Ruby gems
RUN gem install bundler && \
    bundle config set jobs $BUNDLE_JOBS && \
    bundle config set path $BUNDLE_PATH && \
    if [ "$BUILD_ENV" = "production" ]; then \
      bundle config set deployment yes && \
      bundle config set without 'development test' ; \
    fi && \
    bundle install

# Copying the app files must be placed after the dependencies setup
# since the app files always change thus cannot be cached
COPY . ./

# Remove tmp/docker in the final image
RUN rm -rf tmp/docker

EXPOSE $PORT

CMD ./bin/start.sh
