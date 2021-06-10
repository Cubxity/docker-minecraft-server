# docker-minecraft-server

Lightweight Docker images for Minecraft server.

## Running

> **NOTE:** By running the following command, you accept [Minecraft's EULA](https://www.minecraft.net/en-us/eula).

> **WARNING:** The following container is **ephemeral**, meaning any changes made to it will be discarded.

```shell
$ docker run --rm -it -e EULA=true -p 25565:25565 cubxity/minecraft-server:purpur-1.16.5-adopt15
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

- **Paper**: `paper-{version}-{runtime}`, example: `paper-1.16.5-adopt15`.
- **Tuinity**: `tuinity-{runtime}`, example: `tuinity-adopt15`.
- **Purpur**: `purpur-1.16.5-{runtime}`, example: `purpur-1.16.5-adopt15`.
- **Yatopia**: `yatopia-{version}-{runtime}`, example: `yatopia-1.16.5-adopt15`. **(NOT RECOMMENDED)**