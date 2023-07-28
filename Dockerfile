# Use a lightweight Java image as the base image
FROM adoptopenjdk:16-jre

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file from the local 'target' directory to the working directory
COPY target/calculator-1.0-SNAPSHOT.jar .

# Expose the port that the application listens on (change if necessary)
EXPOSE 4567

# Command to run the application
CMD ["java", "-jar", "calculator-1.0-SNAPSHOT.jar"]
