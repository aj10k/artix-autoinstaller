#color
#sudo dd if=artix-base-runit-###-x86_64.iso of=/dev/sd# status='progress'


	#login
#artix
#artix
#sudo su

ping -c 3 google.com


uefi=/sys/firmware/efi/efivars
if [ -f "$uefi" ]; then
    echo "uefi"
    legacy=$false
fi

if [ ! -f "$uefi" ]; then
    echo "legacy"
    legacy=$true
fi

pacman --noconfirm -Sy archlinux-keyring

lsblk
echo "Enter the drive (e.g. sda, nvme0n1): "
read drive
echo "uefi 1: boot [+2G], 2: root [+40G], 3: home [remaining]"
echo "legacy 1: boot [+2G], 2: root [+40G], 3: type:swap [+1G], 4: type:4(bios) [+32M] 5: home [remaining]"
fdisk /dev/$drive


echo "Enter boot drive (e.g. sda1, nvme0n1p1): "
read boot_drive

echo "Enter root drive (e.g. sda2, nvme0n1p1): "
read root_drive

echo "Enter home drive (e.g. sda5, nvme0n1p1): "
read home_drive


if [ $legacy ]; then
	mkfs.ext4 /dev/"$boot_drive"
fi

if [ ! $legacy ]; then
	mkfs.fat -F32 /dev/"$boot_drive"
fi

mkfs.ext4 /dev/"$root_drive"
mkfs.ext4 /dev/"$home_drive"


	#mount
mount /dev/"$root_drive" /mnt
mkdir /mnt/boot
mkdir /mnt/home
mount /dev/"$boot_drive" /mnt/boot
mount /dev/"$home_drive" /mnt/home


	#install OS
	#efibootmgr only needed for UEFI
if [ $legacy ]; then
	basestrap /mnt base base-devel runit elogind-runit linux linux-firmware vim grub os-prober
fi

if [ ! $legacy ]; then
	basestrap /mnt base base-devel runit elogind-runit linux linux-firmware vim grub os-prober efibootmgr
fi


	#proper remount on boot
fstabgen -U /mnt >> /mnt/etc/fstab


	#run the installed OS
artix-chroot /mnt
bash


#==================================
