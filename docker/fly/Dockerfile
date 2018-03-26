FROM alpine

RUN apk --no-cache add bash curl git

ADD https://github.com/concourse/concourse/releases/download/v3.9.2/fly_linux_amd64 /usr/local/bin/fly
RUN chmod +x /usr/local/bin/fly

