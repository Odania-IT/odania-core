FROM odaniait/docker-puma:latest
MAINTAINER Mike Petersen <mike@odania-it.de>

# Install dependencies in a cache efficient way
USER root
WORKDIR /tmp
ADD Gemfile /tmp/Gemfile
ADD Gemfile.lock /tmp/Gemfile.lock
ADD odania_core.gemspec /tmp/odania_core.gemspec
RUN mkdir -p /tmp/lib/odania_core
ADD lib/odania_core/version.rb /tmp/lib/odania_core/version.rb
RUN bundle install

COPY . /srv/app
WORKDIR /srv/app
RUN chown -R app:app /srv/app

USER app
RUN REDIS_PORT_6379_TCP_ADDR=127.0.0.1 REDIS_PORT_6379_TCP_PORT=6379 bundle exec rake app:assets:precompile
