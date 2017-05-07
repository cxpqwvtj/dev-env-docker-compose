FROM fluent/fluentd:v0.14.15

WORKDIR /home/fluent
ENV PATH /home/fluent/.gem/ruby/2.3.0/bin:$PATH

USER root

RUN apk --no-cache --update add build-base ruby-dev libc6-compat libmaxminddb-dev geoip-dev \
 && gem install fluent-plugin-elasticsearch -v 1.9.3 \
 && gem install fluent-plugin-geoip \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

USER fluent

EXPOSE 8888
CMD fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT
