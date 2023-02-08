FROM eclipse-temurin:17
#LABEL org.opencontainers.image.source = "https://github.com/netwerk-digitaal-erfgoed/modemuze-pipeline"
RUN rm /etc/localtime 
RUN ln -s /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime
WORKDIR /app
RUN mkdir bin
RUN curl -L https://github.com/RMLio/rmlmapper-java/releases/download/v5.0.0/rmlmapper-5.0.0-r362-all.jar -o bin/rmlmapper.jar
RUN curl -L https://dlcdn.apache.org/jena/binaries/apache-jena-4.7.0.tar.gz -o ./apache-jena-4.7.0.tar.gz
RUN tar xfz apache-jena-4.7.0.tar.gz
RUN mv apache-jena-4.7.0 apache-jena
RUN rm -rf apache-jena-4.7.0.tar.gz
ENV JENA_HOME=/app/apache-jena
ENV PATH=$PATH:$JENA_HOME/bin
COPY scripts/* bin/
COPY mappings/ mappings/
COPY sources/ sources/
