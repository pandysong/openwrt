# Install QEMU on Linux

On Ubuntu, install using following command 

```bash
apt-get install qemu
```

# run on linux

create following bash script and save as `source/bin/targets/malta/le/run.sh`

```bash
#!/bin/sh
sudo qemu-system-mipsel -M malta -hda lede-malta-le-root.ext4 -kernel lede-malta-le-vmlinux.elf -nographic -append "root=/dev/sda console=ttyS0" 
```

```bash
cd source/bin/targets/malta/le/
./run.sh
```
