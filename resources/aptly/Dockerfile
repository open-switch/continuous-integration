FROM debian:stable-slim

RUN apt-get update && apt-get install -y \
    curl \
    jq \
 && rm -rf /var/apt/lists/*

ADD assets/ /opt/resource/
