#! /usr/bin/env bash

# Example:
# $ ./bin/getElbDnsName.sh Jenkins
# Jenkins-elb-1173068197.us-east-1.elb.amazonaws.com

fugue status $1 | jq -r '.resources.loadBalancers | .[].value.loadBalancer.DNSName'
