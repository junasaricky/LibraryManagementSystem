FROM openjdk:11

WORKDIR /app

# Copy your WAR file into the image
COPY target/LibraryManagementSystem.war /usr/local/tomcat/webapps/

# Download and set up Tomcat
RUN apt-get update && \
    apt-get install -y curl && \
    curl -O https://downloads.apache.org/tomcat/tomcat-9/v9.0.85/bin/apache-tomcat-9.0.85.tar.gz && \
    tar -xvzf apache-tomcat-9.0.85.tar.gz && \
    mv apache-tomcat-9.0.85 tomcat && \
    rm apache-tomcat-9.0.85.tar.gz

# Move the WAR file into Tomcat’s webapps folder
RUN mv /usr/local/tomcat/webapps/LibraryManagementSystem.war ./tomcat/webapps/

EXPOSE 8080

CMD ["./tomcat/bin/catalina.sh", "run"]