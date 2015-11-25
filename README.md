# Postfix

## Basic Environment Variables
1. **$MYHOSTNAME:** The name of the host. *Ex: mail.example.com*
2. **$MYDOMAIN**: The domain you want to send/receive emails. *Ex: example.com*
3. **$MYNETWORKS**: Defaults to docker host 172.17.0.1. Add any other ip here to authorize servers to send email without authentication
4. **$LMTP_HOST:** Sets the virtual transport host. Must be IP:port. *Ex: 10.0.0.10:24*

## LDAP
Just drop you ldap configuration at /config/ldap and the configuration script will configure postfix to use it automatically to search for virtual mailboxes. For more information about LDAP and postfix, see [at postfix's documentation].(http://www.postfix.org/LDAP_README.html)

## SASL
Setup $SASL_HOST (IP:port) and $SASL_TYPE (cyrus or dovecot) and the container will use it to implement SASL authentication

### Local Domains
When your users are stored on your own system (a normal unix user, listed on /etc/passwd), your users will be able to receive mails from the local domains of you server. So, if you server's local domain is domain.com and you have an user bob, he will receive emails as bob@domain.com, and these emails will be stored on /var/mail/bob (or somewhere else you choose). Local domains are configured on postfix's  **$mydestination** entry. Since it makes no sense to create local users inside a docker container, that option is not configurable on this image.

## Virtual Domains
When using virtual mailbox domains, you do not use a normal system user, like in local domains. Instead, you use postfix's **virtual_mailbox_domains** to specify a list of domains you accept emails for. Also, you can tell postfix to look on a *mapping* (2 columns), which stores the user's email address and mailbox directory, through **virtual_mailbox_maps** 

Those mappings can be stored on a database, like LDAP or MySQL, or on text files, that need to be converted using *postmap* command. This image supports *LDAP* as storage database for virtual mailboxes maps and uses textfiles to virtual domains. You just need to define **$MYHOSTNAME** and **$MYDOMAIN** variables and the configuration script will add these entries as virtual domains.
