#sim_modv3x
#disable
socket_port=8443
socket_chkapp=0
proc_chkapp=1
down_recheck=1
down_recheck_delay=10
init_name=psa
run_name=httpsd

urlaware=1
kproc=1

serv_init $init_name $run_name 4
chk_url "https" "$socket_port" "127.0.0.1" "/" "200 OK"
