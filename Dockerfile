FROM whisk/jre:8u45

ENV NEO4J_HOME=/usr/neo4j-community-2.2.1

RUN curl \
  --silent \
  --location \
  --retry 3 \
  "http://neo4j.com/artifact.php?name=neo4j-community-2.2.1-unix.tar.gz" \
    | gunzip \
    | tar x -C /usr/ \
    && ln -s $NEO4J_HOME /usr/neo4j

ADD launch.sh /

RUN chmod +x /launch.sh && \
    sed -i "s|#allow_store_upgrade|allow_store_upgrade|g" /usr/neo4j/conf/neo4j.properties && \
    sed -i "s|#org.neo4j.server.webserver.address|org.neo4j.server.webserver.address|g" /usr/neo4j/conf/neo4j-server.properties && \
    sed -i "s|dbms.security.auth_enabled=true|dbms.security.auth_enabled=false|g" /usr/neo4j/conf/neo4j-server.properties

EXPOSE 7474 1337

VOLUME /usr/neo4j/data/graph.db

## entrypoint
CMD ["/bin/bash", "-c", "/launch.sh"]
