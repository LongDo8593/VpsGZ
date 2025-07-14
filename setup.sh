#!/bin/bash
sudo apt update && sudo apt install qemu-system -y
qemu-img create -f raw 2012r2.img 20G
wget -O- --no-check-certificate http://drive.muavps.net/windows/Windows2012r2.gz | gunzip | dd of=2012r2.img
qemu-img resize 2012r2.img 300G
qemu-system-x86_64 \
-net nic -net user,hostfwd=tcp::3389-:3389 \
-m 16G -smp cores=8 \
-cpu max \
-enable-kvm \
-boot order=d \
-drive file=2012r2.img,format=raw,if=virtio \
-device usb-ehci,id=usb,bus=pci.0,addr=0x4 \
-device usb-tablet \
-device virtio-gpu \
-vga virtio \
-display gtk
