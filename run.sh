#!/bin/bash
set -e
# we usually run Kubernetes and this won't be necessary, 
# but for this example we will use local LAS service.
source run_las.sh

start_las && \
echo "Run sconified image..." && \
docker run -it --rm  --network=host --device=/dev/isgx -eSCONE_VERSION=1 hello-world-java-scone && \
stop_las
