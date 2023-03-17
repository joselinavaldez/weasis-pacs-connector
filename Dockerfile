# Stage 1: Build the application with maven and tomcat
# docker build -t joselinavaldez/weasis:latest .
FROM maven:3.8.1 as builder

RUN mkdir /usr/src/app
WORKDIR /usr/src/app

# Copy Files
COPY src /usr/src/app/src
COPY pom.xml /usr/src/app/pom.xml

RUN mvn package

FROM tomcat:9.0.73

ENV WORKPATH /usr/local
ENV CATALINA_HOME /usr/local/tomcat
ENV CATALINA_BASE /usr/local/tomcat

ENV PATH $PATH:$CATALINA_HOME/bin:$CATALINA_HOME/lib

EXPOSE 8080

WORKDIR /usr/local/tomcat/webapps
COPY --from=builder /usr/src/app/target/weasis-pacs-connector.war .

CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]



