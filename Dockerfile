FROM ubuntu:20.04
ENV DEBIAN_FRONTEND noninteractive
ENV VERSION=9.0.35
RUN apt-get update && apt install default-jdk  maven git -y
RUN mkdir /opt/boxfuse
RUN wget https://www-eu.apache.org/dist/tomcat/tomcat-9/v${VERSION}/bin/apache-tomcat-${VERSION}.tar.gz -P /tmp
RUN tar -xf /tmp/apache-tomcat-${VERSION}.tar.gz -C /opt/tomcat/
RUN chown -R tomcat: /opt/tomcat
RUN ln -s /opt/tomcat/apache-tomcat-${VERSION} /opt/tomcat/latest
RUN sh -c 'chmod +x /opt/tomcat/latest/bin/*.sh'
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git /opt/boxfuse/
RUN mvn -f /opt/boxfuse/pom.xml package
RUN cp /opt/boxfuse/target/hello-1.0.war /opt/tomcat/latest/webapps/
RUN mkdir /usr/share/tomcat9/conf/ && cp /etc/tomcat9/server.xml /usr/share/tomcat9/conf/
EXPOSE 8080
CMD ["/opt/tomcat/latest/bin/catalina.sh", "run"]