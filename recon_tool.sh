#!/bin/bash
echo -e "\e[1;31m                                   /\             /\								\e[0m"
echo -e "\e[1;32m                                  |  \_,--===--,_// |							\e[0m"
echo -e "\e[1;33m                                     " ' '   ' '  "							\e[0m"
echo -e "\e[1;34m                                   |  _ :  '  : _  |							    \e[0m"
echo -e "\e[1;35m                                   |>/O\   _   /O\<|								\e[0m"
echo -e "\e[1;36m                                   | \- ~  _  ~ -/ |								\e[0m"
echo -e "\e[1;37m                                  >| ===. \_/ .=== |<							\e[0m"
echo -e "\e[1;38m                           .-'-.    \==='  |  '===/   .-'-.						\e[0m"
echo -n "  ";echo -e "\e[1;39m .----------------------{'. ' }--- \,  .-'-.  ,/---{.'. '}--------------------. \e[0m"
echo -n "   ";echo -e "\e[1;40m)                                    ~-===-~                                  (\e[0m"
echo -n "  ";echo -e "\e[1;41m(           ____  _____ ____ ___  _   _     _____ ___   ___  _                  )\e[0m"
echo -n "   ";echo -e "\e[1;42m)         |  _ \| ____/ ___/ _ \| \ | |   |_   _/ _ \ / _ \| |                (\e[0m"
echo -n "  ";echo -e "\e[1;43m(          | |_) |  _|| |  | | | |  \| |_____| || | | | | | | |                 )\e[0m"
echo -n "   ";echo -e "\e[1;44m)         |  _ <| |__| |__| |_| | |\  |_____| || |_| | |_| | |___             (\e[0m"
echo -n "  ";echo -e "\e[1;45m(          |_| \_\_____\____\___/|_| \_|     |_| \___/ \___/|_____|             )\e[0m"
echo -n "   ";echo -e "\e[1;46m)                                                                             (\e[0m" 
echo -n "   ";echo -e "\e[1;47m-------------------------------------------------------------------------------\e[0m"
                                                                                                                                                         

echo -e "\n\n#######################   BY 6HOUL6URU AND THE_C4R3T4K3R	############################\n"
#echo "				Syntax: script [ip]"

echo -en "\e[1;32mEnter your IP: \e[0m"
read IP
mkdir $IP 2> /dev/null

echo Basic Scan Started
touch $IP/basic
done="$(grep -o "Nmap done" $IP/basic)"
if [[ -z $done ]]
then
n_basic="sudo nmap -T4 $IP -Pn -oN $IP/basic"
$n_basic >/dev/null &
until grep -q "Nmap done" $IP/basic;
        do echo  -e "\e[1;36m             Scanning \e[1;36m"
        sleep 5
done
fi
echo  -e "\e[1;36m             Done \e[0m"

echo Aggressive Scan Started
touch $IP/agg
done="$(grep -o "Nmap done" $IP/agg)"
if [[ -z $done ]]
then
n_agg="sudo nmap -T4 $IP -Pn -A -oN $IP/agg"
$n_agg >/dev/null &
until grep -q "Nmap done" $IP/agg;
        do echo  -e "\e[1;36m             Scanning \e[0m"
        sleep 15
done
fi
echo  -e "\e[1;36m             Done \e[0m"

echo Service Scan Started
touch $IP/service
done="$(grep -o "Nmap done" $IP/service)"
if [[ -z $done ]]
then
n_service="sudo nmap -T4 $IP -Pn -sV -oN $IP/service"
$n_service >/dev/null &
until grep -q "Nmap done" $IP/service;
        do echo  -e "\e[1;36m             Scanning \e[0m"
        sleep 15
done
fi
echo  -e "\e[1;36m             Done \e[0m"

echo Script Scan Started
touch $IP/script
done="$(grep -o "Nmap done" $IP/script)"
if [[ -z $done ]]
then
n_script="sudo nmap -T4 $IP -Pn -sV -sC -oN $IP/script"
$n_script >/dev/null &
until grep -q "Nmap done" $IP/script;
        do echo  -e "\e[1;36m             Scanning \e[0m"
        sleep 15
done
fi
echo  -e "\e[1;36m             Done \e[0m"

echo All Port Scan Started
touch $IP/allports
done="$(grep -o "Nmap done" $IP/allports)"
if [[ -z $done ]]
then
n_allport="sudo nmap -T4 -p- -Pn $IP -oN $IP/allports"
$n_allport> /dev/null &
until grep -q "Nmap done" $IP/allports;
        do echo  -e "\e[1;36m             Scanning \e[0m"
        sleep 30
done
fi
echo  -e "\e[1;36m             Done \e[0m"

echo All HTTP Ports: 
cat $IP/allports | grep open | grep http | awk '{print $1}'


echo "Select the port for fuzzing" 
read port
echo "Enter the path to fuzz (By default / )"
read path
echo Choose the Wordlist:
echo 1. Dirbuster medium
echo 2. Dirb common
echo 3. Enter manually

read menuitem
echo "First Nikto Scan Started (It will take a lot of time so check it after a while)"
touch $IP/nikto
n_nikto="sudo nikto -h http://$IP > $IP/nikto.txt"
$n_nikto> /dev/null &

echo "Gobuster started"
case $menuitem in
		1) gobuster dir -u http://$IP:$port/$path -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -x 'txt,php,jpeg,xml,html,sh' -o $IP/gobuster -t 100
		;;
		2) gobuster dir -u http://$IP:$port/$path -w /usr/share/dirb/wordlists/common.txt -x 'txt,php,jpeg,xml,html,sh' -o $IP/gobuster -t 100
		;;
		3)  echo Give the absolute path
			read wordlist
			gobuster dir -u http://$IP:$port/$path -w $wordlist -x 'txt,php,jpeg,xml,html,sh'  -o $IP/gobuster -t 100
		;;
esac
echo Done with Recon



