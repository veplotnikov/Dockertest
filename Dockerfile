FROM ubuntu:20.04
RUN apt-get update
ENV DEBIAN_FRONTEND noninteractive
RUN apt install tomcat9 maven git -y
RUN mkdir /opt/boxfuse
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git /opt/boxfuse/