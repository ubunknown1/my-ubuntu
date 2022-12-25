#!/bin/bash
 

 

packages=$"virt-what nautilus-admin plymouth-themes software-properties-common build-essential gnupg gnupg1 gnupg2 kgpg git gh ubuntu-restricted-extras openssh-client openssh-server ufw guake tor python3.10-full snap snapd timeshift gnome-tweaks gcc g++ openjdk-18-jre-headless gedit macchanger iw bleachbit python3.10-full"
update() {
	echo "System update"
	sudo apt update &> /dev/null
	echo "System upgrade"
	sudo apt -y upgrade &> /dev/null
	echo "System full-update"
	sudo apt -y full-upgrade &> /dev/null
	echo "autoremove"
	sudo apt -y autoremove &> /dev/null
	echo "clean"
	sudo apt -y clean &> /dev/null
	echo ""
	echo "$cy Systemet er Oppdatert $cf"
	
}

installer() {
	sudo apt install -y $packages
}


configure_system() {
	git config --global user.email ubunknown1@protonmail.com
	git config --global user.name ubunknown1
	
	# setup GPG
	dir=$(pwd)
	echo "$dir/ssh-"
	gpg --import $dir/public.gpg
	gpg --import $dir/private.gpg
	gpg --import-ownertrust $dir/trust.gpg
	gpg --list-secret-keys --keyid-format LONG
$ 	chmod 600 ~/.ssh/id_rsa
$	chmod 644 ~/.ssh/id_rsa.pub
	
	# setup SSH
	
	
	# enable ssh firewall
	sudo ufw allow ssh
	sudo systemctl restart ssh
	sudo systemctl enable ssh
}

update
installer
configure_system
