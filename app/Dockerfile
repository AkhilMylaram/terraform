# Stage 1: Build the application
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Deploy the WAR to Tomcat
FROM tomcat:9.0-jdk17
WORKDIR /usr/local/tomcat/webapps/
COPY --from=builder /app/target/*.war ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
