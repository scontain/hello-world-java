#!/bin/bash

docker run -it --rm \
            -v /var/run/docker.sock:/var/run/docker.sock \
            --network=host \
            registry.scontain.com:5050/sconecuratedimages/sconecli:sconify-image-latest sconify_image \
            --name=c_session_name \
            --from=registry.scontain.com:5050/sconecuratedimages/iexecsgx:hello-world-java \
            --to=hello-world-java-scone \
            --service-name=java-service \
            --cas="52.157.211.165" \
            --cas-debug \
            --create-namespace \
            --las="localhost" \
            --cli="registry.scontain.com:5050/sconecuratedimages/sconecli:sconify-image-latest" \
            --crosscompiler="registry.scontain.com:5050/sconecuratedimages/sconecli:sconify-image-latest" \
            --binary-fs \
            --binary="/usr/lib/jvm/java-11-openjdk/bin/java" \
            --fs-dir=/app \
            --heap="12G" \
            --dlopen="2" \
            --no-color \
            --verbose \
            --command="java HelloWorld.java" 