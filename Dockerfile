FROM ubuntu:latest AS build

WORKDIR /app
RUN apt-get update 
RUN apt-get install openjdk-26-jdk maven -y 

COPY . .

RUN mvn clean install

COPY --from=build /usr/lib/jvm /usr/lib/jvm
COPY --from=build /app/target/todolist-1.0.0.jar app.jar

ENV JAVA_HOME=/usr/lib/jvm/default-java
ENV PATH="$JAVA_HOME/bin:$PATH"

FROM openjdk:26-slim

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]