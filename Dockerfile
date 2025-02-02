   FROM centos:7
   ENV TZ=Europe/Moscow
   RUN yum update -y && yum install epel-release -y && yum update -y
   RUN yum install htop nano java-1.8.0-openjdk-devel git wget curl which -y
   COPY files /tmp/files
   RUN tar xzfv /tmp/files/apache-maven*.tar.gz -C /opt/ && \
       ln -s /opt/apache-maven-3.3.9/bin/mvn /usr/bin/mvn && \
       groupadd -g 567 tomcat &&\
       useradd -m -u 567 -g 567 tomcat &&\
       mkdir -p /d01/ &&\
       tar xvf /tmp/files/apache-tomcat*.tar.gz -C /d01/ &&\
       ln -s /d01/apache-tomcat-* /d01/tomcat &&\
       chown -R tomcat:tomcat /d01/ &&\
       cd /tmp/files &&\
       git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git &&\
       cd boxfuse-sample-java-war-hello/ &&\
       mvn package &&\
       cd target/ &&\
       cp hello-1.0.war /d01/tomcat/webapps/ &&\
       rm -rf /tmp/files
   EXPOSE 8080
   CMD /d01/tomcat/bin/catalina.sh run 1>&- 2>&-
