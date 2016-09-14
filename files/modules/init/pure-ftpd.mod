#sim_modv3x
#disable
socket_port=21
socket_chkapp=0
proc_chkapp=1
down_recheck=1
down_recheck_delay=10
init_name=pure-ftpd
run_name=pure-ftpd
serv_init $init_name $run_name 4
