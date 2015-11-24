# Postfix

## Environment Variables
1. **$MYHOSTNAME:** The name of the host. *Ex: mail.example.com*
2. **$MYDOMAIN**: The domain you want to send/receive emails. *Ex: example.com*
3. **$MYNETWORKS**: Defaults to docker host 172.17.0.1. Add any other ip here to authorize servers to send email without authentication
4. **$LMTP_HOST:** Sets the virtual transport host. Must be IP:port. *Ex: 10.0.0.10:24*

## Virtual Domains
You just need to setup $MYHOSTNAME and $MYDOMAINS and the configuration script will configure postfix to use it as virtual domain

## LDAP
Just drop you ldap configuration at /config/ldap and the configuration script will configure postfix to use it automatically. For more information about LDAP and postfix, see [here](http://www.postfix.org/LDAP_README.html)
