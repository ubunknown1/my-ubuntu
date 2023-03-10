#!/bin/bash
 

 

packages=$"virt-what libglvnd-dev pkg-config nautilus-admin plymouth-themes software-properties-common build-essential gnupg gnupg1 gnupg2 kgpg git gh ubuntu-restricted-extras openssh-client openssh-server ufw guake tor python3.10-full snap snapd timeshift gnome-tweaks gcc g++ openjdk-18-jre-headless gedit macchanger iw bleachbit python3.10-full"
update() {
	echo "System update"
	sudo apt update &> /dev/null
	echo "System upgrade"
	sudo apt -y upgrade &> /dev/null
	echo "System full-update"
	sudo apt -y full-upgrade &> /dev/null
	echo "autoremove"
	sudo apt -y autoremove &> /dev/null
	echo "update initramfs"
	sudo update-initramfs -u &> /dev/null
	echo "clean"
	sudo apt -y clean &> /dev/null
	echo ""
	echo "$cy Systemet er Oppdatert $cf"
	
}

installer() {
	sudo apt install -y $packages
}


configure_system() {
	sudo dpkg --configure -a
	sudo apt install unattended-upgrades
	sudo dpkg-reconfigure --priority=low unattended-upgrades
	dir=$(pwd)
	git config --global user.email ubunknown1@protonmail.com
	git config --global user.name ubunknown1
	
	# BOOT
	#sudo rm /usr/share/plymouth/themes/bgrt/bgrt.plymouth
	#sudo cp $dir/bootup/bgrt.plymouth /usr/share/plymouth/themes/bgrt/bgrt.plymouth
	#sudo cp $dir/bootup/linux.png /usr/share/plymouth/themes/spinner/watermark.png
	#sudo rm /usr/share/plymouth/themes/default.plymouth 
	#sudo cp $dir/bootup/default.plymouth /usr/share/plymouth/themes/default.plymouth 

	
	# home files
	rm ~/.aliases
	rm ~/.bashrc
	cp $dir/home-files/.aliases ~/
	cp $dir/home-files/.bashrc ~/
	# setup GPG
	gpg --import /media/ko/private/private-files/ubuntu-secrets/gpg-key/public.gpg
	gpg --import /media/ko/private/private-files/ubuntu-secrets/gpg-key/private.gpg
	gpg --import-ownertrust /media/ko/private/private-files/ubuntu-secrets/gpg-key/trust.gpg
	gpg --list-secret-keys --keyid-format LONG
	
	# setup SSH
	cp -r /media/ko/private/private-files/ubuntu-secrets/.ssh $HOME
	ssh-add
        chmod 600 ~/.ssh/id_rsa
        chmod 644 ~/.ssh/id_rsa.pub

	# enable ssh firewall
	sudo ufw allow ssh
	sudo systemctl restart ssh
	sudo systemctl enable ssh

}

bootup() {
	dir=$(pwd)
	sudo apt install plymouth*
	echo "velg nr 5, mobian"
	sudo update-alternatives --config default.plymouth
	sudo rm /usr/share/plymouth/themes/mobian/logo.png
	sudo cp $dir/pictures/AGRpOz.png /usr/share/plymouth/themes/mobian/logo.png
	
	sudo rm /usr/share/plymouth/themes/bgrt/bgrt.plymouth
	sudo cp $dir/bootup/bgrt.plymouth /usr/share/plymouth/themes/bgrt/bgrt.plymouth

	
}

update
installer
configure_system

