[![License](https://img.shields.io/github/license/Cubxity/docker-minecraft-server?style=flat-square)](LICENSE)
[![Issues](https://img.shields.io/github/issues/Cubxity/docker-minecraft-server?style=flat-square)](https://github.com/Cubxity/docker-minecraft-server/issues)
[![Discord](https://img.shields.io/badge/join-discord-blue?style=flat-square)](https://discord.gg/kDDhqJmPpA)

# docker-minecraft-server

Lightweight Docker/container images for Paper-based Minecraft servers.

## Running

> **NOTE:** By running the following command, you accept [Minecraft's EULA](https://www.minecraft.net/en-us/eula).

> **WARNING:** The following container is **ephemeral**, meaning any changes made to it will be discarded.

```shell
$ docker run --rm -it \
  -e EULA=true \
  -e JVM_OPTS_EXTRA=--add-modules=jdk.incubator.vector \
  -p 25565:25565 \
  ghcr.io/cubxity/minecraft-server:pufferfish-1.19-java17-slim-bullseye
```

> **Note:** `JVM_OPTS_EXTRA=--add-modules=jdk.incubator.vector` is only required for Pufferfish.

- `--rm` removes the container on exit
- `-i` keeps STDIN open
- `-t` allocates a pseudo-TTY
- `-e EULA=true` sets the `EULA` environment variable to true, signifying EULA agreement
- `-p 25565:25565` publish container port 25565 to the host on 0.0.0.0:25565

This image makes use of Aikar's flags by default. The data directory can be found at `/data`.

## Environment Variables

- `MEMORY` defaults to `1G`
- `INIT_MEMORY` Initial memory to allocate to the JVM. Defaults to `MEMORY`
- `MAX_MEMORY` Maximum memory to allocate to the JVM. Defaults to `MEMORY`
- `JVM_XX_OPTS` -XX JVM argument overrides
- `JVM_OPTS` JVM arguments (mainly memory) overrides
- `D_OPTS` JVM properties overrides
- `JVM_XX_OPTS_EXTRA` -XX JVM argument to append
- `JVM_OPTS_EXTRA` JVM arguments to append
- `D_OPTS_EXTRA` JVM properties to append
- `EULA` Signifies that you accept [Minecraft's EULA](https://www.minecraft.net/en-us/eula). Accept by setting this
  variable to`true`.

Implementation can be found in [start.sh](bin/start.sh).

> **Tips:** Set environment `JVM_OPTS_EXTRA=--add-modules=jdk.incubator.vector` to enable vector module for Pufferfish.

## Image Variants

This repository provides Azul Zulu and Eclipse Temurin based container images for **Pufferfish**,
**Purpur**, and **Paper**.

> **NOTE:** OpenJDK images are **deprecated** in favor of Azul Zulu and Temurin.
> Support for non-LTS versions may be dropped at any time.

> **NOTE:** Airplane is discontinued. Please use Pufferfish or Purpur instead.

### Azul Zulu Debian (`java*-slim-bullseye`)

Supports `linux/amd64` and `linux/arm64`.

This image is based on Azul Zulu's Debian slim Bullseye image. The image format is suffixed
with `-java<version>-slim-bullseye`.

**Examples:**

- `pufferfish-1.19-java17-slim-bullseye`
- `pufferfish-1.19-34-java17-slim-bullseye`

### Eclipse Temurin Alpine (`temurin*-alpine`)

Supports `linux/amd64`.

This image is based on Eclipse Temurin's Alpine image. The image format is suffixed with `-temurin<version>-alpine`.

**Examples:**

- `pufferfish-1.19-temurin17-alpine`
- `pufferfish-1.19-34-temurin17-alpine`
