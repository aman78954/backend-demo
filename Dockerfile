# 1. Use lightweight OpenJDK base image
FROM openjdk:17-jdk-slim

# 2. Set working directory
WORKDIR /app

# 3. Copy the JAR file into the container
COPY target/demo-0.0.1-SNAPSHOT.jar app.jar

# 4. Expose default Spring Boot port
EXPOSE 8080

# 5. Run the JAR
CMD ["java", "-jar", "app.jar"]
