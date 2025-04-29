# Use OpenJDK
FROM openjdk:11

# Working directory
WORKDIR /app

# Copy project files
COPY . /app

# Install Tomcat
RUN apt-get update && \
    apt-get install -y wget unzip && \
    wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.85/bin/apache-tomcat-9.0.85.tar.gz && \
    tar -xvzf apache-tomcat-9.0.85.tar.gz && \
    mv apache-tomcat-9.0.85 tomcat && \
    rm apache-tomcat-9.0.85.tar.gz

# Copy webapp files to tomcat/webapps/ROOT
COPY ./src/main/webapp ./tomcat/webapps/ROOT

# Expose port
EXPOSE 8080

# Run Tomcat
CMD ["./tomcat/bin/catalina.sh", "run"]
