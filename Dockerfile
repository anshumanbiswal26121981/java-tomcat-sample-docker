# Dockerfile.jenkinsAgent
FROM tomcat:8.0
USER root
ADD **/*.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]