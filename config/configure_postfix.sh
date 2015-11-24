#!/bin/bash

DOCKER_HOST=172.17.0.1

if [ "$MYNETWORKS" ]; then 
  echo "Setting up mynetworks with $DOCKER_HOST, $MYNETWORKS"
  postconf -e "mynetworks=$DOCKER_HOST, $MYNETWORKS"
else
  echo "Setting up mynetworks with $DOCKER_HOST"
  postconf -e "mynetworks=$DOCKER_HOST"
fi

if [ "$MYDOMAIN" ]; then 
  echo "Setting up mydomain with $MYDOMAIN"
  postconf -e "mydomain=$MYDOMAIN"
fi

if [ "$MYHOSTNAME" ]; then 
  echo "Setting up mydomain with $MYHOSTNAME"
  postconf -e "mydomain=$MYHOSTNAME"
  fi
