#! /usr/bin/env bash

# Example:
# $ ./bin/getJenkinsPassword.sh 54.89.212.91
# 6bccfc7d4a4d431dbf9984b3522154fa

ssh -l ubuntu $1 sudo cat /var/lib/jenkins/secrets/initialAdminPassword
