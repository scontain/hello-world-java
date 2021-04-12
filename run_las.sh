#!/bin/bash

function determine_sgx_device {
    export SGXDEVICE="/dev/sgx"
    export MOUNT_SGXDEVICE="-v /dev/sgx/:/dev/sgx"
    if [[ ! -e "$SGXDEVICE" ]] ; then
        export SGXDEVICE="/dev/isgx"
        export MOUNT_SGXDEVICE="--device=/dev/isgx"
        if [[ ! -c "$SGXDEVICE" ]] ; then
            echo "Warning: No SGX device found!" > /dev/stderr
            export MOUNT_SGXDEVICE=""
            export SGXDEVICE=""
        fi
    fi
}

function start_las() {
    echo "Prepare one-time LAS"
cat > docker-compose.yml << EOF
version: '3.2'
services:
    las:
        image: registry.scontain.com:5050/sconecuratedimages/services:las-scone5.3.0
        devices:
          - ${SGXDEVICE}:${SGXDEVICE}
        ports:
          - target: 18766
            published: 18766
            protocol: tcp
            mode: host
EOF
if [[ -z $(netstat -tuln | grep 18766) ]]; then
    echo "Attempt to start local LAS"
    docker-compose up -d las
    sleep 5
    echo "LAS should work by now..."
fi
}

function stop_las() {  
  # stop las if we started it
  echo "Attempt to stop local LAS"
  docker-compose down || true
  rm -rf docker-compose.yml 
}