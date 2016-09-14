#sim_modv3x
#disable
socket_port=19638
socket_chkapp=0
proc_chkapp=1
down_recheck=1
down_recheck_delay=10
init_name=webppliance
run_name=ocwhttpd

sem_cl=1
sem_owner=nobody
urlaware=0
kproc=1
serv_init $init_name $run_name 4

# url aware monitoring
chk_url "https" "$socket_port" "127.0.0.1" "/webhost/rollout/" "200 OK" "15"
