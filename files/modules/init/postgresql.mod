#sim_modv3x
#disable
if [ -f "/etc/init.d/postgresql" ]; then
        init_name=postgresql
elif [ -f "/etc/init.d/postgresql_app_init" ]; then
        init_name=postgresql_app_init
elif [ -f "/etc/init.d/rhdb" ]; then
        init_name=rhdb
fi
run_name=postmaster
down_recheck=1
down_recheck_delay=10
serv_init $init_name $run_name 3
