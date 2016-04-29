FROM debian:jessie

MAINTAINER Tyrone<tyrone.dev@gmail.com>

ADD http://factom.org/downloads/factom.deb ./

# Install Supervisor
# Download and install Factom
RUN apt-get update && apt-get install -y \
    supervisor busybox \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*  \
&& dpkg --force-architecture -i factom.deb \
&& busybox --install \
&& useradd -ms /bin/sh factom

USER factom
WORKDIR /home/factom

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

VOLUME /home/factom/.factom/

EXPOSE 8088 8089 8090
CMD ["/usr/bin/supervisord"]
