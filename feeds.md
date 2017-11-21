# feeds

How feeds works

## config

Following line is a typical line in feeds

```bash
src-git telephony https://github.com/openwrt/telephony.git
```

It indicates that all packages could be maintained in github.
BTW it also support `src-svn` commands. Full list of commands is not listed,
reader may find other source to have a full information.

It is possible to specify the version to use:
```bash
src-git telephony https://github.com/openwrt/telephony.git;for-15.05
```

This makes the possible to play with the feeds version in case necessory

```bash
$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
nothing to commit, working tree clean

$ pwd
/Volumes/workspace/openwrt/feeds/telephony
```
You may checkout specific version to play with or even fork one and fix some
issues, then change the feeds conf to fetch the package from the forked one.

```bash
src-git telephony https://github.com/<put-appropriate-name-here>/telephony.git
```


