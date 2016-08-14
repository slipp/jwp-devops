#!/bin/bash

JAVA_HOME=~/apps/java
PATH=$PATH:$JAVA_HOME/bin

REPOSITORIES_DIR=~/repositories/jwp-adv

cd $REPOSITORIES_DIR
pwd
git pull
./gradlew build -x test

RELEASE_DIR=~/releases/jwp-adv
C_TIME=$(date +%s) 

mkdir -p $RELEASE_DIR/$C_TIME
mv $REPOSITORIES_DIR/build/libs/next-1.0.jar $RELEASE_DIR/$C_TIME
echo "deploy source $RELEASE_DIR/$C_TIME directory"

pkill -f 'java.*next*'

rm -rf $RELEASE_DIR/ROOT
ln -s $RELEASE_DIR/$C_TIME $RELEASE_DIR/ROOT

java -jar -Dspring.profiles.active=production -Dserver.port=7070 $RELEASE_DIR/ROOT/next-1.0.jar &
java -jar -Dspring.profiles.active=production -Dserver.port=8080 $RELEASE_DIR/ROOT/next-1.0.jar &
java -jar -Dspring.profiles.active=production -Dserver.port=9090 $RELEASE_DIR/ROOT/next-1.0.jar &