#!/bin/sh
#
# SIM 3.0 [sim@r-fx.org]
###
# Copyright (C) 1999-2005, R-fx Networks <sim@r-fx.org>
# Copyright (C) 2005, Ryan MacDonald <ryan@r-fx.org>
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
###
#
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:$PATH
VER="3.0"
SETUP_FILES="./files"
INSTALL_PATH="/usr/local/sim"
INBIN="bin"
BIN="/usr/local/sbin"
RES_COL="21"
MOVE_TO_COL="echo -en \\033[${RES_COL}G"

header() {
echo "SIM $VER [sim@r-fx.org]"
echo "======================"
}

install_notes() {
echo && echo && echo "Installation Summary:"
cat <<EOF
Base path:              $INSTALL_PATH
Configuration file:     $INSTALL_PATH/config/conf.sim
Configuration symlink:  /etc/conf.sim
Module control file:    $INSTALL_PATH/config/mods.control
Module control symlink: /etc/sim.mods
Executable:             $INSTALL_PATH/sim
Executable symlink:     /usr/local/sbin/sim
EOF
}

install() {
echo -n "Installing SIM $VER:"
$MOVE_TO_COL && echo -n "[===>                ] 15%" && usleep 120000
if [ -d "$SETUP_FILES" ]; then
        mkdir $INSTALL_PATH
        cp -R $SETUP_FILES/* $INSTALL_PATH
	cp GPL $INSTALL_PATH
	cp README CHANGELOG GPL $INSTALL_PATH/docs
        chmod -R 640 $INSTALL_PATH
        chmod 750 $INSTALL_PATH/$INBIN/sim
$MOVE_TO_COL && echo -n "[======>             ] 30%" && usleep 120000
	if [ ! -f "/etc/logrotate.d/sim" ]; then
		cp logrotate.d.sim /etc/logrotate.d/sim
	fi	
	if [ -f "/var/log/sim_log" ]; then
		rm -f /var/log/sim_log
	fi
        ln -fs $INSTALL_PATH/$INBIN/sim $BIN/sim
	ln -fs $INSTALL_PATH/config/conf.sim /etc/conf.sim
	ln -fs $INSTALL_PATH/config/mods.control /etc/sim.mods
	echo "$VER" >> $INSTALL_PATH/version
fi
$MOVE_TO_COL && echo -n "[====================] 100% Installation completed."
}

verbose() {
header
if [ -f "README" ]; then
	echo "Thank you for using SIM $VER, please take a few moments to review the GPL (v2) license and the README file."
        echo "press any key to continue..."
	read Z
	cat GPL | more
        cat README | more
	echo
fi

if [ -d "$INSTALL_PATH" ]; then
	clear
	echo "Installation path already exists, if you continue the current path ($INSTALL_PATH) will be over-written."
	echo "press any key to continue or CTRL+C to abort..."
	read Z
	if [ -f "/etc/crontab" ]; then
		CJV=`cat /etc/crontab | grep -w "/usr/local/sim/sim -q"`
		if [ ! "$CJV" == "" ] && [ -f "/usr/local/sim/sim" ]; then
			/usr/local/sim/sim -j
		fi
	fi
	rm -rf $INSTALL_PATH
fi
install
install_notes
}

quiet() {
if [ -d "$INSTALL_PATH" ]; then
 rm -rf $INSTALL_PATH
fi
install
install_notes
}

uninstall() {
header
if [ -d "$INSTALL_PATH" ] && [ -f "$INSTALL_PATH/bin/sim" ]; then
   echo "You are about to uninstall SIM from $INSTALL_PATH"
   echo "press any key to continue or CTRL+C to abort..."
   read Z
   echo "Uninstalling SIM..."
   rm -rf $INSTALL_PATH
   rm -f $BIN/sim
   rm -f $BIN/sim-auto*
   rm -f /etc/cron.d/sim /etc/conf.sim /etc/sim.mods
   echo "SIM has been uninstalled from this system."
else
	echo "$INSTALL_PATH does not exist, nothing to uninstall."
	exit 1
fi
}

case "$1" in
-i)
        verbose
        ;;
-q)
	header
	quiet
	;;
-u)
        uninstall
        ;;
*)
header
echo "usage: $0 [-i] [-q] [-u]"
echo "-i	Install"
echo "-q	Quiet install"
echo "-u	Uninstall"
esac
exit 0
