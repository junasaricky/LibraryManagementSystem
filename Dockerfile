# Use an OpenJDK image
FROM openjdk:11

# Create working directory
WORKDIR /app

# Copy all files from project
COPY . /app

# Install Tomcat (or include your servlet runner)
RUN apt-get update && \
    apt-get install -y wget unzip && \
    wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.85/bin/apache-tomcat-9.0.85.tar.gz && \
    tar -xvzf apache-tomcat-9.0.85.tar.gz && \
    mv apache-tomcat-9.0.85 tomcat

# Move compiled code or WAR if needed
# Copy your compiled .class or .war into tomcat/webapps/
# For simplicity, let’s assume your project structure is already using `webapp/`

# Expose port
EXPOSE 8080

# Start Tomcat
CMD ["./tomcat/bin/catalina.sh", "run"]