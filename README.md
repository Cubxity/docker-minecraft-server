# docker-minecraft-server
Lightweight Docker images for Minecraft server.

## Running
> **NOTE:** By running the following command, you accept [Minecraft's EULA](https://www.minecraft.net/en-us/eula).

```shell
$ docker run --rm -it -e EULA=true -p 25565:25565 cubxity/minecraft-server:1.16.5-paper-adopt15
```
This image makes use of Aikar's flags by default. The root volume is mounted at `/data`.

## Environment variables
- `MEMORY` defaults to `1G`
- `INIT_MEMORY` Initial memory to allocate to the JVM. Defaults to `MEMORY`
- `MAX_MEMORY` Maximum memory to allocate to the JVM.  Defaults to `MEMORY`
- `EULA` Signifies that you accept [Minecraft's EULA](https://www.minecraft.net/en-us/eula). Accept by setting this variable to`true`.

## Variants
Images are based on adoptopenjdk's alpine images.

**Paper**: `{version}-paper-{runtime}`, example: `1.16.5-paper-adopt15`.