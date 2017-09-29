# baresip

# issue

baresip versions could be fetched from by buildroot from

http://www.creytiv.com/pub/

However the openwrt version 15.05 default setting is to get
`baresip-0.4.4.tar.gz` which does not exit anymore.

# solution

The solutions is to use the latest version by changing the feed repo

## change feeds setting

find in openwrt source code root directory the file `feeds.conf.default`.


```bash
cp feeds.conf.default feeds.conf
```

this will copy the default setting file to a file which could be customerized. 

## edit feeds.conf

change the following line 

```bash
src-git telephony https://github.com/openwrt/telephony.git;for-15.05
```
to 

```bash
src-git telephony https://github.com/openwrt/telephony.git
```

This change will ask the `feeds` script to get the latest version instead of the
branch/tag `for-15.05` which uses the old version of baresip.

## update feeds

```bash
./scripts/feeds update
```

## compile the new baresip

```bash
make package/feeds/telephony/baresip/compile
```

the binary should be in directory 

```bash
bin/malta/packages/telephony/baresip-mod-httpd_0.5.5-1_malta_mipsel.ipk
```

## install baresip

```bash
make package/feeds/telephony/baresip/install
```

## update package index

```bash
make package/index
```

## install new ipk

[How to setup a local repo](local-ipkg-repo.md)
