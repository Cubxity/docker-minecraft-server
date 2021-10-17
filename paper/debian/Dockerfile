ARG RUNTIME
ARG RUNTIME_NAME

FROM $RUNTIME

ARG PAPER_VERSION
ARG PAPER_BUILD
ARG PAPER_SHA256

LABEL org.opencontainers.image.documentation="https://github.com/Cubxity/docker-minecraft-server"
LABEL org.opencontainers.image.authors="Cubxity <cubxity@protonmail.com>"
LABEL org.opencontainers.image.source="https://github.com/Cubxity/docker-minecraft-server"
LABEL org.opencontainers.image.version="paper-${PAPER_VERSION}-${PAPER_BUILD}-${RUNTIME_NAME}"

RUN groupadd -g 1000 minecraft \
  && useradd -r -s /bin/false -u 1000 -g 1000 -m minecraft \
  && mkdir -m 775 /data \
  && chown minecraft:minecraft /data \
  && RUN apt-get update && apt-get install -y curl \
  && curl -sfL -o /server.jar "https://papermc.io/api/v2/projects/paper/versions/$PAPER_VERSION/builds/$PAPER_BUILD/downloads/paper-$PAPER_VERSION-$PAPER_BUILD.jar" \
  && echo "$PAPER_SHA256  /server.jar" | sha256sum -c -

COPY bin/start.sh /start.sh

ENV MEMORY="1G"

WORKDIR /data
ENTRYPOINT [ "/start.sh" ]

USER minecraft
EXPOSE 25565
