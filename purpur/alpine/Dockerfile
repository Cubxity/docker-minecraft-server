ARG RUNTIME

FROM $RUNTIME

ARG PURPUR_VERSION
ARG PURPUR_BUILD

LABEL org.opencontainers.image.documentation="https://github.com/Cubxity/docker-minecraft-server"
LABEL org.opencontainers.image.authors="Cubxity <cubxity@protonmail.com>"
LABEL org.opencontainers.image.source="https://github.com/Cubxity/docker-minecraft-server"
LABEL org.opencontainers.image.version="purpur-${PURPUR_VERSION}-${PURPUR_BUILD}"

RUN addgroup -g 1000 minecraft \
  && adduser -Ss /bin/false -u 1000 -G minecraft -h /home/minecraft minecraft \
  && mkdir -m 775 /data \
  && chown minecraft:minecraft /data \
  && wget -q -O /server.jar "https://api.pl3x.net/v2/purpur/$PURPUR_VERSION/$PURPUR_BUILD/download"

COPY bin/start.sh /start.sh

ENV MEMORY="1G"

WORKDIR /data
ENTRYPOINT [ "/start.sh" ]

USER minecraft
EXPOSE 25565
