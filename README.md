# docker-minecraft-server

Lightweight Docker images for Minecraft server.

## Running

> **NOTE:** By running the following command, you accept [Minecraft's EULA](https://www.minecraft.net/en-us/eula).

> **WARNING:** The following container is **ephemeral**, meaning any changes made to it will be discarded.

```shell
$ docker run --rm -it -e EULA=true -p 25565:25565 cubxity/minecraft-server:purpur-1.16.5-adopt16
```

This image makes use of Aikar's flags by default. The data directory can be found at `/data`.

## Environment variables

- `MEMORY` defaults to `1G`
- `INIT_MEMORY` Initial memory to allocate to the JVM. Defaults to `MEMORY`
- `MAX_MEMORY` Maximum memory to allocate to the JVM. Defaults to `MEMORY`
- `EULA` Signifies that you accept [Minecraft's EULA](https://www.minecraft.net/en-us/eula). Accept by setting this
  variable to`true`.

## Variants

Images are based on adoptopenjdk's alpine images.

- **Paper**: `paper-{version}-{runtime}`, `paper-{version}-{build}-{runtime}`, example: `paper-1.16.5-adopt16`, `paper-1.16.5-776-adopt16`.
- **Tuinity**: `tuinity-{runtime}`, `tuinity-{build}-{runtime}`, example: `tuinity-adopt16`, `tuinity-239-adopt16`.
- **Purpur**: `purpur-{version}-{runtime}`, `purpur-{version}-{build}-{runtime}`, example: `purpur-1.16.5-adopt16`, `purpur-1.16.5-1169-adopt8`.
- **Yatopia**: `yatopia-{version}-{runtime}`, `yatopia-{version}-{build}-{runtime}`, example: `yatopia-1.16.5-adopt16`, `yatopia-1.16.5-118-adopt16`. **(NOT RECOMMENDED)**
