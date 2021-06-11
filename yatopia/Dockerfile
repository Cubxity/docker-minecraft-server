ARG RUNTIME
ARG RUNTIME_NAME

FROM $RUNTIME

ARG YATOPIA_VERSION
ARG YATOPIA_BUILD

LABEL org.opencontainers.image.documentation="https://github.com/Cubxity/docker-minecraft-server"
LABEL org.opencontainers.image.authors="Cubxity <cubxity@protonmail.com>"
LABEL org.opencontainers.image.source="https://github.com/Cubxity/docker-minecraft-server"
LABEL org.opencontainers.image.version="yatopia-${YATOPIA_VERSION}-${YATOPIA_BUILD}-${RUNTIME_NAME}"

RUN addgroup -g 1000 minecraft \
  && adduser -Ss /bin/false -u 1000 -G minecraft -h /home/minecraft minecraft \
  && mkdir -m 775 /data \
  && chown minecraft:minecraft /data \
  && wget -O /server.jar "https://ci.codemc.io/job/YatopiaMC/job/Yatopia/job/ver%252F$YATOPIA_VERSION/$YATOPIA_BUILD/artifact/target/yatopia-$YATOPIA_VERSION-paperclip-b$YATOPIA_BUILD.jar"

COPY bin/start.sh /start.sh

ENV MEMORY="1G"

WORKDIR /data
ENTRYPOINT [ "/start.sh" ]

USER minecraft
EXPOSE 25565
