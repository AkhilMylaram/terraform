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

# Create non-root user for security
RUN groupadd -r tomcat && useradd -r -g tomcat tomcat

# Remove default webapps and set permissions
RUN rm -rf /usr/local/tomcat/webapps/* && \
    chown -R tomcat:tomcat /usr/local/tomcat

# Copy WAR file
COPY --from=BUILD_IMAGE /app/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war
RUN chown tomcat:tomcat /usr/local/tomcat/webapps/ROOT.war

# Switch to non-root user
USER tomcat

# Expose port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]