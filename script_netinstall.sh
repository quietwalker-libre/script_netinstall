#!/bin/bash

if [ $UID -ne '0' ]; 
	then echo "Vedo che fumi roba buona! Metti un bel sudo davanti al comando!!!"
else 

	#inserimento dell'utente nel file sudoers
	echo "Inserisci il nome utente da aggiungere al file sudoers: "
	read NOMEUTENTE
	echo "Inserisco" $NOMEUTENTE "nel file sudoers"
	echo $NOMEUTENTE 'ALL=(ALL) ALL' >> /etc/sudoers
	
	#aggiornamento di sistema
	echo "[*]Aggiornamento repository in corso..."
	apt-get update -y >> /dev/null
	echo "Aggiornamento completato"
	
	echo "[*]Aggiornamento del sistema in corso..."
	apt-get upgrade -y
	echo "Aggiornamento completato!"

	#Installazione di preload (carica in memoria i programmi piu usati dall'utente)
	echo "[*]Installazione Preload, il demone che carica in memoria i programmi piu usati dall'utente"
	echo "Il demone si avvierà automaticamente dopo l'installazione"
	apt-get install preload -y >> /dev/null
	
	# l’accesso alla swap inizierà solo con un carico della RAM superiore al 90%
	echo "[*]Modifico il file /etc/sysctl.conf..."
	echo vm.swappiness=10 >> /etc/sysctl.conf
	echo net.ipv4.tcp_rmem = 4096 10000000 16777216 >> /etc/sysctl.conf
	echo net.ipv4.tcp_wmem = 4096 65536 16777216 >> /etc/sysctl.conf
	sysctl -p
	echo "Da adesso l’accesso alla swap inizierà solo quando il carico della RAM supererà il 90% e "
	echo "lo streaming dovrebbe risultare più veloce e occupare meno risorse"
	
	#installazione antivirus e anti rootkit
	echo "[*]Installazione antivirus e anti rootkit in corso..."
	apt-get install clamav chkrootkit -y >> /dev/null
	echo "Installazione completata"
	
	#installa i pacchetti utili per ricompilare un kernel
	echo "[*]Installazione utility per ricompilazione kernel..."
	apt-get install build-essential bzip2 libncurses5-dev fakeroot git initramfs-tools dkms devscripts -y >> /dev/null
	echo "Fatto!"
	
	#Installazione Bleachbit 
	echo "[*]Installazione di Bleachbit in corso..."
	apt-get install bleachbit -y >> /dev/null
	echo "Installazione completata!"
	
	#installazione gnome versione base
	echo "[*]Installazione Gnome3 versione base in corso..."
	apt-get install gnome-core gdm3 -y >> /dev/null
	echo "Installazione completata!"
	
	#installazione libreoffice
	echo "[*]Installazione libreoffice in corso:"
	echo "[*]Aggiunta dei repo backport"
	echo deb http://ftp.debian.org/debian wheezy-backports main >> /etc/apt/source.list	
	echo "[*]Aggiornamento repository"
	apt-get update -y
	echo "[*]Installazione pacchetti libreoffice..."
	apt-get install openjdk-8-jre  icedtea-8-plugin -y
	apt-get -t jessie-backports install libreoffice  libreoffice-style-sifr libreoffice-gnome libreoffice-l10n-it myspell-it -y >> /dev/null
	echo "Installazione terminata"
	
	#installazione gimp, vlc, geany
	echo "[*]Installazione programmi utili: VLC, Gimp, Telegram etc..."
	apt-get install vlc gimp  gimp-plugin-registry gparted transmission audacity openshot evince -y >> /dev/null
	apt-get install simplescan photorec icedove icedove-l10n-it transmageddon brasero cheese -y >> /dev/null
	apt-get install evince gdebi wireshark nmap netdiscover -y >> /dev/null
	wget https://telegram.org/dl/desktop/linux >> /dev/null
	
	#installazione lingua italiana
	echo "[*]Installazione la lingua italiana nel sistema..."
	apt-get install language-pack-it language-pack-gnome-it aspell-it myspell-it witalian -y >> /dev/null
	
	#pulizia della cache
	echo "[*] Pulizia della cache..."
	apt-cache clean && apt-get autoclean && apt-get autoremove

	#riavvio del sistema
	echo "[*] Riavvio del sistema in corso..."
	reboot

	

fi

