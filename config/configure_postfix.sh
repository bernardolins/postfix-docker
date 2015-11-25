#!/bin/bash

DOCKER_HOST=172.17.0.1
VIRTUAL_DOMAINS=/etc/postfix/virtual_domains
LDAP_DIR=/config/ldap

if [ "$MYNETWORKS" ]; then 
  echo "Setting up mynetworks with $DOCKER_HOST, $MYNETWORKS"
  postconf -e "mynetworks=$DOCKER_HOST, $MYNETWORKS"
else
  echo "Setting up mynetworks with $DOCKER_HOST"
  postconf -e "mynetworks=$DOCKER_HOST"
fi

if [ "$MYDOMAIN" ]; then 
  echo "Setting up mydomain with $MYDOMAIN"
  echo "${MYDOMAIN}               OK" > $VIRTUAL_DOMAINS
  postconf -e "mydomain=$MYDOMAIN"
fi

if [ "$MYHOSTNAME" ]; then 
  echo "Setting up mydomain with $MYHOSTNAME"
  echo "${MYHOSTNAME}             OK" > $VIRTUAL_DOMAINS
  postconf -e "mydomain=$MYHOSTNAME"
  postconf -e "smtp_banner=$MYHOSTNAME ESMTP"
fi

if [ "$LMTP_HOST" ]; then 
  echo "Setting up virtual_transport with $LMTP_HOST"
  postconf -e "virtual_transport=lmtp:$LMTP_HOST"
fi

if [ "$SASL_HOST" ] && [ "$SASL_TYPE" ]; then
  echo "Setting up virtual_transport with $LMTP_HOST"
  postconf -e "smtpd_sasl_auth_enable = yes"
  postconf -e "smtpd_sasl_path = inet:$SASL_HOST:12345"
  postconf -e "smtpd_sasl_type = $SASL_TYPE"
fi

if [ -a "$VIRTUAL_DOMAINS" ]; then
  echo "Generating virtual_domains"
  postmap hash:$VIRTUAL_DOMAINS
fi

for file in "$LDAP_DIR"
do
  if [ $file != $LDAP_DIR ]; then
    postconf -e "virtual_mailbox_maps = proxy:ldap:$file"
    break
  fi
done 
