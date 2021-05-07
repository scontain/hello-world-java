#!/bin/bash

docker run -it --rm \
            -v /var/run/docker.sock:/var/run/docker.sock \
            registry.scontain.com:5050/sconecuratedimages/iexec-sconify-image:5.3.3 sconify_iexec \
            --name=helloWorldJava \
            --from=registry.scontain.com:5050/sconecuratedimages/iexecsgx:hello-world-java \
            --to=hello-world-java-scone \
            --binary-fs \
            --fs-dir=/app \
            --host-path=/etc/hosts \
            --host-path=/etc/resolv.conf \
            --binary="/usr/lib/jvm/java-11-openjdk/bin/java" \
            --heap="4G" \
            --dlopen="2" \
            --no-color \
            --verbose \
            --command="java -jar /app/app.jar"
