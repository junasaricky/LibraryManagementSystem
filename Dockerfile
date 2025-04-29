# Use an OpenJDK image
FROM openjdk:11

# Create working directory
WORKDIR /app

# Update package list and install wget and unzip
RUN apt-get update && apt-get install -y wget unzip curl

# Download and install Tomcat
RUN curl -O https://downloads.apache.org/tomcat/tomcat-9/v9.0.100/bin/apache-tomcat-9.0.100.tar.gz && \
    tar -xvzf apache-tomcat-9.0.100.tar.gz && \
    mv apache-tomcat-9.0.100 tomcat && \
    rm apache-tomcat-9.0.100.tar.gz

# Expose port
EXPOSE 8080

# Start Tomcat
CMD ["./tomcat/bin/catalina.sh", "run"]
