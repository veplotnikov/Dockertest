FROM ubuntu:20.04
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt install default-jdk tomcat9 maven git -y
RUN mkdir /opt/boxfuse
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git /opt/boxfuse/
RUN mvn -f /opt/boxfuse/pom.xml package
RUN cp /opt/boxfuse/target/hello-1.0.war /var/lib/tomcat9/webapps/
RUN mkdir /usr/share/tomcat9/conf/ && cp /etc/tomcat9/server.xml /usr/share/tomcat9/conf/
EXPOSE 8080
CMD ["/usr/share/tomcat9/bin/catalina.sh", "run"]
