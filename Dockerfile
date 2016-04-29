FROM debian:jessie

MAINTAINER Tyrone<tyrone.dev@gmail.com>

# Install Supervisor
# Download and install Factom
RUN apt-get update && apt-get -qy install supervisor curl \
&& curl -sSL http://factom.org/downloads/factom.deb -o /factom.deb \
&& dpkg --force-architecture -i factom.deb \
&& useradd -m factom \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

USER factom
WORKDIR /home/factom

RUN mkdir /home/factom/.factom

VOLUME /home/factom/.factom

EXPOSE 8088 8089 8090
CMD ["/usr/bin/supervisord"]
