FROM adoptopenjdk/openjdk11:alpine-jre

LABEL org.opencontainers.image.authors="Cubxity <cubxity@protonmail.com>"
LABEL org.opencontainers.image.source="https://github.com/Cubxity/docker-minecraft-server"
LABEL org.opencontainers.image.version="1.16.5-paper-adopt11"

RUN addgroup -g 1000 minecraft \
  && adduser -Ss /bin/false -u 1000 -G minecraft -h /home/minecraft minecraft \
  && mkdir -m 775 /data \
  && chown minecraft:minecraft /data

ENV PAPER_VERSION 1.16.5
ENV PAPER_BUILD 468
ENV PAPER_SHA256 e6e0a0af461c3befcef2ddd57f555ea4a60122d9f784bdc5ac2ab548067bc1e1

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