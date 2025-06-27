
# Stage 1: Build the application
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Use official Tomcat, run as non-root
FROM tomcat:9.0-jdk17

# Ensure the webapps directory exists and is owned by the tomcat user
RUN mkdir -p /usr/local/tomcat/webapps && chown -R tomcat:tomcat /usr/local/tomcat/webapps

# Copy the WAR and set correct ownership
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
RUN chown tomcat:tomcat /usr/local/tomcat/webapps/ROOT.war

# Ensure tomcat user can create directories inside webapps
RUN chmod -R 775 /usr/local/tomcat/webapps

USER tomcat

EXPOSE 8080
CMD ["catalina.sh", "run"]

# This Dockerfile follows security best practices by avoiding the use of the root user.

# Using a non-root user in this container provides several security benefits:
# 1. If an attacker tries to install malware or additional software, they cannot do so without root privileges.
# 2. Attempts to modify or delete critical system files will fail, as the non-root user lacks the necessary permissions.
# 3. The attacker cannot bind to privileged ports (below 1024), limiting the ability to run certain network services.
# 4. Access to sensitive host resources, such as device files or kernel interfaces, is restricted for non-root users.