#pulse-simple

## module

The local pulse-simple interface is talking to pulse daemon via following
modules. The module needs to be loaded by add following line in
`/etc/pulse/system.pa`

```bash
load-module module-native-protocol-unix
```
refer to [pulse-audio](pulse-auido.md) document on how to start pulse-audio
daemon in lede/openwrt project.


## check if native interface is ready

```bash
root@LEDE:/# ls -l /var/run/pulse/native
srwxrwxrwx    1 pulse    pulse            0 Sep 30 07:48 /var/run/pulse/native
```
## access denied

Following error may occurs when try to use baresip pulse module

```bash
/dial sip:user@10.0.2.2
call: connecting to 'sip:user@10.0.2.2'..
call: SIP Progress: 100 Trying (/)
audio: Set audio decoder: PCMU 8000Hz 1ch
pulse: could not connect to server (Access denied)
audio: start_player failed (pulse.system): No such device
audio: Set audio encoder: PCMU 8000Hz 1ch
pulse: could not connect to server (Access denied)
audio: start_player failed (pulse.system): No such device
pulse: could not connect to server (Access denied)
audio: start_source failed (pulse.system): No such device
sip:user@10.0.2.2: session closed: No such device
```

### solution

The first error message usually indicates the root cause:

```bash
pulse: could not connect to server (Access denied)
```

solution would be to add root into pulse group in /etc/group

```bash
pulse:x:51:pulse,root
```
and add the auth-group parameter for native module in system.pa

```bash
load-module module-native-protocol-unix auth-group=pulse
```

## no such entity

After above workaround applies, following error occurs.

```bash
dial sip:user@10.0.2.2
call: connecting to 'sip:user@10.0.2.2'..
call: SIP Progress: 100 Trying (/)
audio: Set audio decoder: PCMU 8000Hz 1ch
pulse: could not connect to server (No such entity)
audio: start_player failed (pulse.system): No such device
audio: Set audio encoder: PCMU 8000Hz 1ch
pulse: could not connect to server (No such entity)
audio: start_player failed (pulse.system): No such device
pulse: could not connect to server (No such entity)
audio: start_source failed (pulse.system): No such device
sip:user@10.0.2.2: session closed: No such device

```

It might be that the config in baresip is problematic. We may need to change the
setting of audio_player, for details, please refer to this [doc](run-baresip.md)

## log in pulseaudio daemon

Add following options in /etc/init.d/pulseaudio script

```bash
--log-level=4 --log-target=newfile:/tmp/pulseverbose.log
```

So the line looks like

```bash
procd_set_param command $PROG --log-level=4 --log-target=newfile:/tmp/pulseverbose.log --system --disallow-exit ......
```
## log in pulseaudio client

Refer to following document for log setting in client.

```bash
https://freedesktop.org/software/pulseaudio/doxygen/index.html#logging_sec
```

The log is enabled by setting the environment setting.
```bash
export PULSE_LOG=4
```

## if more debugging needed

Refer to following link for enabling gdb

https://wiki.openwrt.org/doc/devel/gdb
