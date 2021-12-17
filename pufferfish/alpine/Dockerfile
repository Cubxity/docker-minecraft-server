ARG RUNTIME
ARG RUNTIME_NAME

FROM $RUNTIME

ARG PUFFERFISH_VERSION
ARG PUFFERFISH_BUILD
ARG PUFFERFISH_PATH

LABEL org.opencontainers.image.documentation="https://github.com/Cubxity/docker-minecraft-server"
LABEL org.opencontainers.image.authors="Cubxity <cubxity@protonmail.com>"
LABEL org.opencontainers.image.source="https://github.com/Cubxity/docker-minecraft-server"
LABEL org.opencontainers.image.version="pufferfish-${PUFFERFISH_VERSION}-${PUFFERFISH_BUILD}-${RUNTIME_NAME}"

RUN addgroup -g 1000 minecraft \
  && adduser -Ss /bin/false -u 1000 -G minecraft -h /home/minecraft minecraft \
  && mkdir -m 775 /data \
  && chown minecraft:minecraft /data \
  && wget -q -O /server.jar "https://ci.pufferfish.host/job/Pufferfish-$PUFFERFISH_VERSION/$PUFFERFISH_BUILD/artifact/$PUFFERFISH_PATH"

COPY bin/start.sh /start.sh

ENV MEMORY="1G"

WORKDIR /data
ENTRYPOINT [ "/start.sh" ]

USER minecraft
EXPOSE 25565
