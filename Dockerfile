FROM maven:3.6.1-jdk-8-alpine AS MAVEN_BUILD

WORKDIR /app

RUN mvn clean install

FROM tomcat:jre8-alpine

LABEL maintainer="jishnu.k"

COPY --from=MAVEN_BUILD /app/target/*.war /usr/local/tomcat/webapps

ADD tomcat/postgresql-42.2.23.jar /usr/local/tomcat/lib/

ADD tomcat/*.xml /usr/local/tomcat/conf/

EXPOSE 8080

CMD [ "catalina.sh", "run" ]