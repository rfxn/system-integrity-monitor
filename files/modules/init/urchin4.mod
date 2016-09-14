#sim_modv3x
#disable
socket_port=9999
socket_chkapp=0
proc_chkapp=1
if [ -f "/etc/init.d/urchin4" ]; then
	init_name=urchin4
else
	init_name=urchin
fi
run_name=urchinwebd
serv_init $init_name $run_name 4
