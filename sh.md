# lede config

## /etc/config/dropbear

```bash
root@LEDE:/# cat /etc/config/dropbear
config dropbear
        option PasswordAuth 'on'
        option RootPasswordAuth 'on'
        option Port         '22'
#       option BannerFile   '/etc/banner'
```
## generate server private key

```bash
root@LEDE:/# dropbearkey -t rsa -f /etc/dropbear/dropbear_rsa_host_key
Generating key, this may take a while...
Public key portion is:
.....
```
This key is used to verify the server it the right server.

## generate key on host

ssh-keygen command will generate the key into .ssh/id_rsa.
The public key is in /Users/pandysong/.ssh/id_rsa.pub.

```bash
pandy-songmatoMacBook-Air:pandysong pandysong$ ssh-keygen -b 4096 -t rsa
Generating public/private rsa key pair.
Enter file in which to save the key (/Users/pandysong/.ssh/id_rsa):
/Users/pandysong/.ssh/id_rsa already exists.
Overwrite (y/n)? y
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /Users/pandysong/.ssh/id_rsa.
Your public key has been saved in /Users/pandysong/.ssh/id_rsa.pub.
```

## copy the public key to target

copy the content in ~/.ssh/id_rsa.pub in host to target /root/.ssh/authorized_keys

```bash
vim /root/.ssh/authorized_keys
```

## restart dropbear

```bash
/etc/init.d/dropbear restart
```

## which port are open ?


```bash
netstat -lntu
```

# connection refused

Note that in the lede, there are firewall enabled by default.
Need to open port for ssh connection

in lede: /etc/config/firewall, add following rule to firewall configuration to
open the port for ssh connection.

```bash
config rule
    option src              wan
    option dest_port        22
    option target           ACCEPT
    option proto            tcp
```

# restart the firewall

```bash
/etc/init.d/firewall restart
```
# ssh

```bash

pandy-songmatoMacBook-Air:script pandysong$ ssh root@192.168.100.110
The authenticity of host '192.168.100.110 (192.168.100.110)' can't be established.
RSA key fingerprint is SHA256:Ci6fknYPQGfuZ4DykA4dXz0HDpmj3Blu5SAU8b4DLjg.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '192.168.100.110' (RSA) to the list of known hosts.
root@192.168.100.110's password:


BusyBox v1.27.2 () built-in shell (ash)

     _________
    /        /\      _    ___ ___  ___
   /  LE    /  \    | |  | __|   \| __|
  /    DE  /    \   | |__| _|| |) | _|
 /________/  LE  \  |____|___|___/|___|                      lede-project.org
 \        \   DE /
  \    LE  \    /  -----------------------------------------------------------
   \  DE    \  /    Reboot (SNAPSHOT, r4917-253a299)
    \________\/    -----------------------------------------------------------

root@LEDE:~#

```
