#!/bin/bash
set -e
source sgx_device.sh

determine_sgx_device &&\
echo "Run sconified image..." && \
docker run -it --rm  $MOUNT_SGXDEVICE \
-eSCONE_VERSION=1 \
-eSCONE_HEAP=4G \
-eSCONE_MODE=hw \
-eSCONE_LOG="7" \
-ePATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/jvm/java-11-openjdk/jre/bin:/usr/lib/jvm/java-11-openjdk/bin" \
-eLANG="C.UTF-8" \
-eJAVA_TOOL_OPTIONS="-Xmx256m" \
-eLD_LIBRARY_PATH="/usr/lib/jvm/java-11-openjdk/lib/server:/usr/lib/jvm/java-11-openjdk/lib:/usr/lib/jvm/java-11-openjdk/../lib:/" \
-eJAVA_HOME="/usr/lib/jvm/java-11-openjdk" \
hello-world-java-scone java -jar /app/app.jar
