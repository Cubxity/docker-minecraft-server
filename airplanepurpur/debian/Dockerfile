ARG RUNTIME
ARG RUNTIME_NAME

FROM $RUNTIME

ARG AIRPLANEPURPUR_VERSION
ARG AIRPLANEPURPUR_BUILD

LABEL org.opencontainers.image.documentation="https://github.com/Cubxity/docker-minecraft-server"
LABEL org.opencontainers.image.authors="Cubxity <cubxity@protonmail.com>"
LABEL org.opencontainers.image.source="https://github.com/Cubxity/docker-minecraft-server"
LABEL org.opencontainers.image.version="airplanepurpur-${AIRPLANEPURPUR_VERSION}-${AIRPLANEPURPUR_BUILD}-${RUNTIME_NAME}"

RUN groupadd -g 1000 minecraft \
  && useradd -r -s /bin/false -u 1000 -g 1000 -m minecraft \
  && mkdir -m 775 /data \
  && chown minecraft:minecraft /data \
  && curl -sfL -o /server.jar "https://ci.tivy.ca/job/Airplane-Purpur-$AIRPLANEPURPUR_VERSION/$AIRPLANEPURPUR_BUILD/artifact/launcher-airplanepurpur.jar"

COPY bin/start.sh /start.sh

ENV MEMORY="1G"

WORKDIR /data
ENTRYPOINT [ "/start.sh" ]

USER minecraft
EXPOSE 25565
