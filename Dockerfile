FROM ubuntu:14.04

MAINTAINER Bernardo Lins <bernardolins28@gmail.com>

RUN apt-get update -y
RUN apt-get install -y postfix postfix-pcre postfix-ldap
