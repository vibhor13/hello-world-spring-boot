FROM thothbot/alpine-jre8
ADD /target/myproject-0.0.1-SNAPSHOT.jar /myproject-0.0.1-SNAPSHOT.jar
EXPOSE 8080:8080
ENTRYPOINT ["/opt/jdk/bin/java","-jar","/myproject-0.0.1-SNAPSHOT.jar"]
