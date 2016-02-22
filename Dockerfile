FROM odaniait/docker-haproxy:latest
MAINTAINER Mike Petersen <mike@odania-it.de>

RUN apt-get update && apt-get install -y libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev imagemagick libmagickwand-dev libmysqlclient-dev libpq-dev libcurl4-openssl-dev zlib1g-dev

COPY . /srv/odania

# Setup core
WORKDIR /srv/odania
RUN bundle install

RUN mkdir -p /etc/service/core
COPY docker/runit_core.sh /etc/service/core/run

# Setup haproxy
COPY docker/runit_haproxy.sh /etc/service/haproxy/run

VOLUME ["/srv/odania", "/srv/config"]

EXPOSE 9393

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*