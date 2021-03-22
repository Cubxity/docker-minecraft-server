FROM adoptopenjdk/openjdk15:jre-15.0.1_9-alpine

LABEL org.opencontainers.image.documentation="https://github.com/Cubxity/docker-minecraft-server"
LABEL org.opencontainers.image.authors="Cubxity <cubxity@protonmail.com>"
LABEL org.opencontainers.image.source="https://github.com/Cubxity/docker-minecraft-server"
LABEL org.opencontainers.image.version="tuinity-adopt15"

RUN addgroup -g 1000 minecraft \
  && adduser -Ss /bin/false -u 1000 -G minecraft -h /home/minecraft minecraft \
  && mkdir -m 775 /data \
  && chown minecraft:minecraft /data

ENV TUINITY_BUILD 215

RUN apk add --no-cache -U curl \
  && curl -o /server.jar "https://ci.codemc.io/job/Spottedleaf/job/Tuinity/$TUINITY_BUILD/artifact/tuinity-paperclip.jar"

VOLUME ["/data"]
WORKDIR /data

ENV MEMORY="1G"

COPY start.sh /start.sh
ENTRYPOINT [ "/start.sh" ]

USER minecraft
EXPOSE 25565