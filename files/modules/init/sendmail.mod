#sim_modv3x
#disable
socket_port=25
socket_chkapp=0
proc_chkapp=1
down_recheck=1
down_recheck_delay=10

# restart mailscanner instead of sendmail
# for down events?
mscanner_rst=0
if [ -f "/etc/init.d/MailScanner" ] && [ "$mscanner_opt" == "1" ]; then
	init_name=MailScanner
else
	init_name=sendmail
fi

run_name=sendmail
serv_init $init_name $run_name 4
