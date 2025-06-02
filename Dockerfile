# 1. Use the official OpenJDK image
FROM openjdk:17-jdk-slim

# 2. Set working directory
WORKDIR /app

# 3. Copy only necessary files for Maven wrapper first
COPY mvnw mvnw
COPY .mvn .mvn

# 4. Make mvnw executable
RUN chmod +x mvnw

# 5. Copy pom.xml separately for caching dependencies
COPY pom.xml .

# 6. Pre-fetch dependencies (optional but improves build speed)
RUN ./mvnw dependency:go-offline

# 7. Now copy the rest of the source code
COPY . .

# 8. Package the app (skip tests)
RUN ./mvnw clean package -DskipTests

# 9. Run the built JAR
CMD ["java", "-jar", "target/springboot-mongodb-demo-0.0.1-SNAPSHOT.jar"]
