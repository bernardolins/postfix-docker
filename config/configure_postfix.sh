#!/bin/bash

DOCKER_HOST=172.17.0.1

if [ -z "$MYNETWORKS" ]; then 
  postconf -e "mynetworks=$DOCKER_HOST, $MYNETWORKS"
else
  postconf -e "mynetworks=$DOCKER_HOST"
fi

