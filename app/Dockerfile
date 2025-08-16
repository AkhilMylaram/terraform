# Build stage
FROM openjdk:11 AS BUILD_IMAGE
RUN apt update && apt install maven -y
COPY . /app
WORKDIR /app
RUN mvn clean package -DskipTests

# Debug: List target directory contents
RUN ls -la /app/target/

# Production stage
FROM tomcat:9-jre11

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file (use wildcard to match actual filename)
COPY --from=BUILD_IMAGE /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Debug: Verify WAR file exists
RUN ls -la /usr/local/tomcat/webapps/

# Expose port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]