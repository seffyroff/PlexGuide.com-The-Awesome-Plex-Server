d#!/bin/bash
#
# [PlexGuide Menu]
#
# GitHub:   https://github.com/Admin9705/PlexGuide.com-The-Awesome-Plex-Server
# Author:   Admin9705 - Deiteq
# URL:      https://plexguide.com
#
# PlexGuide Copyright (C) 2018 PlexGuide.com
# Licensed under GNU General Public License v3.0 GPL-3 (in short)
#
#   You may copy, distribute and modify the software as long as you track
#   changes/dates in source files. Any modifications to our software
#   including (via compiler) GPL-licensed code must also be made available
#   under the GPL along with build & install instructions.
#
#################################################################################
#hostname -I | awk '{print $1}' > /var/plexguide/server.ip
edition=$( cat /var/plexguide/pg.edition ) 1>/dev/null 2>&1
version=$( cat /var/plexguide/pg.version ) 1>/dev/null 2>&1

export NCURSES_NO_UTF8_ACS=1
clear
HEIGHT=18
WIDTH=40
CHOICE_HEIGHT=12
BACKTITLE="Visit PlexGuide.com - Automations Made Simple"
TITLE="$edition - $version"

OPTIONS=(A "RClone & PlexDrive"
         B "PG Program Suite"
         C "PG Server Security"
         D "PG Server Information"
         E "PG Troubleshooting Actions"
         F "PG Settings & Tools"
         G "PG Backup & Restore"
         H "PG Updates"
         I "PG Edition Switch"
         J "Donation Menu"
         K "RClone Cache - Early Test"
         Z "Exit")

CHOICE=$(dialog --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
case $CHOICE in
        A)
            bash /opt/plexguide/menus/plexdrive/rc-pd.sh ;;
        B)
            bash /opt/plexguide/menus/programs/main.sh ;;
        C)
            bash /opt/plexguide/menus/security/main.sh ;;
        D)
            bash /opt/plexguide/menus/info-tshoot/info.sh ;;
        E)
            bash /opt/plexguide/menus/info-tshoot/tshoot.sh ;;
        F)
            bash /opt/plexguide/menus/settings/main.sh ;;
        G)
            bash /opt/plexguide/menus/backup-restore/main.sh ;;
        H)
            bash /opt/plexguide/scripts/upgrade/main.sh
            bash /opt/plexguide/scripts/message/ending.sh
            exit 0 ;;
        H)
            bash /opt/plexguide/menus/pgstatus/main.sh ;;
        I)
            rm -r /var/plexguide/pg.edition
            bash /opt/plexguide/scripts/baseinstall/edition.sh
            exit 0 ;;
        J)
            bash /opt/plexguide/menus/donate/main.sh ;;
        K)
            bash /opt/plexguide/scripts/docker-no/rcache.sh
            echo "RClone - You Chose the Unencrypted Method" > /tmp/pushover
            ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags pushover &>/dev/null &
            ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags clean &>/dev/null & ;;
        Z)
            bash /opt/plexguide/scripts/message/ending.sh
            exit 0 ;;
esac

## repeat menu when exiting
bash /opt/plexguide/menus/main.sh
