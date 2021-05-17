FROM adoptopenjdk/openjdk8:jre8u282-b08-alpine

LABEL org.opencontainers.image.documentation="https://github.com/Cubxity/docker-minecraft-server"
LABEL org.opencontainers.image.authors="Cubxity <cubxity@protonmail.com>"
LABEL org.opencontainers.image.source="https://github.com/Cubxity/docker-minecraft-server"
LABEL org.opencontainers.image.version="purpur-1.16.1-adopt8"

RUN addgroup -g 1000 minecraft \
  && adduser -Ss /bin/false -u 1000 -G minecraft -h /home/minecraft minecraft \
  && mkdir -m 775 /data \
  && chown minecraft:minecraft /data

ENV PURPUR_VERSION 1.16.1
ENV PURPUR_BUILD 1112

RUN wget -O /server.jar "https://purpur.pl3x.net/api/v1/purpur/$PURPUR_VERSION/$PURPUR_BUILD/download"

WORKDIR /data

ENV MEMORY="1G"

COPY start.sh /start.sh
ENTRYPOINT [ "/start.sh" ]

USER minecraft
EXPOSE 25565
