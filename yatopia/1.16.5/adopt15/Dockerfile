FROM adoptopenjdk/openjdk15:jre-15.0.2_7-alpine

LABEL org.opencontainers.image.documentation="https://github.com/Cubxity/docker-minecraft-server"
LABEL org.opencontainers.image.authors="Cubxity <cubxity@protonmail.com>"
LABEL org.opencontainers.image.source="https://github.com/Cubxity/docker-minecraft-server"
LABEL org.opencontainers.image.version="yatopia-1.16.5-adopt15"

RUN addgroup -g 1000 minecraft \
  && adduser -Ss /bin/false -u 1000 -G minecraft -h /home/minecraft minecraft \
  && mkdir -m 775 /data \
  && chown minecraft:minecraft /data

ENV YATOPIA_VERSION 1.16.5
ENV YATOPIA_BUILD 76

RUN apk add --no-cache -U curl \
  && curl -o /server.jar "https://ci.codemc.io/job/YatopiaMC/job/Yatopia/job/ver%2F$YATOPIA_VERSION/$YATOPIA_BUILD/artifact/target/yatopia-$YATOPIA_VERSION-yatoclip-b$YATOPIA_BUILD.jar"

VOLUME ["/data"]
WORKDIR /data

ENV MEMORY="1G"

COPY start.sh /start.sh
ENTRYPOINT [ "/start.sh" ]

USER minecraft
EXPOSE 25565
