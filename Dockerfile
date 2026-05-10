FROM ubuntu:latest AS build

RUN apt-get update && apt-get install -y openjdk-26-jdk maven

WORKDIR /app
COPY . .
RUN mvn clean install

FROM ubuntu:latest
RUN apt-get update 
RUN apt-get install -y openjdk-26-jre

WORKDIR /app
COPY --from=build /target/todolist-1.0.0.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]