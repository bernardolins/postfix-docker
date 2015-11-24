FROM ubuntu:14.04

MAINTAINER Bernardo Lins <bernardolins28@gmail.com>

RUN apt-get update -y
RUN apt-get install -y postfix postfix-pcre postfix-ldap

ADD config/configure_postfix.sh /etc/postfix/configure_postfix.sh
RUN chmod +x /etc/postfix/configure_postfix.sh

VOLUME /config/ldap
