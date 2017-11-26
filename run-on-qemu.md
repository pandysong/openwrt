# run qemu

## create a separate qemu running dir

Copy the .ext4 and \*vmlinux.elf file to a directory, say "qemu"

## run qemu

```bash
#!/bin/sh
sudo qemu-system-mipsel -M malta -hda openwrt-malta-le-root.ext4 -kernel openwrt-malta-le-vmlinux.elf -nographic -append "root=/dev/sda console=ttyS0"
```
