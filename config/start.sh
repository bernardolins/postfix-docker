#!/bin/bash
service rsyslog start && ./etc/postfix/configure_postfix.sh && postfix start && tail -f /var/log/mail.log
