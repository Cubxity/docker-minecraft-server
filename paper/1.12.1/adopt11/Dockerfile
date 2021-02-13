FROM adoptopenjdk/openjdk11:alpine-jre

LABEL org.opencontainers.image.authors="Cubxity <cubxity@protonmail.com>"
LABEL org.opencontainers.image.source="https://github.com/Cubxity/docker-minecraft-server"
LABEL org.opencontainers.image.version="1.12.1-paper-adopt11"

RUN addgroup -S -g 1000 minecraft \
  && adduser -Ss /bin/false -u 1000 --home /home/minecraft minecraft \
  && mkdir -m 644 /data \
  && chown minecraft:minecraft /data

ENV PAPER_VERSION 1.12.1
ENV PAPER_BUILD 1204
ENV PAPER_SHA256 dba2219d674ad85e4ef2c41931d34b6fa4be75a887973ecaaf286727a03812da

RUN apk add --no-cache -U curl \
  && curl -o /data/server.jar "https://papermc.io/api/v2/projects/paper/versions/$PAPER_VERSION/builds/$PAPER_BUILD/downloads/paper-$PAPER_VERSION-$PAPER_BUILD.jar" \
  && echo "$PAPER_SHA256  /data/server.jar" | sha256sum -c -

VOLUME ["/data"]
WORKDIR /data

ENV MEMORY="1G"

COPY start.sh /start.sh
ENTRYPOINT [ "/start.sh" ]

USER minecraft
EXPOSE 25565