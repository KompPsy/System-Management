
###################################################################
#
# Date:
# April 21, 2023
#
# Description:
# This Script is intended for Managing Linux Host(s) and IDrac Actions
#
# Version:
# 1.0
#
# Author:
# Peter Aldrich
#
##################################################################

#!/bin/bash


function mainMenu(){

setHostUser setHostname setUsername

while true
do
echo -e " "
echo -e "Selected Host: ${setHostname}"
echo -e "Select Option for Host Management (0-5):"
echo -e "-----------------------------------------"
echo -e "        1.) Linux Host Managment"
echo -e "        2.) IDrac Management"
echo -e "        0.) Exit Host Management"

read optionsSet3
echo -e " "

case $optionsSet3 in
  1) echo -e " Linux Host Managment"
     hostManagement
  ;;

  2) echo -e " IDrac Management"
     iDracManagement
   ;;

  0)
  exit
  ;;

esac

done
}

function setHostUser(){

echo -e " What is the hostname/ IP"
read InputHostname
setHostname=${InputHostname}

echo -e " What is the username"
read InputUsername
setUsername=${InputUsername}
return
}


function hostManagement(){

sshAccount="ssh ${setUsername}@"
soption=" -S"
excute=" sudo"
reboot=" reboot now"
shutdown=" shutdown now"
checkSystem="ping -c 5 ${setHostname}"
launchBroswer="google-chrome"
webAddress=" https://${setHostname}:9090"

cockpitWebUI=${launchBroswer}${webAddress}
restart=${sshAccount}${setHostname}${excute}${soption}${reboot}
turnoff=${sshAccount}${setHostname}${excute}${soption}${shutdown}

while true
do

echo -e " "
echo -e "Selected Host: ${setHostname}"
echo -e "Select Option for Host Management (0-5):"
echo -e "-----------------------------------------"
echo -e "        1.) Ping"
echo -e "        2.) Power Down"
echo -e "        3.) Power-Cycling"
echo -e "        4.) Launch Host Web GUI"
echo -e "        0.) Exit Host Management"

read optionsSet1
echo -e " "

case $optionsSet1 in

  1) echo -e " Obtaining Power Status"
     $checkSystem
  ;;

  2) echo -e " Powering down"
     $turnoff
  ;;

  3) echo -e "Powering Cycle"
     $restart
  ;;

  4) echo -e " Launching IDrac web interface"
     $cockpitWebUI
     echo -e "If the the Webpage does not  open Click the Link:"
     echo -e "${webAddress}"
  ;;

  0)
  break
  ;;

esac

done

}


function iDracManagement(){
   
#Local Variables within iDracManagement
sshAccount="ssh ${setUsername}@"
serveraction=" racadm serveraction "
launchBroswer="google-chrome"
webAddress=" https://${setHostname}/login.html"

#Local Variables within iDracManagement for power arguements
up="powerup"
dp="powerdown"
sp="powerstatus"
pc="powercycle"

#Local Variables within iDracManagement for power functions
powerup=${sshAccount}${setHostname}${serveraction}${up}
powerdown=${sshAccount}${setHostname}${serveraction}${dp}
powerstatus=${sshAccount}${setHostname}${serveraction}${sp}
powercycle=${sshAccount}${setHostname}${serveraction}${pc}
idracWebUI=${launchBroswer}${webAddress}

#Repeats the options in the Switch Statment with the power functions until Pressing 0
while true
do

echo -e " "
echo -e "Selected Host: ${setHostname}"
echo -e "Select Option for IDrac Management (0-5):"
echo -e "-----------------------------------------"
echo -e "        1.) Obtain Power Status"
echo -e "        2.) Power Up"
echo -e "        3.) Power Down"
echo -e "        4.) Power Cycle"
echo -e "        5.) Launch IDrac Web GUI"
echo -e "        0.) Exit IDrac Management"

read optionsSet2
echo -e " "

case $optionsSet2 in

  1) echo -e " Obtaining Power Status"
     $powerstatus
  ;;

  2) echo -e " Powering up"
     $powerup
  ;;

  3) echo -e " Powering down"
     $powerdown
  ;;

  4) echo -e "Power Cycling"
     $powercycle
  ;;

  5) echo -e " Launching IDrac web interface"
     $idracWebUI
     echo -e "If the the Webpage does not  open Click the Link:"
     echo -e "${webAddress}"
  ;;

  0)
  break
  ;;

esac

done
}

#Excutes  mainMenu Function
mainMenu
