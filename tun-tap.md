# requirement

The network needed is as follows

lede (qemu guest) <--> tun <--> tap0 (192.168.100.110) <--
--> bridge1 (192.168.100.1) <--> NAT <--> en0 (192.168.0.10) <-
--> internet


# tun/tap driver in osx

My OSX version is 10.11.x

I installed this tuntap driver. 
http://downloads.sourceforge.net/tuntaposx/tuntap_20150118.tar.gz


After installation, the /dev/tapX is found:

```bash
$ ls /dev/tap*
/dev/tap0       /dev/tap10      /dev/tap12      /dev/tap14      /dev/tap2
/dev/tap4       /dev/tap6       /dev/tap8
/dev/tap1       /dev/tap11      /dev/tap13      /dev/tap15      /dev/tap3
/dev/tap5       /dev/tap7       /dev/tap9
```

# config `bridge1`

Following the link:

https://blog.san-ss.com.ar/2016/04/setup-nat-network-for-qemu-macosx

here are the small scripts
```bash
#!/bin/sh

sudo ifconfig bridge1 create
sudo ifconfig bridge1 192.168.100.1/24
sudo sysctl -w net.inet.ip.forwarding=1
sudo sysctl -w net.inet.ip.fw.enable=1
sudo pfctl -f ./pfctl-nat-config -e
```
where content of ./pfctl-nat-config is 

```bash
nat on en0 from bridge1:network to any -> (en0)
```
replace 'en0' with the interface name where internet is connected.

# qemu start tap

This will bridge up tap0 when the guest is booting up.
```bash
sudo qemu-system-mipsel \
        -net nic -net tap,ifname=tap0,script=./script/tap-up.sh,downscript=./script/tap-down.sh \
        -M malta \
        -hda lede-malta-le-root.ext4 \
        -kernel lede-malta-le-vmlinux.elf \
        -nographic -append "root=/dev/sda console=ttyS0"
```

# tap-up.sh

```bash
#!/bin/sh
#
TAPDEV="$1"
BRIDGEDEV="bridge1"
#
ifconfig $BRIDGEDEV addm $TAPDEV
```

# tap-down.sh

```bash
#!/bin/sh
#
TAPDEV="$1"
BRIDGEDEV="bridge1"
#
ifconfig $BRIDGEDEV deletem $TAPDEV
```

# booting up the qemu guest

```bash
sudo /usr/libexec/bootpd -dv &
```

## DHCP config

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <key>bootp_enabled</key>
        <false/>
        <key>dhcp_enabled</key>
        <array>
            <string>bridge1</string>
        </array>
        <key>netboot_enabled</key>
        <false/>
        <key>relay_enabled</key>
        <false/>
        <key>Subnets</key>
        <array>
            <dict>
                <key>name</key>
                <string>VM NAT Network (192.168.100.0/24)</string>
                <key>net_mask</key>
                <string>255.255.255.0</string>
                <key>net_address</key>
                <string>192.168.100.0</string>
                <key>net_range</key>
                <array>
                    <string>192.168.100.10</string>
                    <string>192.168.100.254</string>
                </array>
                <key>allocate</key>
                <true/>
                <key>dhcp_router</key>
                <string>192.168.100.1</string>
                <key>dhcp_domain_name_server</key>
                <array>
                    <string>8.8.8.8</string>
                </array>
            </dict>
        </array>
    </dict>
</plist>
```

# ping

## ping from guest
If everything is fine, you could ping from guest to hose

```bash
ping 192.168.100.1

```
## default gateway in guest

You could also ping the host IP address

```bash
ping 192.168.0.10
```

It it fails, Please check the default gateway in guest.

```bash
root@LEDE:~# netstat -r
Kernel IP routing table
Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
default         192.168.100.1   0.0.0.0         UG        0 0          0 eth0
192.168.100.0   *               255.255.255.0   U         0 0          0 eth0
192.168.100.1   *               255.255.255.255 UH        0 0          0 eth0
```

if the default gateway is not 192.168.100.1, this route could be added with
following command:

```bash
route add gw 192.168.100.1 eth0
```
This add the default gateway 192.168.100.1 to interface eth0.

## ping from host to guest

```bash
ping 192.168.100.10
```
# possible problem

If there are additional firewall, then it needs to turned off. 
Some device has security feature, it should be disabled.


# references

https://gist.github.com/tracphil/4353170
