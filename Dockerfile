FROM debian:jessie
MAINTAINER Shane Starcher <shanestarcher@gmail.com>

RUN \
    apt-get update && \
    apt-get install -y curl ca-certificates --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* 

ENV ENVTPL_VERSION=0.2.3
RUN \
    curl -Ls https://github.com/arschles/envtpl/releases/download/${ENVTPL_VERSION}/envtpl_linux_amd64 > /usr/local/bin/envtpl &&\
    chmod +x /usr/local/bin/envtpl    

RUN \
    curl http://repositories.sensuapp.org/apt/pubkey.gpg | apt-key add - && \
    echo "deb http://repositories.sensuapp.org/apt sensu main" > /etc/apt/sources.list.d/sensu.list

ENV UCHIWA_VERSION=0.15.0-1
RUN \
    apt-get update && \
    apt-get install -y uchiwa=${UCHIWA_VERSION} && \
    rm -rf /var/lib/apt/lists/*    

ADD bin /bin/
ADD templates /config/

EXPOSE 3000

ENTRYPOINT ["/bin/start"]
