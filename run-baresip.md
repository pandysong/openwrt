# baresip

## run

### run in console
```bash
baresip -f /etc/baresip
```

If it is first time to run, this will create config files in /etc/baresip


### run as daemon

```bash
/etc/init.d/baresip start
```

you may need to edit the script /etc/init.d/baresip to add following parameters
in to the start script

```bash
-f /etc/baresip
```

There might be some environment variable there to set the path. If someone knows
please drop me a message ( you may find it in the source code?).

### stop server

```bash
/etc/init.d/baresip stop
```

## register to server

issue command `/uanew` to register to to a server.

```bash
/uanew sip:user@10.0.2.2
Creating UA for sip:user@10.0.2.2 ...
> sip:user@10.0.2.2                          zzz

user@10.0.2.2: {0/UDP/v4} 200 OK (pjsua simple registrar) [1 binding]
All 1 useragent registered successfully! (354246 ms)
```

In my case I am running a pjsip on host, and lede is running in QEMU.

The host address is 10.0.2.2, while the pjsip has default sip sip:user@<the host
ip address>. 

In QEMU, the default host IP address is 10.0.2.2,

### logs on host

```
>>> 18:37:01.655           pjsua_core.c  .RX 437 bytes Request msg
>>> REGISTER/cseq=26838 (rdata0x7fe654801028) from UDP 127.0.0.1:51562:
REGISTER sip:10.0.2.2 SIP/2.0
Via: SIP/2.0/UDP 10.0.2.15:50375;branch=z9hG4bK321e1d3c4332d2e7;rport
Contact: <sip:user-0x831b88@10.0.2.15:50375>;expires=3700
Max-Forwards: 70
To: <sip:user@10.0.2.2>
From: <sip:user@10.0.2.2>;tag=e2e347abe1ac4b80
Call-ID: a10860f2c31af5ed
CSeq: 26838 REGISTER
User-Agent: baresip v0.5.5 (mips/linux)
Allow: INVITE,ACK,BYE,CANCEL,OPTIONS,REFER,NOTIFY,SUBSCRIBE,INFO,MESSAGE
Content-Length: 0


--end msg--
18:37:01.655           pjsua_core.c  .TX 375 bytes Response msg
200/REGISTER/cseq=26838 (tdta0x7fe6548090a8) to UDP 127.0.0.1:51562:
SIP/2.0 200 OK
Via: SIP/2.0/UDP
10.0.2.15:50375;rport=51562;received=127.0.0.1;branch=z9hG4bK321e1d3c4332d2e7
Call-ID: a10860f2c31af5ed
From: <sip:user@10.0.2.2>;tag=e2e347abe1ac4b80
To: <sip:user@10.0.2.2>;tag=z9hG4bK321e1d3c4332d2e7
CSeq: 26838 REGISTER
Contact: <sip:user-0x831b88@10.0.2.15:50375>;expires=3700
Server: pjsua simple registrar
Content-Length:  0

```


## make a call

/dial sip:user@10.0.2.2


## baresip config

Note that, in config, `audio_player` is used to set the driver and device name.

If there is no hardware device, then we should keep it empty.

```bash
root@LEDE:/# cat /etc/baresip/config  | grep pulse
audio_player            pulse
audio_source            pulse
module                  pulse.so
````
