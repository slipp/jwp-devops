#!/bin/bash

JAVA_HOME={{ java_symbolic_link }}
PATH=$PATH:$JAVA_HOME/bin

REPOSITORIES_DIR={{ repositories_dir }}

rm -rf $REPOSITORIES_DIR
mkdir {{ repositories_base_dir }}
cd {{ repositories_base_dir }}
pwd

git clone {{ source_url }}
cd $REPOSITORIES_DIR
git checkout -b {{ deploy_branch_name }} origin/{{ deploy_branch_name }}

./gradlew build -x test

RELEASE_DIR={{ release_dir }}
C_TIME=$(date +%s) 

mkdir -p $RELEASE_DIR/$C_TIME
mv $REPOSITORIES_DIR/build/libs/next-1.0.jar $RELEASE_DIR/$C_TIME
echo "deploy source $RELEASE_DIR/$C_TIME directory"

pkill -f 'java.*next*'

rm -rf $RELEASE_DIR/ROOT
ln -s $RELEASE_DIR/$C_TIME $RELEASE_DIR/ROOT

{% for port in ports %}
java -jar -Dspring.profiles.active=production -Dserver.port={{ port }} $RELEASE_DIR/ROOT/next-1.0.jar &
{% endfor %}