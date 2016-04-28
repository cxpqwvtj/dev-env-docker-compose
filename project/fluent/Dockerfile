FROM fluent/fluentd:v0.12.21
WORKDIR /home/fluent
ENV PATH /home/fluent/.gem/ruby/2.2.0/bin:$PATH
RUN gem install fluent-plugin-elasticsearch -v 1.4.0
EXPOSE 8888
CMD fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT
