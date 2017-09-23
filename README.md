# openwrt

the document and related material with openwrt

Since I am playing in Mac. Below is for user who is using OSX. 

## update bash

following 

https://apple.stackexchange.com/questions/147005/can-bash-be-replaced-entirely-in-os-x

## build case sensitive disk 

change the name "workspace" with whatever name you like 

```bash
hdiutil create -size 15g -type SPARSEBUNDLE -fs JHFS+X -volname workspace
```

## attached the workspace to system

```bash
hdiutil attach ./workspace.sparsebundle
```

## clone the source code to case sensitive disk

visit in your browser for a list of project in openwrt

http://git.openwrt.org

For me, I use the following version:

```bash
git clone git://git.openwrt.org/15.05/openwrt.git
```

## config

```bash
make menuconfig
```

### qemu setting

please select ext4 file system and maltas targeter for qemu


## build

```bash
make -j2 
```

-j command specify the how many parallel jobs used for building.

## run qemu 

### create a seperate qemu running dir

copy the .ext4 and \*vmlinux.elf file to a directory, say "qemu"

### run qemu 

```bash
#!/bin/sh
sudo qemu-system-mipsel -M malta -hda openwrt-malta-le-root.ext4 -kernel openwrt-malta-le-vmlinux.elf -nographic -append "root=/dev/sda console=ttyS0"
```


## setup ipkg repository 

### run http server

in the /bin/packages run the following http server 

```bash
python -m SimpleHTTPServer 8000
```

### add repository in customfeeds.conf

```bash
    root@OpenWrt:/tmp# cat /etc/opkg/customfeeds.conf

    # add your custom package feeds here

    #
    # src/gz example_feed_name http://www.example.com/path/to/files

    src/gz chaos_calmer_base http://10.0.2.2:8000/base
    src/gz chaos_calmer_packages http://10.0.2.2:8000/packages
    src/gz chaos_calmer_luci http://10.0.2.2:8000/luci
    src/gz chaos_calmer_routing http://10.0.2.2:8000/routing
    src/gz chaos_calmer_telephony http://10.0.2.2:8000/telephony
    src/gz chaos_calmer_management http://10.0.2.2:8000/management
```

### remove repository in default configuration

```bash

   root@OpenWrt:/tmp# cat /etc/opkg/distfeeds.conf
   #src/gz chaos_calmer_base
   http://downloads.openwrt.org/chaos_calmer/15.05.1/malta/le/packages/base
   #src/gz chaos_calmer_luci
   http://downloads.openwrt.org/chaos_calmer/15.05.1/malta/le/packages/luci
   #src/gz chaos_calmer_management
   http://downloads.openwrt.org/chaos_calmer/15.05.1/malta/le/packages/management
   #src/gz chaos_calmer_packages
   http://downloads.openwrt.org/chaos_calmer/15.05.1/malta/le/packages/packages
   #src/gz chaos_calmer_routing
   http://downloads.openwrt.org/chaos_calmer/15.05.1/malta/le/packages/routing
   #src/gz chaos_calmer_telephony
   http://downloads.openwrt.org/chaos_calmer/15.05.1/malta/le/packages/telephony
```

## other topic:

if you want to play with crosstool-NG, here is the [document](crosstool-NG.md)
