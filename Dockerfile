FROM ubuntu:14.04

MAINTAINER Bernardo Lins <bernardolins28@gmail.com>

RUN apt-get update -y
RUN apt-get install -y postfix postfix-pcre postfix-ldap rsyslog

RUN echo "mail.* -/var/log/mail.log" >> /etc/rsyslog.conf
RUN touch /var/log/mail.log && chown syslog:adm /var/log/mail.log

ADD config/configure_postfix.sh /etc/postfix/configure_postfix.sh
RUN chmod +x /etc/postfix/configure_postfix.sh

VOLUME /config/ldap

EXPOSE 25
