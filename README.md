# Postfix

### Getting Started
To run without any configuration:
```
docker run -d -p 25:25 bernardolins/postfix
```

*Extra configuration is provided through environment variables.*

### Basic Environment Variables
1. **$MYHOSTNAME:** The name of the host. *Ex: mail.example.com*
2. **$MYDOMAIN**: The domain you want to send/receive emails. *Ex: example.com*
3. **$MYNETWORKS**: Defaults to docker host 172.17.0.1. Add any other ip here to authorize servers to send email without authentication
4. **$LMTP_HOST:** Sets the virtual transport host. Must be IP:port. *Ex: 10.0.0.10:24*

### Local Domains
When your users are stored on your own system (a normal unix user, listed on /etc/passwd), they will be able to receive mails from the local domains of you server. So, if you server's local domain is domain.com and you have an user bob, he will receive messages as bob@domain.com, and these messages are stored on /var/mail/bob (or somewhere else you choose). Local domains are configurable using postfix's  **mydestination** entry. Since it makes no sense to create local users inside a docker container, that option is not configurable on this image.

### Virtual Domains
When using virtual mailbox domains, you do not use a normal system user, like in local domains. Instead, you use postfix's **virtual_mailbox_domains** to specify a list of domains you accept emails for. Also, you can tell postfix to look on a *mapping* (2 columns), which stores the user's email address and mailbox directory, through **virtual_mailbox_maps**.

Those mappings can be stored on a database, like LDAP or MySQL, or on text files, that need to be converted using *postmap* command. This image supports **LDAP** as storage database for virtual mailboxes maps and uses textfiles to configure virtual domains. You just need to define **$MYHOSTNAME** and **$MYDOMAIN** variables and the configuration script will add these entries as virtual domains.

### Virtual Alias
If you choose just to foward messages to another address, you can tell postfix to tell certain domains as aliases. Like virtual domains, you need to setup a mapping with two columns: the first one is the alias and the second one is the fowarding address. 

For more information about virtual domains and aliases, take a look at [postfix page](http://www.postfix.org/VIRTUAL_README.html)

### LDAP
Just drop you ldap configuration at /config/ldap and the configuration script will tell postfix to use it automatically to search for virtual mailboxes.

```
FROM bernardolins/postfix

ADD ldap.conf /config/ldap/
```

For more information about LDAP and postfix, take a look at [postfix's documentation about LDAP](http://www.postfix.org/LDAP_README.html).

### SMTP Authentication 
Spammers often send messages in the name of another user, turning your server into an open relay. To avoid that, you should configure SMTP authentication. 

#### SASL
This image supports this kind of authentication. You just need to define **$SASL_HOST** (IP:PORT) and **SASL_TYPE** (cyrus or dovecot). *Ex: SASL_HOST=192.168.0.19:12345*

#### MYNETWORKS 
Ips defined on this variable can send emails without authentication. Setup multiple ips separated by comma. *Ex: MYNETWORKS=192.168.0.19,192.168.0.20*
