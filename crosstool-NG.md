# build ct-ng on OSX

## get the souce code

### get the stable version

```bash
wget http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-1.23.0.tar.xz
```

### download the key

```bash
gpg --keyserver http://pgp.surfnet.nl --recv-keys 35B871D1 11D618A4
```

### download the sig

```bash
wget http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-1.23.0.tar.xz.sig
tar Jxf crosstool-ng-1.23.0.tar.xz
```

### verify the source code sig

```bash
gpg --verify crosstool-ng-VERSION.tar.bz2.sig
```

## run bootstrap

if you are clone from git, need to run the following script.

```bash
./bootstrap
```

## configure

--prefix in the following command designate the location to install the crosstool 

```bash
./configure --prefix=/Volume/workspace/ct-ng
```

## make

## make install

this will install to /Volume/workspace/ct-ng

## add ct-ng tool path 

```bash
export PATH="${PATH}:/Volume/workspace/ct-ng/bin"
```

may need to restart the console to make path working after add above line to
~/.bash_profile

# make crosstool

## select a platform.

```bash
ct-ng armv7-rpi2-linux-gnueabihf
```

# change the setting 

```bash
ct-ng menuconfig
```

## build the crosstool

```bash
ct-ng build
```
