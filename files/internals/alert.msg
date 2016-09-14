if [ -f "$INSTALL_PATH/internals/stat/main.dat" ]; then
	MCOUNT=`cat $INSTALL_PATH/internals/stat/main.dat`
else
	MCOUNT=0
fi
STG=`stgen > $INSTALL_PATH/internals/tmp/.stgen`
STG=`cat -A $INSTALL_PATH/internals/tmp/.stgen | tr '^[[' ' ' | sed 's/20G//' | tr -d '\$'`

cat <<EOF
This is an automated alert from $HOSTNAME, the System Integrity Monitor (SIM) on your host has taken action in responce to an event. Enclosed below are event logs for your inspection; if more than $EVLIMIT events are triggered, alert e-mails will be suppressed for the duration of the day.

$STG

Tail lines ($LN) of sim_log:
$(tail -n $LN $SIM_LOG)

Tail lines ($LN) of kernel log:
$(tail -n $LN $KLOG)


===============================================================================
SIM $VER <sim@r-fx.org>                                               $UTIME
EOF
