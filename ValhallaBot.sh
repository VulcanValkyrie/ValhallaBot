#!/bin/bash


function send {
    echo "-> $1"
    echo "$1" >> .botfile
}

rm .botfile #if botfile exists delete it
mkfifo .botfile #now make new botfile 
#connect to irc (forever and everandeverandever...)
#tail -f .botfile | nc irc.cat.pdx.edu 6667 | while true; do
tail -f .botfile | openssl s_client -connect irc.cat.pdx.edu:6697 |while true; do
    #now we check on the status of the variable started
   if [[ -z $started ]] ; then
        send "NICK ValhallaBot"  #append nick to botfile
        send "USER ValhallaBot ValhallaBot ValhallaBot :Valkyrie" 
        send "JOIN #robots ,<insert chankey>"
        started="yes"
   fi 
   read irc 
   echo "<- $irc"
   if $(echo $irc | cut -d ' ' -f 1 | grep PING > /dev/null) ; then
       send "PONG"
   elif `echo $irc | grep PRIVMSG > /dev/null` ; then
       chan=$(echo $irc | cut -d ' ' -f 3)
       barf=$(echo $irc | cut -d ' ' -f 1-3)
       saying=$(echo ${irc##$barf :}|tr -d "\r\n") #takes line and tosses barf
       nick="${irc%%!*}"; nick= "${nick#:}"
       var=$(echo "$nick" "$chan" "$saying" | ./Valhalla_cmds.sh)
       if [[ ! -z $var ]]; then 
            send "$var"
       fi 
   fi
done 
        

