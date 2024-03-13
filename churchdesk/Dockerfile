FROM traefik:v2.11


ENV PACKETBEAT_CONFIG /packetbeat/packetbeat.yml

RUN apk add --update \
    openssl \
    bash \
    ca-certificates \
  && update-ca-certificates
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.35-r1/glibc-2.35-r1.apk
RUN apk add glibc-2.35-r1.apk

ENV LANG=C.UTF-8

RUN wget https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-8.12.2-linux-x86_64.tar.gz
RUN tar xzf packetbeat-8.12.2-linux-x86_64.tar.gz
RUN rm packetbeat-8.12.2-linux-x86_64.tar.gz
RUN mv packetbeat-8.12.2-linux-x86_64 /packetbeat

COPY scripts/runner_pbeat.sh /runner_pbeat.sh
RUN chmod +x /runner_pbeat.sh

CMD ["/runner_pbeat.sh"]