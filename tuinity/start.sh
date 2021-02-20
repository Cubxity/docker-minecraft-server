#!/bin/sh

umask 0002
chmod g+w /data

# Utils
isTrue() {
  result=

  case $1 in
  true | on)
    result=0
    ;;
  *)
    result=1
    ;;
  esac

  return ${result}
}

# Environment variables
INIT_MEMORY=${INIT_MEMORY:=${MEMORY}}
MAX_MEMORY=${MAX_MEMORY:=${MEMORY}}

JVM_XX_OPTS="-XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1"
JVM_OPTS="-Xms$INIT_MEMORY -Xmx$MAX_MEMORY"
D_OPTS="-Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true"

if isTrue "$EULA"; then
  D_OPTS="$D_OPTS -Dcom.mojang.eula.agree=true"
fi

# Start the server
# shellcheck disable=SC2086 disable=SC2068
java $JVM_XX_OPTS $JVM_OPTS $D_OPTS -jar /server.jar $@
