   FROM ubuntu:16.04

   RUN apt-get update -y && yum install -y java-1.8.0-openjdk-devel git nano curl htop maven
   COPY files /tmp/files
   RUN groupadd -g 567 tomcat &&\
       useradd -m -u 567 -g 567 tomcat &&\
       mkdir -p /d01/ &&\
       tar xvf /tmp/files/apache-tomcat*.tar.gz -C /d01/ &&\
       ln -s /d01/apache-tomcat-* /d01/tomcat &&\
       chown -R tomcat:tomcat /d01/ &&\
       cd /tmp/files
       git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
       cd boxfuse-sample-java-war-hello/
       mvn package
       cd target/
       cp hello-1.0.war /d01/tomcat/webapps/
       rm -rf /tmp/files
   EXPOSE 8081
   CMD ["nginx", "-g", "daemon off;"]
