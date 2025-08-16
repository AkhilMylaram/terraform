# Build stage
FROM openjdk:11-jdk-slim AS BUILD_IMAGE

# Install Maven and clean up in single layer
RUN apt-get update && \
    apt-get install -y maven && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy source and build
COPY . /app
WORKDIR /app
RUN mvn clean package -DskipTests

# Production stage
FROM tomcat:9-jre11-slim

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file
COPY --from=BUILD_IMAGE /app/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

# Expose port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]