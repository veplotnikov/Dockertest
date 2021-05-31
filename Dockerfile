FROM ubuntu:20.04
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt install wget default-jdk  maven git -y
RUN mkdir /opt/boxfuse && mkdir /opt/tomcat
RUN wget https://www-eu.apache.org/dist/tomcat/tomcat-9/v9.0.46/bin/apache-tomcat-9.0.46.tar.gz -P /tmp
RUN tar -xf /tmp/apache-tomcat-9.0.46.tar.gz -C /opt/tomcat/
RUN chown -R tomcat: /opt/tomcat
RUN ln -s /opt/tomcat/apache-tomcat-9.0.46 /opt/tomcat/latest
RUN sh -c 'chmod +x /opt/tomcat/latest/bin/*.sh'
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git /opt/boxfuse/
RUN mvn -f /opt/boxfuse/pom.xml package
RUN cp /opt/boxfuse/target/hello-1.0.war /opt/tomcat/latest/webapps/
RUN mkdir /usr/share/tomcat9/conf/ && cp /etc/tomcat9/server.xml /usr/share/tomcat9/conf/
EXPOSE 8080
CMD ["/opt/tomcat/latest/bin/catalina.sh", "run"]