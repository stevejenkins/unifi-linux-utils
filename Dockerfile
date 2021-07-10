FROM alpine:3

RUN apk add --no-cache bash openjdk11-jre openssh openssl py3-pip py3-setuptools py3-wheel sshpass 

# dependencies for Nagios plugin
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN pip3 install unifi

COPY nagios/check_unifi /bin/check_unifi
COPY *.sh /bin

RUN chmod +x /bin/check_unifi /bin/*.sh

ENV UAP_USERNAME ubnt
ENV UAP_PASSWORD ubnt

CMD ["docker_usage.sh"]
