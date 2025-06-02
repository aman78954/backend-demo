# Use an official OpenJDK image as base
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy Maven wrapper and pom.xml files
COPY .mvn .mvn
COPY mvnw .
COPY pom.xml .

# Make the Maven wrapper executable ✅✅✅
RUN chmod +x mvnw

# Download dependencies (optional but improves cache)
RUN ./mvnw dependency:go-offline

# Copy the entire project
COPY . .

# Package the application
RUN ./mvnw clean package -DskipTests

# Run the app
CMD ["java", "-jar", "target/springboot-mongodb-demo-0.0.1-SNAPSHOT.jar"]
