ARG RUNTIME
ARG RUNTIME_NAME

FROM $RUNTIME

ARG TUINITY_BUILD

LABEL org.opencontainers.image.documentation="https://github.com/Cubxity/docker-minecraft-server"
LABEL org.opencontainers.image.authors="Cubxity <cubxity@protonmail.com>"
LABEL org.opencontainers.image.source="https://github.com/Cubxity/docker-minecraft-server"
LABEL org.opencontainers.image.version="tuinity-${TUINITY_BUILD}-${RUNTIME_NAME}"

RUN addgroup -g 1000 minecraft \
  && adduser -Ss /bin/false -u 1000 -G minecraft -h /home/minecraft minecraft \
  && mkdir -m 775 /data \
  && chown minecraft:minecraft /data \
  && wget -O /server.jar "https://ci.codemc.io/job/Spottedleaf/job/Tuinity/$TUINITY_BUILD/artifact/tuinity-paperclip.jar"

COPY bin/start.sh /start.sh

ENV MEMORY="1G"

WORKDIR /data
ENTRYPOINT [ "/start.sh" ]

USER minecraft
EXPOSE 25565
