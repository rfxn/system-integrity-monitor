#sim_modv3x
#disable
socket_port=80
socket_chkapp=0
proc_chkapp=1
down_recheck=1
down_recheck_delay=5
init_name=httpd
run_name=httpd
servinitopt=0

chkinituse
kproc=1
sem_cl=1
if [ -d "/usr/local/apache" ]; then
	sem_owner=nobody
else
	sem_owner=apache
fi
urlaware=0

serv_init $init_name $run_name 4

# url aware monitoring
# more than one call to chk_url can be made (i.e: check http & https services)
chk_url "http" "$socket_port" "127.0.0.1" "/" "200 OK" "15"
