FROM debian:jessie

MAINTAINER Tyrone<tyrone.dev@gmail.com>

# Install Supervisor
# Download and install Factom
RUN apt-get update && apt-get install -qy supervisor curl \
&& curl -sSL https://github.com/FactomProject/distribution/releases/download/v0.4.2.1/factom-amd64.deb -o /factom.deb \
&& dpkg -i factom.deb \
&& useradd -u 999 -m factom \
&& mkdir /home/factom/.factom \
&& chown factom /home/factom/.factom \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

VOLUME /home/factom/.factom
ENV HOME /home/factom

EXPOSE 8088 8089 8090
CMD ["/usr/bin/supervisord"]


