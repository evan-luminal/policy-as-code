#! /usr/bin/env bash

# Example:
# $ ./bin/uploadArtifacts.sh myFugueArtifacts
# upload: ./fugue-client_0.27.12-1807_amd64.deb to s3://myFugueArtifacts/fugue-client_0.27.12-1807_amd64.deb
# upload: ./fugue-support_0.5.0-306_amd64.deb to s3://myFugueArtifacts/fugue-support_0.5.0-306_amd64.deb

aws s3 cp fugue-client_0.27.12-1807_amd64.deb s3://$1/
aws s3 cp fugue-support_0.5.0-306_amd64.deb s3://$1/
