# Use a lightweight base image with OpenJDK 8
FROM openjdk:8-jre-alpine

# Set the working directory
WORKDIR /app

# Copy the JAR file from the target directory to the container's working directory
COPY target/calculator-1.0-SNAPSHOT.jar .

# Expose the port that Spark Java is listening on (default: 4567)
EXPOSE 4567

# Set the command to run your application using the JAR file
CMD ["java", "-jar", "calculator-1.0-SNAPSHOT.jar"]
