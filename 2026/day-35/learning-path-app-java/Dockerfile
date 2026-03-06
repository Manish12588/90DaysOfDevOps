#Build the project
FROM maven:3.9.6-eclipse-temurin-22-alpine AS build

WORKDIR /app

COPY . .

RUN mvn clean package -DskipTests

CMD ["java","-jar","target/learning-path-app-1.0.0.jar"]