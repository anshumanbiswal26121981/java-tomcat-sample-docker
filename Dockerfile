# Dockerfile.jenkinsAgent
FROM centos/python-27-centos7
# Adjust the ownership and permissions as per security audit requirements
ARG USER_ID=997
ARG GROUP_ID=994
RUN groupadd -g $GROUP_ID jenkins && \
    useradd -u $USER_ID -s /bin/sh -g jenkins jenkins
RUN echo "root:root" | chpasswd
RUN echo "jenkins:jenkins" | chpasswd
RUN echo "jenkins ALL=(ALL) ALL" > /etc/sudoers
RUN echo "jenkins ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers
   
FROM tomcat:8.0
ADD **/*.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]