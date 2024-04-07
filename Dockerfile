FROM maven:latest AS build
WORKDIR /app
COPY pom.xml /app
RUN mvn dependency:resolve
COPY . /app
RUN mvn clean
RUN mvn package -DskipTests -X

FROM openjdk:17
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8081;
CMD ["java", "-jar", "app.jar"]
LABEL authors="regulus.seck"
