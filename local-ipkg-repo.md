# setup ipkg repository

All repository defined in openwrt
/feed.conf.default
are from internet. The version might conflict.

Since a local version of packages has been built, it is possible to play with local repo only.

Here are the steps:

### run http server

in the `bin/packages` run the following http server

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

### update the ipkg list

```bash
root@OpenWrt:/tmp# opkg update
Downloading http://10.0.2.2:8000/base/Packages.gz.
Updated list of available packages in /var/opkg-lists/chaos_calmer_base.
Downloading http://10.0.2.2:8000/base/Packages.sig.
Signature check passed.
Downloading http://10.0.2.2:8000/packages/Packages.gz.
Updated list of available packages in /var/opkg-lists/chaos_calmer_packages.
Downloading http://10.0.2.2:8000/packages/Packages.sig.
Signature check passed.
Downloading http://10.0.2.2:8000/luci/Packages.gz.
Updated list of available packages in /var/opkg-lists/chaos_calmer_luci.
Downloading http://10.0.2.2:8000/luci/Packages.sig.
Signature check passed.
Downloading http://10.0.2.2:8000/routing/Packages.gz.
Updated list of available packages in /var/opkg-lists/chaos_calmer_routing.
Downloading http://10.0.2.2:8000/routing/Packages.sig.
Signature check passed.
Downloading http://10.0.2.2:8000/telephony/Packages.gz.
Updated list of available packages in /var/opkg-lists/chaos_calmer_telephony.
Downloading http://10.0.2.2:8000/telephony/Packages.sig.
Signature check passed.
Downloading http://10.0.2.2:8000/management/Packages.gz.
Updated list of available packages in /var/opkg-lists/chaos_calmer_management.
Downloading http://10.0.2.2:8000/management/Packages.sig.
```


### list specific package

```bash
root@OpenWrt:/tmp# opkg list | grep pj
libpj - 2.4-1 - libpj library
libpjlib-util - 2.4-1 - libpjlib-util library
libpjmedia - 2.4-1 - libpjmedia library
libpjnath - 2.4-1 - libpjnath library
libpjsip - 2.4-1 - libpjsip library
libpjsip-simple - 2.4-1 - libpjsip-simple library
libpjsip-ua - 2.4-1 - libpjsip-ua library
libpjsua - 2.4-1 - libpjsua library
libpjsua2 - 2.4-1 - libpjsua2 library
```

### install the package

```bash
root@OpenWrt:/tmp# opkg install libpjsua2
Package libpjsua2 (2.4-1) installed in root is up to date.
```

opkg will automatically resolve the dependency issues.


# setting for lede project

```bash
cd  bin/targets/malta/le
python -m SimpleHTTPServer 8001 &
cd -
cd bin/packages/mipsel_24kc
python -m SimpleHTTPServer 8000 &
```

/etc/okpg/customfeeds.conf :
```bash
src/gz target http://10.0.2.2:8001/packages
src/gz base http://10.0.2.2:8000/base
src/gz packages http://10.0.2.2:8000/packages
src/gz routing http://10.0.2.2:8000/routing
src/gz telephony http://10.0.2.2:8000/telephony
```

empty /etc/okpg/distfeeds.conf
