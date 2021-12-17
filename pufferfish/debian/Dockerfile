ARG RUNTIME

FROM $RUNTIME

ARG PUFFERFISH_VERSION
ARG PUFFERFISH_BUILD
ARG PUFFERFISH_PATH

LABEL org.opencontainers.image.documentation="https://github.com/Cubxity/docker-minecraft-server"
LABEL org.opencontainers.image.authors="Cubxity <cubxity@protonmail.com>"
LABEL org.opencontainers.image.source="https://github.com/Cubxity/docker-minecraft-server"
LABEL org.opencontainers.image.version="pufferfish-${PUFFERFISH_VERSION}-${PUFFERFISH_BUILD}"

RUN groupadd -g 1000 minecraft \
  && useradd -r -s /bin/false -u 1000 -g 1000 -m minecraft \
  && mkdir -m 775 /data \
  && chown minecraft:minecraft /data \
  && apt-get update && apt-get install -y curl \
  && curl -sfL -o /server.jar "https://ci.pufferfish.host/job/Pufferfish-$PUFFERFISH_VERSION/$PUFFERFISH_BUILD/artifact/$PUFFERFISH_PATH"

COPY bin/start.sh /start.sh

ENV MEMORY="1G"

WORKDIR /data
ENTRYPOINT [ "/start.sh" ]

USER minecraft
EXPOSE 25565
