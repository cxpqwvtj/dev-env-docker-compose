FROM ubuntu:14.04.4
MAINTAINER cxpqwvtj

RUN apt-get install -y curl git

ENV TOPBEAT_VERSION=5.0.0-alpha5

RUN curl -L -O https://download.elastic.co/beats/topbeat/topbeat_${TOPBEAT_VERSION}_amd64.deb && \
    sudo dpkg -i topbeat_${TOPBEAT_VERSION}_amd64.deb && \
    mv /etc/topbeat/topbeat.yml /etc/topbeat/topbeat.yml.org

RUN curl -L -O http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz && \
    mkdir -p /usr/share/GeoIP && \
    gunzip -c GeoLiteCity.dat.gz > /usr/share/GeoIP/GeoLiteCity.dat

WORKDIR /topbeat

RUN git clone https://github.com/elastic/beats-dashboards.git

ADD config/ /topbeat/config/
ADD entrypoint.sh /topbeat/entrypoint.sh

CMD /topbeat/entrypoint.sh
