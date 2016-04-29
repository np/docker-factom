FROM buildpack-deps:jessie

MAINTAINER Tyrone<tyrone.dev@gmail.com>

ADD ./factom.deb ./

# Install Supervisor
# Download and install Factom
RUN apt-get update && apt-get install -y \
    supervisor busybox \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* \
&& dpkg --force-architecture -i factom.deb \
&& busybox --install

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

VOLUME /root/.factom/

EXPOSE 8088 8089 8090
CMD ["/usr/bin/supervisord"]
