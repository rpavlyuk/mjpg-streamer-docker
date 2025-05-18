FROM fedora:latest

ENV container=docker

# Install dependencies
RUN dnf -y install \
    gcc make cmake git \
    libjpeg-turbo-devel v4l-utils \
    systemd sudo \
 && dnf clean all

# Clone and build mjpg-streamer
RUN git clone https://github.com/jacksonliam/mjpg-streamer.git /opt/mjpg-streamer \
 && cd /opt/mjpg-streamer/mjpg-streamer-experimental \
 && make \
 && make install

# Add sysconfig file for configuration
COPY mjpg_streamer.sysconfig /etc/sysconfig/mjpg_streamer

# Add systemd unit and enable it
COPY mjpg-streamer.service /etc/systemd/system/mjpg-streamer.service
RUN systemctl enable mjpg-streamer.service

# Entry point script to clean up and run systemd
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

STOPSIGNAL SIGRTMIN+3
CMD ["/entrypoint.sh"]
