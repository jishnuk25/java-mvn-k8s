FROM tomcat:jre8-alpine

LABEL maintainer="jishnu.k"

ADD target/*.war /usr/local/tomcat/webapps/

ADD tomcat/postgresql-42.2.23.jar /usr/local/tomcat/lib/

ADD tomcat/*.xml /usr/local/tomcat/conf/

EXPOSE 8080

CMD [ "catalina.sh", "run" ]