FROM openjdk:11

WORKDIR /app

# Copy WAR first (early stage)
COPY LibraryManagementSystem.war /app/ROOT.war

# Install wget and tomcat
RUN apt-get update && \
    apt-get install -y wget unzip && \
    wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.100/bin/apache-tomcat-9.0.100.tar.gz && \
    tar -xvzf apache-tomcat-9.0.100.tar.gz && \
    mv apache-tomcat-9.0.100 tomcat && \
    rm apache-tomcat-9.0.100.tar.gz && \
    mv /app/ROOT.war /app/tomcat/webapps/ROOT.war

EXPOSE 8080

# Add delay and verbose startup
CMD ["bash", "-c", "sleep 5 && ./tomcat/bin/catalina.sh run"]
