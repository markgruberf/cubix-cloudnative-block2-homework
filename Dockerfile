
FROM quay.io/drsylent/cubix/block2/homework-base:java17 

ARG TYPE=frontapp 

# Label add as needed 
LABEL "cubix.homework.owner"="Markgruber Ferenc"

# evironmet variables
ENV CUBIX_HOMEWORK=MarkgruberF 
ENV APP_DEFAULT_MESSAGE=  

# Create apps directory
RUN mkdir /opt/app && chown 1001 -R /opt/app

# non root user (for higher security) 
USER 1001

WORKDIR /opt/app

# copy  app
COPY --chown=1001 ${TYPE}/target/*.jar app.jar
COPY --chown=1001 ${TYPE}/target/start.sh start.sh

CMD ./start.sh


