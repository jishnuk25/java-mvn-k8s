# first stage using ubuntu image for git clone
FROM ubuntu:latest As Git

# install git
RUN apt-get update && \
         apt-get install -y git

WORKDIR /app

# cloning the application from github to the work directory(/app)
RUN git clone https://github.com/jishnuk25/java-mvn-k8s.git

# the second stage of our build will use a maven 3.6.1 parent image
FROM maven:3.6.1-jdk-8-alpine AS MAVEN_BUILD

WORKDIR /app

# copying the source code from first stage to here
COPY --from=Git /app/java-mvn-k8s /app

RUN mvn clean install

FROM tomcat:jre8-alpine

LABEL maintainer="jishnu.k"

COPY --from=MAVEN_BUILD /app/target/*.war /usr/local/tomcat/webapps

ADD tomcat/postgresql-42.2.23.jar /usr/local/tomcat/lib/

ADD tomcat/*.xml /usr/local/tomcat/conf/

EXPOSE 8080

CMD [ "catalina.sh", "run" ]