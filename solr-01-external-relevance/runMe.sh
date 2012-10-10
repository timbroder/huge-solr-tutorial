#!/bin/bash
MAVEN_OPTS="-Xmx2G -XX:MaxPermSize=128M" mvn clean compile install tomcat7:run

