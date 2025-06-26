FROM gradle:8.13-jdk17-alpine AS build

WORKDIR /app
COPY build.gradle .
COPY settings.gradle .
COPY src ./src
COPY gradle ./gradle
RUN gradle build --no-daemon

FROM eclipse-temurin:17-jdk-alpine AS runtime

WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]