# docker-minecraft-server

Lightweight Docker/container images for Paper-based Minecraft servers.

## Running

> **NOTE:** By running the following command, you accept [Minecraft's EULA](https://www.minecraft.net/en-us/eula).

> **WARNING:** The following container is **ephemeral**, meaning any changes made to it will be discarded.

```shell
$ docker run --rm -it -e EULA=true -p 25565:25565 ghcr.io/cubxity/minecraft-server:airplane-1.17-java17-slim-bullseye
```

- `--rm` removes the container on exit
- `-i` keeps STDIN open
- `-t` allocates a pseudo-TTY
- `-e` sets environment variable(s)
- `-p` publish port(s) to the host

This image makes use of Aikar's flags by default. The data directory can be found at `/data`.

## Environment Variables

- `MEMORY` defaults to `1G`
- `INIT_MEMORY` Initial memory to allocate to the JVM. Defaults to `MEMORY`
- `MAX_MEMORY` Maximum memory to allocate to the JVM. Defaults to `MEMORY`
- `EULA` Signifies that you accept [Minecraft's EULA](https://www.minecraft.net/en-us/eula). Accept by setting this
  variable to`true`.

## Image Variants

This repository provides OpenJDK and Eclipse Temurin based container images for **Airplane**, **Airplane-Purpur**, **Purpur**, and
**Paper**.

> **NOTE:** AdoptOpenJDK (`adopt*`) variants are **deprecated** in favor of OpenJDK and Temurin.
> Support for non-LTS versions may be dropped at any time.

> **NOTE:** Tuinity has been merged into Paper. Please use the Paper image instead.

### OpenJDK (`java*-slim-bullseye`)

This image is based on OpenJDK's Debian slim Bullseye image. The image format is suffixed
with `-java<version>-slim-bullseye`.

**Examples:**
- `airplane-1.17-java17-slim-bullseye`
- `airplane-1.17-95-java17-slim-bullseye`

### Eclipse Temurin Alpine (`temurin-alpine`)

This image is based on Eclipse Temurin's Alpine image. The image format is suffixed
with `-temurin<version>-alpine`.

**Examples:**
- `airplane-1.17-temurin17-alpine`
- `airplane-1.17-95-temurin17-alpine`
