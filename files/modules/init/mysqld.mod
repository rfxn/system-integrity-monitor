#sim_modv3x
#disable
socket_port=3306
down_recheck=1
down_recheck_delay=10
if [ -f "/etc/init.d/mysql" ]; then
	init_name=mysql
elif [ -f "/etc/init.d/mysqld" ]; then
	init_name=mysqld
fi
run_name=mysqld
mysql_sock="/var/lib/mysql/mysql.sock"
mysql_tmpsock="/tmp/mysql.sock"

chk_mysql_sock
serv_init $init_name $run_name 4
