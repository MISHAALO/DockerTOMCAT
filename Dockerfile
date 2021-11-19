   FROM centos:7

   RUN yum update -y && yum install -y java-1.8.0-openjdk-devel nano curl htop git
   COPY files /tmp/files
   RUN tar xzfv /opt/apache-maven*.tar.gz -C /opt/ && \
       ln -s /opt/apache-maven-3.3.9/bin/mvn /usr/bin/mvn && \
       groupadd -g 567 tomcat &&\
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
   EXPOSE 8080
   CMD ["nginx", "-g", "daemon off;"]
