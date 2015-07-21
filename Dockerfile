FROM ubuntu:14.04
MAINTAINER Dwight Spencer

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yq openssh-server && \
      mkdir /var/run/sshd && \
      echo 'root:screencast' | chpasswd && \
      sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
      sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Environment Variables
ENV NAME World
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

