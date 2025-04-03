FROM adoptopenjdk/openjdk11

RUN apt-get update && apt-get install -y maven

ENV APP_HOME=/usr/src/app

WORKDIR $APP_HOME

COPY . .

COPY target/*.jar $APP_HOME/app.jar

COPY src/main/resources/application.properties /usr/src/app/application.properties

EXPOSE 4040

CMD ["java", "-jar", "app.jar"]

