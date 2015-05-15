#!/bin/bash

limit=`ulimit -n`
if [ "$limit" -lt 65536 ]; then
    ulimit -n 65536;
fi

.$NEO4J_HOME/bin/neo4j console
