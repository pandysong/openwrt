# monitor a stream

## get the sink or source id

```bash
pacmd --list-sink-inputs
```

the output may look like blow, where we get "index: 1", there '1' will be used later 
```bash
root@LEDE:/tmp# pacmd list-sink-inputs
1 sink input(s) available.
    index: 1
        driver: <protocol-native.c>
        flags:
        state: DRAINED
        sink: 0 <auto_null>
        volume: mono: 65536 / 100% / 0.00 dB
                balance 0.00
        muted: no
        current latency: 0.00 ms
        requested latency: 5.00 ms
        sample spec: s16le 1ch 8000Hz
        channel map: mono
                     Mono
        resample method: ffmpeg
        module: 0
        client: 16 <Baresip>
        properties:
                media.name = "VoIP Playback"
                application.name = "Baresip"
                native-protocol.peer = "UNIX socket client"
                native-protocol.version = "32"
                application.process.id = "2783"
                application.process.user = "root"
                application.process.host = "LEDE"
                application.process.binary = "baresip"
                application.language = "C"
                application.process.machine_id = "LEDE"
```

## parec

```bash
parec -v --monitor-stream=1
```
Above command will only print meta information. For a real recording:

```bash
parec --monitor-stream=1 > rec.bin
```

## How to playback rec.bin?

Not yet tried. But it is believed that there are available tools :-), worth a
searching on internet.

# More complex scenario

If complexe scenarios are needed, some concepts are important.

## pulse audio source

A pulse audio source is the source of ouside/client of pulse audio.

so the media is flowing from pulse audio source -> client.

## pulse audio sink

A pulse audio sink is the sink for ouside/client of pulse auido

so the media is flowing to pulse audio sink <- client.

## null sink

Null sink is indeed a virtual sink (other than a real hardware).

null sink is need to accept audio from external file via `pacmd` command.

## loop back module

loop back module is used to connect a sink to a source. The media flow is as follows:

player(paplay) ->  sink -> loopback module -> source 


## other direction

recorder(parec) <-  sink <- loopback module <- source 

# how to

## create null sink

## loopback

## play to null sink

