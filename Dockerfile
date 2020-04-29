# Dockerfile.jenkinsAgent
FROM debian:stretch-backports
ARG JENKINSUID
ARG JENKINSGID
ARG DOCKERGID

# Install Docker in the image, which adds a docker group
RUN apt-get -y update && \
 apt-get -y install \
   apt-transport-https \
   ca-certificates \
   curl \
   gnupg \
   lsb-release \
   software-properties-common

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

RUN apt-get -y update && \
 apt-get -y install \
   docker-ce \
   docker-ce-cli \
   containerd.io
   
# Setup users and groups
RUN groupadd -g ${JENKINSGID} jenkins
RUN groupmod -g ${DOCKERGID} docker
RUN useradd -c "Jenkins user" -g ${JENKINSGID} -G ${DOCKERGID} -M -N -u ${JENKINSUID} jenkins
   
FROM tomcat:8.0
ADD **/*.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]