# add a new package

There are a lot of tutorial on internet on how to add new package.
which will not be repeated.

# problem
I encounter the problem showing that:

"Package abcdefgh is missing dependencies for libraries - OpenWRT"


# solution

There are a lot of general solutions for above issues, but the one really help
me out is in this link

https://stackoverflow.com/a/30119735


# short summary

```bash
cd staging_dir/target-mipsel_24kc_musl/pkginfo
grep -lr "abcdefgh" --include="*.provides" ./
```
replace the "abcdefgh" with your missing dependency.
you may find a list of xxx.provides files use one of them in your package
Makefile

```bash
$ grep -lr libalsa --include="*.provides" .
./baresip-mod-g711.provides
./baresip-mod-g722.provides
./baresip-mod-g726.provides
./baresip-mod-httpd.provides
./baresip-mod-oss.provides
./baresip-mod-pulse.provides
./baresip-mod-stdio.provides
./baresip.provides
./pulseaudio-daemon.provides
./pulseaudio-profiles.provides
./pulseaudio-tools.provides
./pulseaudio.provides
```

use pulseaduio as the name for dependency declaration.


# end

Overall OpenWRT/Lede project's package Makefile uses the concept of "package" to
manage the dependency but not the single library, knowing this will make it
easier to understand.
