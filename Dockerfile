# Use an OpenJDK image
FROM openjdk:11

# Create working directory
WORKDIR /app

# Copy the application files
COPY . /app

# Install Tomcat (or include your servlet runner)
RUN apt-get update && \
    apt-get install -y wget unzip && \
    wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.85/bin/apache-tomcat-9.0.85.tar.gz && \
    tar -xvzf apache-tomcat-9.0.85.tar.gz && \
    mv apache-tomcat-9.0.85 tomcat

# Move WAR file into Tomcat's webapps folder
# Assuming your project produces a WAR file, adjust accordingly
# If you don't have a WAR file yet, you need to build it first
COPY ./target/your-app.war /tomcat/webapps/ROOT.war

# Expose port
EXPOSE 8080

# Start Tomcat
CMD ["./tomcat/bin/catalina.sh", "run"]
