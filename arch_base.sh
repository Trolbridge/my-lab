##########################################################
### Arch Linux

#/run/archiso/bootmnt/EFI/BOOT

##########################################################
### Connect to internet:
ip addr show
ip link set wlan0 up
iwctl 
	device list
	station wlan0 scan
	station wlan0 get-networks
	station wlan0 connect DEM2
	station wlan0 show
	exit // or Ctrl-d
ip a
ping -c 3 google.com


##########################################################
### Format/Partition:

cgdisk
+300M
lsblk
8300 <Linux filesystem>
mkfs.vfat /dev/nvme0n1p5
mkfs.btrfs /dev/nvme0n1p6

##########################################################
#Mounting btrfs:
mount /dev/nvme0n1p6 /mnt
#BTRFS setup:
btrfs su cr /mnt/@
btrfs su cr /mnt/@home
btrfs su cr /mnt/@snapshots
btrfs su cr /mnt/@var_log
df (to check everything is mounted properly)
umount -l /mnt

mkdir -p /mnt/{boot,home,.snapshots,var}
mkdir -p /mnt/var/log
mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@ /dev/nvme0n1p6 /mnt
mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@home /dev/nvme0n1p6 /mnt/home
mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@snapshots /dev/nvme0n1p6 /mnt/.snapshots
mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@var_log /dev/nvme0n1p6 /mnt/var/log
mount /dev/nvme0n1p5 /mnt/boot
lsblk

##########################################################
### Install  

pacstrap -i /mnt base linux linux-headers linux-firmware 
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/America/Detroit /etc/localtime
hwclock --systohc
timedatectl
vim /etc/locale.gen
	en_US.UTF-8 UTF-8
locale.gen
locale-gen
vim /etc/locate.conf
echo "LANG=en_US.UTF-8" > /etc/locate.conf

vim /etc/hostname
echo "cpu" > /etc/hostname

vim /etc/hosts
echo "127.0.0.1	localhost" > /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1	cpu.localdomain	 cpu" >> /etc/hosts

passwd

pacman -S grub efibootmgr os-prober dosfstools mtools networkmanager network-manager-applet wpa_supplicant wireless_tools netctl dialog sudo git reflector snapper inetutils base-devel bluez bluez-utils cups bash-completion
#pacman -S linux-lts linux-lts-headers 
#pacman -S base-devel openssh
#systemctl enable sshd
#vim /etc/mkinitcpio.conf
#mkinitcpio -p linux
#mkinitcpio -p linux-lts
grub-install --target=x86_64-efi --efi-directory=/boot/ --bootloader-id=GRUB
mkdir /mnt2
lsblk
fdisk -l
mount /dev/nvme0n1p1 /mnt2
vim /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups

useradd -mG wheel cpu
passwd cpu
EDITOR=vim visudo
	%wheel ALL=(ALL) ALL
exit
umount -a
reboot
##########################################################
### Post Install
umount /.snapshots
rm -r /.snapshots
snapper -c root create-config /
btrfs subvolume delete /.snapshots
mkdir /.snapshots
mount -a
chmod 750 /.snapshots
vim /etc/snapper/configs/root
systemctl enable --now snapper-timeline.timer
systemctl enable --now snapper-cleanup.timer
git clone https://aur.archlinux.org/yay
su cpu
cd yay && makepkg -si PKGBUILD 

##########################################################
Ssnapfile
dd if=/dev/zero of=/swapfile bs=1M count=2048 status=progress
chmod 600 /swapfile
mkswap /swapfile
cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab
cat /etc/fstab
free -m
mount -a
swapon -a
