#sim_modv3x
#disable
init_name=mailmanctl
run_name=mailmanctl
proc_chkapp=1
servinitopt=5
servinitopt_cust="-s start"
kproc=1
if [ -f "/usr/local/cpanel/3rdparty/mailman/bin/mailmanctl" ]; then
	ln -fs /usr/local/cpanel/3rdparty/mailman/bin/mailmanctl /etc/init.d/mailmanctl
fi
if [ ! -f "/usr/local/cpanel/3rdparty/mailman/locks/master-qrunner" ]; then
	killall -9 mailmanctl python python2 >> /dev/null 2>&1
fi
serv_init $init_name $run_name 3
