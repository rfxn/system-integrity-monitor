#sim_modv3x
#disable
nameval=disk

sanity_path $INSTALL_PATH/internals/stat/$nameval.stat 3
PART_LIST=`cat /etc/fstab | grep "ext" | awk '{print$2}'`
for i in `echo $PART_LIST`; do
if [ -d "$i" ] && [ ! "$i" == "" ]; then
	PERC_USE=`$df -h $i | tr -d 'M' | tr -d '%' | grep "dev" | awk '{print$5}'`
	PERC_FREE=$[100-PERC_USE]
	if [ "$PERC_USE" -lt "10" ]; then
		PERC_USE="0$PERC_USE"
	fi
	if [ "$PERC_USE" -gt "$DISK_WARN" ]; then
		echo "                   $PERC_USE%         $i" >> $INSTALL_PATH/internals/stat/$nameval.stat
		echo_out "{sys.disk} partition $i low on space, usage at $PERC_USE%." 1

	if [ -f "$INSTALL_PATH/internals/stat/devg.dat" ]; then
	        DEVG_VAL=`cat $INSTALL_PATH/internals/stat/devg.dat`
	        DIFF=$[UTIME-DEVG_VAL]
	        if [ "$DIFF" -gt "$AEVG" ]; then
                track_event $nameval
                ALERT=1
                DFLR=`cat $INSTALL_PATH/internals/stat/flr.stat`
                if [ "$FLR" == "1" ] && [ ! "$DFLR" == "1" ] && [ -f "/etc/logrotate.conf" ]; then
                        $logrotate --force /etc/logrotate.conf
			echo "1" > $INSTALL_PATH/internals/stat/flr.stat
			echo_out "{sys.disk} forcing logrotate" 1
                fi
		if [ "$DOL" == "1" ]; then
			 $tmpwatch -f -d $ML_AGE $LOG_PATH/
			 echo_out "{sys.disk} purging log files older than $ML_AGE hours from $LOG_PATH" 1
		fi
		         echo "$UTIME" > $INSTALL_PATH/internals/stat/devg.dat
	        fi
	else
	        echo "$UTIME" > $INSTALL_PATH/internals/stat/devg.dat
                track_event $nameval
                ALERT=1
		DFLR=`cat $INSTALL_PATH/internals/stat/flr.stat`
                if [ "$FLR" == "1" ] && [ ! "$DFLR" == "1" ] && [ -f "/etc/logrotate.conf" ]; then
                        $logrotate --force /etc/logrotate.conf
                        echo "1" > $INSTALL_PATH/internals/stat/flr.stat
                        echo_out "{sys.disk} forcing logrotate" 1
                fi
                if [ "$DOL" == "1" ]; then
                         $tmpwatch -f -d $ML_AGE $LOG_PATH/
                         echo_out "{sys.disk} purging log files older than $ML_AGE hours from $LOG_PATH" 1
                fi
	fi
	fi
fi
done
get_evcount $nameval
if [ "$EVCOUNT" -eq "0" ]; then
	echo_out "{sys.disk} all partitions ok." 1
fi
