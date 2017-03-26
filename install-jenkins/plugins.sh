#!/bin/bash
# install all plugins ... run this once you know jenkins is up and running ... and that you setup username and password
sudo wget http://localhost:8080/jnlpJars/jenkins-cli.jar

echo -n "What is your Jenkins username: "

read J_USERNAME

echo -n "What is your Jenkins password: "

read -s J_PASSWORD
echo

sudo java -jar jenkins-cli.jar -s http://localhost:8080/jenkins install-plugin msbuild envinject sonar --username "$J_USERNAME" --password "$J_PASSWORD"

sudo java -jar jenkins-cli.jar -s http://localhost:8080/jenkins safe-restart --username "$J_USERNAME" --password "$J_PASSWORD"