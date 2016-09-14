#sim_modv3x
#disable
socket_port=25
socket_chkapp=0
proc_chkapp=1
down_recheck=1
down_recheck_delay=5
init_name=exim
run_name=exim
serv_init $init_name $run_name 4
