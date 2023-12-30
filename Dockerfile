# Use an official Maven image as the base image
FROM maven as build

#FROM maven:3.8.4-openjdk-11-slim AS build
# Set the working directory in the container
WORKDIR /app
# Copy the pom.xml and the project files to the container
COPY pom.xml .
COPY src ./src
# Build the application using Maven
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jdk-alpine
VOLUME /tmp
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar ./app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
