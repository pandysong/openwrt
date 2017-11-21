# pulseaudio

pulseaudio is very popular in desktop Linux. It is a bit tricky to run correctly
in lede/openwrt

## start up server

```bash
/etc/init.d/pulseaudio start
```
### possible error

There might be some errors happening when starting the server, you could check
if the server is up by using `ps` command

```bash
4108 pulse     8124 S<   /usr/bin/pulseaudio -vvvvv --log-target=stderr --sys
```

### log setting

Add log setting in the line begening with "procd_set_param".
```bash
procd_set_param command $PROG --log-level=4 --log-meta=1 --log-target=newfile:/tmp/pulse-log-daemon.log
```

#### disable some module

In my case I need to disable some modules in order to start it up (may need to
bring them back when necessary later).

```bash
#load-module module-detect
```

## stop server

```bash
/etc/init.d/pulseaudio stop
```

## pacmd

In order to run pacmd, following environment setting should be done

### env setting

```bash
export PULSE_RUNTIME_PATH=/var/run/pulse
```

Otherwise you may have following error:

```bash
root@LEDE:/# pacmd
No PulseAudio daemon running, or not running as session daemon.
```

###  load module needed by pacmd

By adding following lines in /etc/pulse/system.pa

```bash
# load module that pacmd uses
load-module module-cli-protocol-unix
```

Remember to restart the server after changing the setting.

# Reference

This document honors the following link:

http://pulseaudio-bugs.freedesktop.narkive.com/RyQTiLPL/222-pacmd-doesn-t-work-with-pulseaudio-running-as-a-system-wide-daemon

Where there is following description

```
You cannot use the $ in your command above murz... When you set the
variable, the $ prefix must be omitted.

As for why it's not working, this is more or less expected. The CLI
interface (which pacmd uses) is a big security issue and thus is not
enabled by default. As described above pacmd tries to tell the daemon to
load the module-cli-protocol-unix module. This module creates a socket
that allows direct communication with PA that bypasses the protocol and
thus allows for extra information and details to be exchanged without
having to squeeze it into the protocol (which is quite awkward).

So once it's loaded this module pacmd connects directly to the "cli"
socket in the runtime path. So check your /var/run/pulse/ folder for a
"cli" socket. If it doesn't exist, pacmd isn't going to work.

Normally the automatic module loading bit will fail with system PAs
because module loading is not allowed and thus the module-cli-protocol-
unix cannot be loaded. So you can try loading it manually in system.pa and
then connect.

Either way, this is by design and I'm not sure it's something we should
change, especially as system mode is not really recommended or really
heavily tested upstream.
```

