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

# Copy content from /run/data/ to /data/.
# This is useful for mounting read-only filesystem such as ConfigMaps in Kubernetes.
if [ -d /run/data ]; then
   cp -rf /run/data/ /
fi

# Environment variables
INIT_MEMORY=${INIT_MEMORY:-${MEMORY}}
MAX_MEMORY=${MAX_MEMORY:-${MEMORY}}

JVM_XX_OPTS=${JVM_XX_OPTS:-"-XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 $JVM_XX_OPTS_EXTRA"}
JVM_OPTS=${JVM_OPTS:-"-Xms$INIT_MEMORY -Xmx$MAX_MEMORY $JVM_OPTS_EXTRA"}
D_OPTS=${D_OPTS:-"-DIReallyKnowWhatIAmDoingISwear -DPaper.IgnoreJavaVersion=true -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true $D_OPTS_EXTRA"}

if isTrue "$EULA"; then
  D_OPTS="$D_OPTS -Dcom.mojang.eula.agree=true"
fi

# Start the server
# shellcheck disable=SC2086 disable=SC2068
exec java $JVM_XX_OPTS $JVM_OPTS $D_OPTS -jar /server.jar $@
