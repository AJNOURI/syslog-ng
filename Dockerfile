#FROM phusion/baseimage:0.9.22
FROM ubuntu

# Use baseimage-docker's init system.
#CMD ["/sbin/my_init"]

# Tell debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive


RUN apt-get update && apt-get install -y \
curl htop iftop \
iperf iptraf iputils-tracepath \
links mtr nano nmap rsync \
socat vim wget multitail syslog-ng net-tools iproute2

RUN mv /etc/syslog-ng/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf.bak
ADD syslog-ng.conf /etc/syslog-ng/syslog-ng.conf

RUN touch /var/log/net.log
RUN chown root:adm /var/log/net.log

VOLUME /etc/syslog-ng /var/log

CMD ["syslog-ng","-Fevd"]

