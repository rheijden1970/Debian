#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: nil; tab-width: 4 -*-
#
# Authors:
#   Richard van der Heijden <doomofthecracks@gmail.com>
# Description:
#   A post-installation bash script for Ubuntu
#
# Legal Preamble:
#
# This script is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation; version 3.
#
# This script is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, see <https://www.gnu.org/licenses/gpl-3.0.txt>

# tab width
tabs 4
clear

#----- Import Functions -----#

dir="$(dirname "$0")"

. $dir/functies/controleer
. $dir/functies/opschonen
. $dir/functies/codecs
. $dir/functies/configureren
. $dir/functies/ontwikkeling
. $dir/functies/favorieten
. $dir/functies/derdeparty
. $dir/functies/update
. $dir/functies/utilities

#----- Fancy Messages -----#
show_error(){
echo -e "\033[1;31m$@\033[m" 1>&2
}
show_info(){
echo -e "\033[1;32m$@\033[0m"
}
show_warning(){
echo -e "\033[1;33m$@\033[0m"
}
show_question(){
echo -e "\033[1;34m$@\033[0m"
}
show_success(){
echo -e "\033[1;35m$@\033[0m"
}
show_header(){
echo -e "\033[1;36m$@\033[0m"
}
show_listitem(){
echo -e "\033[0;37m$@\033[0m"
}

# Main
function main {
    eval `resize`
    MAIN=$(whiptail \
        --notags \
        --title "Ubuntu Post-Installatie script" \
        --menu "\nWat wil je gaan doen?" \
        --cancel-button "Verlaten" \
        $LINES $COLUMNS $(( $LINES - 12 )) \
        update      'Voer een systeem update uit' \
        favs        'Installeer voorkeur applicaties' \
        utilities   'Installeer voorkeur systeem hulpprogramma's' \
        ontwikkeling 'Installeer voorkeur programmeer gereedschap' \
        codecs      'Installeer Ubuntu beperkte Extras' \
        derdeparty  'Installeer derde-partij software' \
        configure   'Configureer systeem' \
        cleanup     'Maak het systeem schoon' \
        3>&1 1>&2 2>&3)
     
    exitstatus=$?
    if [ $exitstatus = 0 ]; then
        $MAIN
    else
        quit
    fi
}

# Quit
function quit {
    if (whiptail --title "Afsluiten" --yesno "Weet u het zeker dat u wilt afsluiten?" 10 60) then
        echo "Afsluiten..."
        show_info 'Bedankt voor het gebruik!'
        exit 99
    else
        main
    fi
}

#RUN
check_dependencies
while :
do
  main
done

#END OF SCRIPT
