# Stage 1: Build the application
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Use official Tomcat, run as non-root
FROM tomcat:9.0-jdk17

# Create a non-root user and group (UID/GID 1010)
RUN groupadd -g 1010 vprofile && useradd -u 1010 -g 1010 -d /home/vprofile -m vprofile

# Remove default ROOT webapp and set permissions
RUN rm -rf /usr/local/tomcat/webapps/ROOT && \
    mkdir -p /usr/local/tomcat/webapps && \
    chown -R vprofile:vprofile /usr/local/tomcat && \
    chmod -R 755 /usr/local/tomcat

# Copy the WAR file as ROOT.war
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
RUN chown vprofile:vprofile /usr/local/tomcat/webapps/ROOT.war

USER vprofile

# Set JVM options for Prometheus metrics
ENV CATALINA_OPTS="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9404 -Dcom.sun.management.jmxremote.rmi.port=9404 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Djava.rmi.server.hostname=localhost"

EXPOSE 8080 9404
CMD ["catalina.sh", "run"]


# Create a non-root user and group (UID/GID 1000 is a common convention)
# Create a non-root user and group (UID/GID 1000 is a common convention)
# Using a non-root user limits the permissions available inside the container.
# Running as non-root is a best practice for container security.
# This Dockerfile follows security best practices by avoiding the use of the root user.

# Using a non-root user in this container provides several security benefits:
# 1. If an attacker tries to install malware or additional software, they cannot do so without root privileges.
# 2. Attempts to modify or delete critical system files will fail, as the non-root user lacks the necessary permissions.
# 3. The attacker cannot bind to privileged ports (below 1024), limiting the ability to run certain network services.
# 4. Access to sensitive host resources, such as device files or kernel interfaces, is restricted for non-root users.