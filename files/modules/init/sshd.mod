#sim_modv3x
#disable
socket_port=22
socket_chkapp=0
proc_chkapp=1
init_name=sshd
run_name=sshd
serv_init $init_name $run_name 4
