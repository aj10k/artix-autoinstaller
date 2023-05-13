#

ln -sf /usr/share/zoneinfo/Canada/Eastern /etc/localtime
hwclock --systohc

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

pacman -S networkmanager networkmanager-runit
ln -s /etc/runit/sv/NetworkManager/ /etc/runit/runsvdir/current

echo "Hostname: "
read hostname
echo $hostname > /etc/hostname
echo "127.0.0.1       localhost" >> /etc/hosts
echo "::1             localhost" >> /etc/hosts
echo "127.0.1.1       $hostname.localdomain $hostname" >> /etc/hosts


#==================================



#setup
if [ $legacy ]; then
	grub-install --target=i386-pc /dev/sd#
fi

if [ ! $legacy ]; then
	grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
fi


grub-mkconfig -o /boot/grub/grub.cfg

echo "password time"
passwd

echo "Pre-Installation Finish"
echo "Reboot then login; root, password just set"
echo "git clone https://github.com/aj10k/LARBS.git"
echo "sudo sh larbs.sh"
