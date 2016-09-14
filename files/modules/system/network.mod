#sim_modv3x
#disable
nameval=network

for i in `echo $IF`; do
ST_NET=`/sbin/ifconfig $i | grep inet | cut -d : -f 2 | cut -d \  -f 1`
TT_NET=`/usr/bin/tail -n $LN $KLOG | grep -wi "$i: transmit timed out"`

sanity_path $INSTALL_PATH/internals/stat/$nameval.stat 3

if [ "$ST_NET" == "" ]; then
        echo "                   $i offline" >> $INSTALL_PATH/internals/stat/$nameval.stat
        echo_out "{sys.network} $i is offline; no ip bound" 1
        track_event $nameval
        ALERT=1
	serv_init $nameval $nameval 1
elif [ ! "$TT_NET" == "" ]; then
        echo "                   $i offline" >> $INSTALL_PATH/internals/stat/$nameval.stat
        echo_out "{sys.network} $i is offline; transmit error" 1
        track_event $nameval
        ALERT=1
	serv_init $nameval $nameval 1
else
        echo "                   $i online" >> $INSTALL_PATH/internals/stat/$nameval.stat
        echo_out "{sys.network} $i is online" 1
fi
done
