FROM adoptopenjdk/openjdk8:alpine-jre

LABEL org.opencontainers.image.documentation="https://github.com/Cubxity/docker-minecraft-server"
LABEL org.opencontainers.image.authors="Cubxity <cubxity@protonmail.com>"
LABEL org.opencontainers.image.source="https://github.com/Cubxity/docker-minecraft-server"
LABEL org.opencontainers.image.version="1.9.4-paper-adopt8"

RUN addgroup -g 1000 minecraft \
  && adduser -Ss /bin/false -u 1000 -G minecraft -h /home/minecraft minecraft \
  && mkdir -m 775 /data \
  && chown minecraft:minecraft /data

ENV PAPER_VERSION 1.9.4
ENV PAPER_BUILD 773
ENV PAPER_SHA256 c59fb6364955e9209c22a01f1e4699727e08f31c06301d19eef5dd07cfe63edc

RUN apk add --no-cache -U curl \
  && curl -o /server.jar "https://papermc.io/api/v2/projects/paper/versions/$PAPER_VERSION/builds/$PAPER_BUILD/downloads/paper-$PAPER_VERSION-$PAPER_BUILD.jar" \
  && echo "$PAPER_SHA256  /data/server.jar" | sha256sum -c -

VOLUME ["/data"]
WORKDIR /data

ENV MEMORY="1G"

COPY start.sh /start.sh
ENTRYPOINT [ "/start.sh" ]

USER minecraft
EXPOSE 25565