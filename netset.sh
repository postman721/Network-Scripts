#!/bin/sh

echo " ------------------------------------------------------------------------"
echo "
    <Netset>  Copyright (C) 2015>  <JJ Posti (techtimejourney.net)>
    This program comes with ABSOLUTELY NO WARRANTY; for details see: 
    http://www.gnu.org/copyleft/gpl.html
    This is free software, and you are welcome to redistribute it
    under GPL Version 3, 29 June 2007 license."
    echo "\n"
sleep 2
echo " -------------------------------------------------------------------------"
echo "Welcome to 'Netset' program version 0.2-Audax."
echo ".........................................................................."

echo "\n"
echo "If available, the original network file /etc/network/interfaces will be renamed 
as /etc/network/interfaces.old"
sleep 3
echo "\n"
sleep 3
echo "Before running this program multiple times make sure you clear duplicate entries 
from /etc/network/interfaces"
echo "\n"
sleep 3
echo "Remove /etc/network/interfaces  by typing sudo rm -r /etc/network/interfaces under terminal client"
sleep 3
echo "\n"

echo "If anything goes wrong navigate to /home/your_username/examples folder to locate an example network file"
echo "\n"
sleep 3
echo "\n"
echo "If you retry network configuration you can also optionally delete extra ifup lines from /etc/rc.local ( sudo geany /etc/rc.local )"
sleep 2
echo "\n"

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
sudo cp /etc/network/interfaces /etc/network/interfaces.old

 #Not running on next start
   touch $FLAG
else
   echo "Network file already copied"
fi

#Purge and recreate the network file
sudo rm -r /etc/network/interfaces
sudo touch /etc/network/interfaces


echo  "Now setting up the wired Internet access"
sleep 3
echo "\n"

sudo iwconfig
echo "What is your wired network device? (for example,eth0, eth1)  \c"
echo "\n"
read DEV
sleep 3

echo "
auto $DEV
allow-hotplug $DEV
iface $DEV inet dhcp" >> /etc/network/interfaces
sleep 3

echo " Protecting /etc/network/interfaces from unauthorized users"
sudo chmod 0600 /etc/network/interfaces
sleep 3

echo "ifup $DEV" >> /etc/rc.local

sudo /etc/init.d/networking restart
sleep 4
echo "\n"
echo "Network should now be enabled. Goodbye."
sleep 5
exit




