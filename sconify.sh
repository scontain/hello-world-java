#!/bin/bash

docker run -it --rm \
            -v /var/run/docker.sock:/var/run/docker.sock \
            --network=bridge \
            registry.scontain.com:5050/sconecuratedimages/sconecli:sconify-image-latest sconify_image \
            --name=helloWorldJava \
            --from=registry.scontain.com:5050/sconecuratedimages/iexecsgx:hello-world-java \
            --to=hello-world-java-scone \
            --binary-fs \
            --fs-dir=/app \
            --binary="/usr/lib/jvm/java-11-openjdk/bin/java" \
            --heap="9G" \
            --dlopen="2" \
            --no-color \
            --verbose \
            --no-seesion-upload \
            --command="java /app/HelloWorld.java"
