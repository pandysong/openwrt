# add baresip pulse module patch

apply the [patch](https://github.com/pandysong/openwrt/blob/master/patch_baresip-mod-pulse.diff) 


# enable pulse module in menu

```bash
make menuconfig
```

Enable the baresip-mod-pulse in the following location:
    
    Network -> Telephony -> baresip -> baresip-mod-pulse


For convenience, select all module, as modules could be selectively installed on
target.

# compile as usual 

```bash
make
```
