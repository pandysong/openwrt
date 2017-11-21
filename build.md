#How to build on mac

## update bash

Following below link on updating `bash` needed.

https://apple.stackexchange.com/questions/147005/can-bash-be-replaced-entirely-in-os-x

## build case sensitive disk

Change the name "workspace" with whatever name you like

```bash
hdiutil create -size 15g -type SPARSEBUNDLE -fs JHFS+X -volname workspace
```


## attached the workspace to system

```bash
hdiutil attach ./workspace.sparsebundle
```

## clone the source code to case sensitive disk

Visit in your browser for a list of project in openwrt

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

Since I want to run it on QEMU, select ext4 file system and maltas target for qemu.

## build

```bash
make
```

