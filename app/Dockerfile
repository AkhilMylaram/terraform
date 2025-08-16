# Use OpenJDK 11 as the build image
FROM openjdk:11 AS BUILD_IMAGE
# Update apt and install maven
RUN apt update && apt install maven -y
# Clone the vprofile project repository
RUN git clone https://github.com/devopshydclub/vprofile-project.git
# Checkout docker branch and build the project
RUN cd vprofile-project && git checkout docker && mvn install

# Use Tomcat 9 with JRE 11 as the base image
FROM tomcat:9-jre11

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file from build image to tomcat webapps
COPY --from=BUILD_IMAGE vprofile-project/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080
# Start Tomcat server
CMD ["catalina.sh", "run"]
