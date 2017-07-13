#!/bin/sh

echo " ------------------------------------------------------------------------"
echo "
    <Wlansetup>  Copyright (C) 2015>  <JJ Posti (techtimejourney.net)>
    This program comes with ABSOLUTELY NO WARRANTY; for details see: 
    http://www.gnu.org/copyleft/gpl.html
    This is free software, and you are welcome to redistribute it
    under GPL Version 3, 29 June 2007 license."

echo " -------------------------------------------------------------------------"
echo "Welcome to 'Wlansetup' program version 0.3.2-Audax."
echo "Original network file /etc/network/interfaces will be renamed 
as /etc/network/interfaces.old"
echo "Before running this program multiple times make sure you clear duplicate entries from /etc/network/interfaces"
echo ".........................................................................."


echo -n "Do you want to continue? (y or n): "
read CONFIRM
case $CONFIRM in
y|Y|YES|yes|Yes) break ;;
n|N|no|NO|No)
echo Aborting - you entered $CONFIRM
exit
;;
*) echo Please enter only y or n
esac
echo You entered $CONFIRM. Continuing ...

echo "Copying the original network file to /etc/network/interfaces.old"
FLAG="/var/log/wlancopy.log"
if [ ! -f $FLAG ]; then
cp /etc/network/interfaces /etc/network/interfaces.old

 #Not running on next start
   touch $FLAG
else
   echo "Network file already copied"
fi

#Purge and recreate the network file
rm -r /etc/network/interfaces
touch /etc/network/interfaces

sleep 2
ip a
iwconfig
echo "Where is your wlan device (for example:wlan0 or wlan1)?  \c"
read CARD

ip link set $CARD

#Finding out network cards
echo  "auto wlan" >> /etc/network/interfaces
echo "iface $CARD inet dhcp" >> /etc/network/interfaces
ifup $CARD
sleep 3
iwlist $CARD scan
echo "What is your network name? (ESSID)  \c"

read NET
echo "wpa-ssid $NET" >> /etc/network/interfaces
echo "What is your wlan password? \c"
read PASS
echo "wpa-psk $PASS" >> /etc/network/interfaces

echo "Adding wlan interface to /etc/rc.local to provide autostart and protecting /etc/network/interfaces from unauthorized users"
echo "
#Network autostart line
ifup $CARD" >> /etc/rc.local
chmod 0600 /etc/network/interfaces

echo "Enabling Wlan now"
sleep 3
ifdown $CARD && ifup $CARD

echo " Exiting in 5 seconds"
sleep 5
exit
