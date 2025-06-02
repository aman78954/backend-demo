# Use official OpenJDK image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy wrapper scripts first and make them executable
COPY mvnw .
COPY .mvn .mvn
RUN chmod +x mvnw

# Copy pom.xml and download dependencies
COPY pom.xml .
RUN ./mvnw dependency:go-offline

# Now copy the rest of the app source
COPY . .

# Build the project (skip tests)
RUN ./mvnw clean package -DskipTests

# Run the built jar
CMD ["java", "-jar", "target/springboot-mongodb-demo-0.0.1-SNAPSHOT.jar"]
