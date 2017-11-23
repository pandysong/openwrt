# clone repo from github

```bash
git clone https://github.com/lede-project/source.git
```

# get feeds and install feeds

```bash
./script/feeds update -a
./script/feeds install -a
```

# config

```bash
make menuconfig
```
Select needed packages, save and exits.

# compile 

```bash
make
```

