#!/bin/bash
#check if user is root
if [[ $EUID -ne 0 ]]; then
	echo "You must run this script as sudo" 1>&2
	exit 1
fi

#clear terminal
clear

#initiate files/folders/etc
touch tmp.log
echo -e "Log $var_unixtime Start" > tmp.log
#mkdir /home/$USER/Bin FIXME
#PATH=$PATH:/home/$USER/Bin FIXME
#export PATH FIXME

#set variables---------------------------
#-program info---------------------------
version="10.10a" #program version
ver_ubuntu="10.10 Maverick Meerkat" #Supported ubuntu version
#-non ppa deb sources--------------------
#chrome
source_chrome32stable="http://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb"
source_chrome32unstable="http://dl.google.com/linux/direct/google-chrome-unstable_current_i386.deb"
source_chrome64stable="http://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
source_chrome64unstable="http://dl.google.com/linux/direct/google-chrome-unstable_current_amd64.deb"
#virtualbox http://www.virtualbox.org/wiki/Linux_Downloads
source_virtualbox32="http://download.virtualbox.org/virtualbox/4.0.2/virtualbox-4.0_4.0.2-69518~Ubuntu~maverick_i386.deb"
source_virtualbox64="http://download.virtualbox.org/virtualbox/4.0.2/virtualbox-4.0_4.0.2-69518~Ubuntu~maverick_amd64.deb"
#skype
source_skype32="http://www.skype.com/go/getskype-linux-beta-ubuntu-32"
source_skype64="http://www.skype.com/go/getskype-linux-beta-ubuntu-64"
#ubuntu tweak http://ubuntu-tweak.com/
source_ubuntutweak="http://launchpad.net/ubuntu-tweak/0.5.x/0.5.10/+download/ubuntu-tweak_0.5.10-1_all.deb"
#ailurus http://code.google.com/p/ailurus/downloads/list
source_ailurus="http://ailurus.googlecode.com/files/ailurus_10.10.1-0maverick1_all.deb"
#cover gloobus https://launchpad.net/~gloobus-dev/+archive/covergloobus/+packages
source_covergloobus32="https://launchpad.net/~gloobus-dev/+archive/covergloobus/+files/covergloobus_1.7-6_i386.deb"
source_covergloobus64="https://launchpad.net/~gloobus-dev/+archive/covergloobus/+buildjob/2058179/+files/covergloobus_1.7-6_amd64.deb"
#-non ppa other sources------------------
#sublime text http://www.sublimetext.com/2
source_sublimetext32="http://www.sublimetext.com/Sublime%20Text%202%20Build%202023.tar.bz2"
source_sublimetext64="http://www.sublimetext.com/Sublime%20Text%202%20Build%202023%20x64.tar.bz2"
#deadbeef http://deadbeef.sourceforge.net/download.html
source_deadbeef="http://downloads.sourceforge.net/project/deadbeef/portable/0.4.4/deadbeef-0.4.4-portable-partial-r1.tar.bz2"
#pms-linux http://code.google.com/p/ps3mediaserver/downloads/list
source_pmslinux="http://ps3mediaserver.googlecode.com/files/pms-generic-linux-unix-1.20.412.tgz"
#airvideo server/bounjour http://www.inmethod.com/air-video/download.html
source_bonjour="http://support.apple.com/downloads/DL999/en_US/BonjourPSSetup.exe"
source_airvideo="https://s3.amazonaws.com/AirVideo/Setup243.exe"
#64bit flash http://labs.adobe.com/downloads/flashplayer10_square.html
source_flash64="http://download.macromedia.com/pub/labs/flashplayer10/flashplayer10_2_p3_64bit_linux_111710.tar.gz"
#-program versions-----------------------
pver_firefox="4.0" #bleeding edge firefox version
pver_playonlinux="maverick" #current version of playonlinux

#welcome message-------------------------
echo -e "		Welcome to Niko's Ubuntu first run installer\041\n"
echo -e "Version: $version"
echo -e "With support for Ubuntu $ver_ubuntu"
echo -e "\n"

#user options----------------------------
echo -e "------------------------"
echo -e "Are you installing this on a netbook? [y/\033[1mN\033[0m]"
while :
do
	read -p "" comp_type
	if [ "$comp_type" = "y" ] || [ "$comp_type" = "Y" ]; then
		break
	elif [ "$comp_type" = "n" ] || [ "$comp_type" = "N" ] || [ "$comp_type" = "" ]; then
		comp_type="n"
		break
	else
		echo -e "Please enter [y] for yes or [n] for no."
	fi
done
echo -e "Are you installing this on a production machine? [\033[1mY\033[0m/n]"
echo -e "Answering no will enable unstable builds of certain applications."
while :
do
	read -p "" comp_stable
	if [ "$comp_stable" = "y" ] || [ "$comp_stable" = "Y" ]; then
		break
	elif [ "$comp_stable" = "n" ] || [ "$comp_stable" = "N" ] || [ "$comp_stable" = "" ]; then
		comp_stable="n"
		break
	else
		echo -e "Please enter [y] for yes or [n] for no."
	fi
done
echo -e "Does your computer have a graphics card by ATI, nVidia, or other? [a,n,\033[1mO\033[0m]"
echo -e "If you are unsure, press enter to skip."
while :
do
	read -p "" comp_video
	if [ "$comp_video" = "a" ] || [ "$comp_video" = "A" ]; then
		comp_video="a"
		break
	elif [ "$comp_video" = "n" ] || [ "$comp_video" = "N" ]; then
		comp_video="n"
		break
	elif [ "$comp_video" = "o" ] || [ "$comp_video" = "O" ] || [ "$comp_video" = "" ]; then
		break
	else
		echo -e "Please enter [a] if you have an ATI graphics card,\n\
		[n] if you have an nVidia graphics card, or [o] for other."
	fi
done

#remove unwanted packages----------------
echo -e -n "Removing unwanted software..."
apt-get -y -q purge empathy empathy-common nautilus-sendto-empathy openoffice*.* &>> tmp.log
echo -e "Done\041"

#install new sources---------------------
echo -e "Installing new sources..."
echo -e -n "Faenza icons..."
add-apt-repository ppa:tiheum/equinox &>> tmp.log #faenza icons
echo -e "Ok\nNautilus Elementary..."
add-apt-repository ppa:am-monkeyd/nautilus-elementary-ppa &>> tmp.log #nautilus elementary
echo -e "Ok\nSynapse..."
add-apt-repository ppa:synapse-core/ppa &>> tmp.log #synapse
echo -e "Ok\nShutter..."
add-apt-repository ppa:shutter/ppa &>> tmp.log #shutter
echo -e "Ok\nIndicator Weather..."
add-apt-repository ppa:weather-indicator-team/ppa &>> tmp.log #indicator-weather
echo -e "Ok\nMinitube..."
add-apt-repository ppa:nilarimogard/webupd8 &>> tmp.log #minitube
echo -e "Ok\nLibreOffice..."
add-apt-repository ppa:libreoffice/ppa &>> tmp.log #libreoffice
echo -e "Ok"
#-special sources------------------------
#--unstable/stable-----------------------
if [ "$comp_stable" = "n" ]; then
	echo -e -n "Docky Unstable..."
	add-apt-repository ppa:docky-core/ppa &>> tmp.log #docky unstable
	echo -e "Ok\nChromium Unstable..."
	add-apt-repository ppa:chromium-daily/ppa &>> tmp.log #chromium unstable
	echo -e "Ok\nFirefox Unstable..."
	add-apt-repository ppa:ubuntu-mozilla-daily/ppa &>> tmp.log #firefox
	echo -e "Ok\nLocking Firefox 3.6..."
	#set firefox ppa repo to lower priority than ubuntu
	#this prevents the current stable firefox from updating and changing names
	touch /etc/apt/preferences.d/ubuntu-mozilla-daily-pin-400
	echo -e "Package: *" > /etc/apt/preferences.d/ubuntu-mozilla-daily-pin-400
	echo -e "Pin: release o=LP-PPA-ubuntu-mozilla-daily" >> /etc/apt/preferences.d/ubuntu-mozilla-daily-pin-400
	echo -e "Pin-Priority: 400" >> /etc/apt/preferences.d/ubuntu-mozilla-daily-pin-400
	echo -e "Ok"
else
	echo -e -n "Docky Stable..."
	add-apt-repository ppa:docky-core/stable &>> tmp.log #docky stable
	echo -e "Ok\nChromium Stable..."
	add-apt-repository ppa:chromium-daily/stable &>> tmp.log #chromium stable
	echo -e "Ok"
fi
#--desktop/netbook-----------------------
if [ "$comp_type" = "n" ]; then
	echo -e -n "Handbrake..."
	add-apt-repository ppa:stebbins/handbrake-releases &>> tmp.log #handbrake
	echo -e "Ok\nCover Thumbnailer..."
	add-apt-repository ppa:flozz/flozz &>> tmp.log #cover thumbnailer
	echo -e "Ok\nStellarium..."
	add-apt-repository ppa:stellarium/stellarium-releases &>> tmp.log #stellarium
	echo -e "Ok\nXBMC..."
	add-apt-repository ppa:team-xbmc/ppa &>> tmp.log #xbmc
	echo -e "Ok\njDownloader..."
	add-apt-repository ppa:jd-team/jdownloader &>> tmp.log #jdownloader
	echo -e "Ok\nMedibuntu..."
	wget -q http://www.medibuntu.org/sources.list.d/$(lsb_release -cs).list -O /etc/apt/sources.list.d/medibuntu.list #medibuntu source
	echo -e "Ok\nPlayOnLinux..."
	wget -q "http://deb.playonlinux.com/public.gpg" -O - | sudo apt-key add - &>> tmp.log
	wget -q http://deb.playonlinux.com/playonlinux_$pver_playonlinux.list -O /etc/apt/sources.list.d/playonlinux.list #playonlinux sources
	echo -e "Ok"
fi
echo -e "Done Installing New Sources\041"

#update package lists--------------------
echo -e -n "Updating package lists..."
apt-get -q update &>> tmp.log
echo -e "Done\041"

#install updates-------------------------
echo -e -n "Installing updates..."
apt-get -q -y --allow-unauthenticated dist-upgrade &>> tmp.log
echo -e "Done\041"

#install applications for all from sources
echo -e "Installing software..."
apt-get -q -y --allow-unauthenticated install ubuntu-restricted-addons gstreamer0.10-plugins-ugly-multiverse unrar gstreamer0.10-plugins-bad-multiverse libavcodec-extra-52 libmp4v2-0 faenza-icon-theme gdebi filezilla vlc smplayer htop pidgin synapse shutter indicator-weather chromium docky minitube libqt4-dbus libqt4-network libqtcore4 libqtgui4 libreoffice libreoffice-gnome &>> tmp.log
#-download and install ubuntu tweak and remove file
echo -e -n "Downloading Ubuntu Tweak..."
wget $source_ubuntutweak -O /tmp/NIKOubuntutweak.deb &>> tmp.log
echo -e "Ok\nInstalling Ubuntu Tweak..."
dpkg -i /tmp/NIKOubuntutweak.deb &>> tmp.log
rm /tmp/NIKOubuntutweak.deb
echo -e "Ok"
#-download and install ailurus and remove file
echo -e -n "Downloading Ailurus..."
wget -q $source_ailurus -O /tmp/NIKOailurus.deb
echo -e "Ok\nInstalling Ailurus..."
dpkg -i /tmp/NIKOailurus.deb &>> tmp.log
rm /tmp/NIKOailurus.deb
echo -e "Ok"
echo -e "Done Installing Common Software\041"

#install special stable/unstable all-----------------
if [ "$comp_stable" = "n" ]; then
	echo -e -n "Installing unstable software..."
	apt-get -q -y --allow-unauthenticated install firefox-$pver_firefox firefox-$pver_firefox-gnome-support &>> tmp.log
	echo -e "Done Installing Unstable Software\041"
fi

#install 32bit/64bit---------------------
comp_arch=`uname -m`
if [ "$comp_arch" = "x86_64" ]; then
	echo -e "Installing 64bit specific software..."
	apt-get -q -y --allow-unauthenticated install w64codecs &>> tmp.log #windows codecs 64bit
	#install 64bit flash FIXME
	#install sublime text FIXME
	#get chrome stable or unstable
	if [ "$comp_stable" = "n" ]; then
		echo -e -n "Downloading Chrome 64bit Unstable..."
		wget -q $source_chrome64unstable -O /tmp/NIKOchrome.deb
	else
		echo -e -n "Downloading Chrome 64bit Stable..."
		wget -q $source_chrome64stable -O /tmp/NIKOchrome
	fi
	echo -e "Ok"
	#get skype
	echo -e -n "Downloading Skype 64bit..."
	wget -q $source_skype64 -O /tmp/NIKOskype.deb
	echo -e "Ok"
else
	echo -e "Installing 32bit specific software..."
	apt-get -q -y --allow-unauthenticated install w32codecs &>> tmp.log #windows codecs 32bit
	#install sublime text FIXME
	#get chrome stable or unstable
	if [ "$comp_stable" = "n" ]; then
		echo -e -n "Downloading Chrome 32bit Unstable..."
		wget -q $source_chrome32unstable -O /tmp/NIKOchrome.deb
	else
		echo -e -n "Downloading Chrome 32bit Stable..."
		wget -q $source_chrome32stable -O /tmp/NIKOchrome
	fi
	echo -e "Ok"
	#get skype
	echo -e -n "Downloading Skype 32bit..."
	wget -q $source_skype32 -O /tmp/NIKOskype.deb
	echo -e "Ok"
fi
#install chrome and remove file
echo -e -n "Installing Chrome..."
dpkg -i /tmp/NIKOchrome.deb &>> tmp.log
rm /tmp/NIKOchrome.deb
echo -e "Ok"
#install skype and remove file
echo -e -n "Installing Skype..."
dpkg -i /tmp/NIKOskype.deb &>> tmp.log
rm /tmp/NIKOskype.deb
echo -e "Ok"
echo -e "Done Installing 32/64bit Specific Software (Non-PPA)\041"

#install desktop only--------------------
if [ "$comp_type" = "n" ]; then
	echo -e -n "Installing desktop specific software..."
	apt-get -q -y --allow-unauthenticated install jdownloader libdvdcss2 handbrake-gtk cover-thumbnailer rawtherapee stellarium xbmc gimp gimp-ufraw gnome-raw-thumbnailer miro playonlinux python-xlib &>> tmp.log
	if [ "$comp_arch" = "x86_64" ]; then
		echo -e -n "Downloading VirtualBox 64bit..."
		wget -q $source_virtualbox64 -O /tmp/NIKOvirtualbox.deb
		echo -e "Ok\nDownloading CoverGloobus 64bit..."
		wget -q $source_covergloobus64 -O /tmp/NIKOcovergloobus.deb
		echo -e "Ok"
	else
		echo -e -n "Downloading VirtualBox 32bit..."
		wget -q $source_virtualbox32 -O /tmp/NIKOvirtualbox.deb
		echo -e "Ok\nDownloading CoverGloobus 32bit..."
		wget -q $source_covergloobus32 -O /tmp/NIKOcovergloobus.deb
		echo -e "Ok"
	fi
	echo -e -n "Installing Virtualbox..."
	dpkg -i /tmp/NIKOvirtualbox.deb &>> tmp.log
	rm /tmp/NIKOvirtualbox.deb
	echo -e "Ok\nInstalling CoverGloobus..."
	dpkg -i /tmp/NIKOcovergloobus.deb &>> tmp.log
	rm /tmp/NIKOcovergloobus.deb
	echo -e "Ok"
	#install pmslinux FIXME
	#install bonjour FIXME
	#install airvideo FIXME
	#install video card drivers
	if [ "$comp_video" = "a" ]; then
		echo -e -n "Installing ATI video card drivers..."
		apt-get -y -q install fglrx &>> tmp.log #ati drivers
		echo -e "Ok"
	elif [ "$comp_video" = "n" ]; then
		echo -e -n "Installing nVidia video card drivers..."
		apt-get -y -q install nvidia-current &>> tmp.log #nvidia drivers
		echo -e "Ok"
	fi
	echo -e "Done Installing Desktop Specific Software\041"
fi

#install netbook only--------------------
if [ "$comp_type" = "y" ]; then
	echo -e -n "Installing netbook specific software..."
	#install deadbeef #FIXME
	echo -e "Done Installing Netbook Specific Software\041"
fi

#delete downloaded files
echo -e "Cleaning Apt Cache..."
apt-get clean &>> tmp.log
echo -e "Done Cleaning Apt Cache\041"

#run apt autoremove
echo -e "Autoremoving Unneeded Packages..."
apt-get -y autoremove &>> tmp.log
echo -e "Done Autoremoving Unneeded Packages\041"

echo -e "\nAll done, let's hope it worked\041"
