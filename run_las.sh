#!/bin/bash

function start_las() {
    echo "Prepare one-time LAS"
cat > docker-compose.yml << EOF
version: '3.2'
services:
    las:
        image: registry.scontain.com:5050/sconecuratedimages/services:las-scone5.3.0
        devices:
          - "/dev/isgx:/dev/isgx"
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
fi
echo "LAS should work by now..."
}

function stop_las() {  
  # stop las if we started it
  echo "Attempt to stop local LAS"
  docker-compose down || true
  rm -rf docker-compose.yml 
}