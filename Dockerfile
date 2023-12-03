FROM eclipse-temurin:17-jre

# Label add as needed 
LABEL "cubix.homework.owner"="Markgruber Ferenc"

# Create apps directory
RUN mkdir /opt/app && chown 1001 -R /opt/app

# non root user (for higher security) 
USER 1001

WORKDIR /opt/app

# copy frontend app
COPY --chown=1001 frontapp/target/*.jar frontapp.jar

# copy backend app
COPY --chown=1001 backapp/target/*.jar backapp.jar
 
# copy starter script

COPY --chown=1001 start.sh start.sh


CMD ./start.sh

