#sim_modv3x
#disable
socket_port=53
down_recheck=1
down_recheck_delay=10
init_name=named
run_name=named
serv_init $init_name $run_name 4
