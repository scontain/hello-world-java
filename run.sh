#!/bin/bash
set -e
# we usually run Kubernetes and this won't be necessary, 
# but for this example we will use local LAS service.
source run_las.sh

determine_sgx_device &&\
start_las && \
echo "Run sconified image..." && \
docker run -it --rm  --network=host $MOUNT_SGXDEVICE \
-eSCONE_VERSION=1 \
-eSCONE_LD_DEBUG=1 \
-eSCONE_MODE=hw \
-eSCONE_LOG="7" \
-ePATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/jvm/java-11-openjdk/jre/bin:/usr/lib/jvm/java-11-openjdk/bin" \
-eLANG="C.UTF-8" \
-eJAVA_TOOL_OPTIONS="-Xmx256m" \
-eLD_LIBRARY_PATH="/usr/lib/jvm/java-11-openjdk/lib/server:/usr/lib/jvm/java-11-openjdk/lib:/usr/lib/jvm/java-11-openjdk/../lib:/" \
-eJAVA_HOME="/usr/lib/jvm/java-11-openjdk" \
hello-world-java-scone java /app/HelloWorld.java && \
stop_las
