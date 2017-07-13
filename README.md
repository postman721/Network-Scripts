# Network-Scripts
Network scripts for Lan and Wlan(Bash) 

To use wlanset you should have wpasupplicant and wireless-tools installed (sudo apt-get install wireless-tools wpasupplicant)

Run the programs as a sudo (use sudo su) or as a root user inside a terminal client.
Examples:

sudo su

sh wlanset.sh #For Wlan
sh netset.sh #For Lan

Note. If you get weird errors when using usb wlan sticks try another usb port. I had one usb port, which gave me plenty of errors and refused to start the interface scan of Wlansetup correctly – all other ports worked just fine.
 _____________________________________
Original post is at:
http://www.techtimejourney.net/wlan-setup-program-wpa2-wpa-psk-debian-family/
