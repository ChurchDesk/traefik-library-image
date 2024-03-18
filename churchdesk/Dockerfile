FROM traefik:v2.11


ENV PACKETBEAT_CONFIG /packetbeat/packetbeat.yml

RUN apk add --update \
    openssl \
    bash \
    ca-certificates \
  && update-ca-certificates

RUN apk update && apk upgrade && apk add bash libc6-compat

ENV LANG=C.UTF-8

RUN wget https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-7.16.3-linux-x86_64.tar.gz
RUN tar xzf packetbeat-7.16.3-linux-x86_64.tar.gz
RUN rm packetbeat-7.16.3-linux-x86_64.tar.gz
RUN mv packetbeat-7.16.3-linux-x86_64 /packetbeat

COPY scripts/runner_pbeat.sh /runner_pbeat.sh
RUN chmod +x /runner_pbeat.sh

CMD ["/runner_pbeat.sh"]