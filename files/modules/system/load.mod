#sim_modv3x
#disable
nameval=load

. $INSTALL_PATH/modules/system/load/functions.lm

sanity_path $INSTALL_PATH/internals/stat/$nameval.stat 3

case '$LOAD' in
5|five|1)
	CLOAD=`cat /proc/loadavg | awk '{print$1}' | tr '.' ' ' | awk '{print$1}'`
	;;
10|ten|2)
	CLOAD=`cat /proc/loadavg | awk '{print$2}' | tr '.' ' ' | awk '{print$1}'`
	;;
15|fifteen|3)
	CLOAD=`cat /proc/loadavg | awk '{print$3}' | tr '.' ' ' | awk '{print$1}'`
	;;
*)
	CLOAD=`cat /proc/loadavg | awk '{print$1}' | tr '.' ' ' | awk '{print$1}'`
esac

if [ "$CLOAD" -gt "$LWARN" ] && [ "$CLOAD" -lt "$LCAUT" ]; then
        echo_out "{sys.load} load status warning ($CLOAD)." 1
	lact warn
	track_event $nameval
	ALERT=1
elif [ "$CLOAD" -gt "$LCAUT" ] && [ "$CLOAD" -lt "$LCRIT" ]; then
        echo_out "{sys.load} load status caution ($CLOAD)." 1
        lact caut
	track_event $nameval
        ALERT=1
elif [ "$CLOAD" -gt "$LCRIT" ]; then
        echo_out "{sys.load} load status critical ($CLOAD)." 1
        lact crit
        track_event $nameval
        ALERT=1
else
	echo_out "{sys.load} load status ok ($CLOAD)." 1
fi
