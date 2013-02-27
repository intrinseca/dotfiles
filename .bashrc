#!/bin/bash
#Bash Init Script, Michael Allan

default="\[\033[0m\]";
red="\[\033[31m\]";
orange="\[\033[1;31m\]";
yellow="\[\033[33m\]";
green="\[\033[32m\]";
blue="\[033[34m\]"
magenta="\[\033[35m\]";
brmagenta="\[\033[1;35m\]";
cyan="\[\033[36m\]";

host=hostname
defaultlocation='home'
location=$defaultlocation

if which dnsdomainname > /dev/null 2> /dev/null; then
    domain="dnsdomainname"
elif which domainname > /dev/null 2>/dev/null; then
    domain="domainname"
elif which nisdomainname > /dev/null 2>/dev/null; then
    domain="nisdomainname"
fi

location=`$domain | awk -F. '{print $1}'`

if [ "$location" == "" ]; then
		location=$defaultlocation;
fi

if [ "$location" == "(none)" ]; then
        location=$defaultlocation;
fi

if [ "$location" == "linux" ]; then
    location='pwf';
fi

case $location in
    "intrinseca" )
        echo "vps"
        color=$yellow
        ;;
    "srcf" )
        color=$yellow
        ;;
    "eng" )
        if [ `expr match "$host" "tw*"` != 0 ]; then
            color=$cyan
        else
            case `hostname` in
                "harrier"|"concorde" )
                    color=$red;;	#gate
                *)
                    color=$yellow;;	#server
            esac
        fi
        ;;
    * )
        color=$cyan
        ;;
esac;

username=`whoami`

if [ "$username" != michael ]; then
	user="$magenta$username$cyan/";
else
	user="";
fi

PS1="$cyan[$user$color\h$cyan@$location:$green\w$cyan]$default$ "
PATH=~/bin:$PATH
PKG_CONFIG_PATH=~/lib

alias ls='ls --color'
alias pacman='sudo pacman'
export EDITOR='nano'
