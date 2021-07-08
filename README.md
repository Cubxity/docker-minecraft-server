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

> **NOTE:** AdoptOpenJDK 15 variants are deprecated. Support Non-LTS versions may be dropped at any time.

Images are based on AdoptOpenJDK's alpine images.

**Paper**: 
- `paper-{version}-{runtime}` (eg. `paper-1.17.1-adopt16`)
- `paper-{version}-{build}-{runtime}` (eg. `paper-1.17.1-90-adopt16`)

**Tuinity**:
- `tuinity-{version}-{runtime}` (eg. `tuinity-1.17.adopt16`)
- `tuinity-{version}-{build}-{runtime}` (eg. `tuinity-1.17-17-adopt16`)
> **NOTE: `version` may not represent the actual Minecraft version. It's the version represented on the CI.**

**Airplane**:
- `airplane-{version}-{runtime}` (eg. `airplane-1.17.1-adopt16`)
- `airplane-{version}-{build}-{runtime}` (eg. `airplane-1.17.1-44-adopt16`)
> **NOTE: `version` may not represent the actual Minecraft version. It's the version represented on the CI.**

**Purpur**:
- `purpur-{version}-{runtime}` (eg. `purpur-1.17.1-adopt16`)
- `purpur-{version}-{build}-{runtime}` (eg. `purpur-1.17.1-1260-adopt16`)
