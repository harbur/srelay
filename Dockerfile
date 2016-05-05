FROM       alpine:3.3
MAINTAINER Dimitris Kapanidis <dimitris.kapanidis@harbur.io>

ENV SHA      946183528b6dacbc33ae5a3abff0ab9ad60eef06
ENV DOWNLOAD https://github.com/gco/srelay/archive/$SHA.tar.gz
ENV DIR      /opt/src/srelay-$SHA
ENV DEPS     curl gcc make musl-dev linux-headers

RUN apk add --no-cache $DEPS && \
  mkdir -p /opt/src && \
  cd /opt/src && \
  curl -sS -L --fail $DOWNLOAD | gzip -d | tar -xvf -

WORKDIR $DIR
RUN ./configure && make && cp srelay /usr/local/bin && rm -rf /opt/src

RUN apk del musl $DEPS

EXPOSE 1080

ENTRYPOINT ["/usr/local/bin/srelay", "-f"]
