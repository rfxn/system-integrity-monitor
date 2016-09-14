#sim_modv3x
#disable
socket_port=110
socket_chkapp=0
proc_chkapp=1
down_recheck=1
down_recheck_delay=5
init_name=dovecot
run_name=dovecot
serv_init $init_name $run_name 4
