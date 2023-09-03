# Регистрация xray

register_xray_control() {

    # Создание файла xray.control
    cat << eof > "$register_dir/xray.control"
package: xray
version: $xray_current_version
depends: libc, libssp, librt, libpthread, ca-bundle
source: xtls team
sourcename: xray
section: net
sourcedateepoch: $source_date_epoch
maintainer: skrill
architecture: $status_architecture
installed-size: $installed_size
description: a unified platform for anti-censorship.
eof
}

register_xray_list() {

    # Переход в папку register_dir
    cd "$register_dir/" || exit

    touch xray.list
    cat >> xray.list << eof	
	
if [ -e "/opt/sbin/xray" ]; then
    echo "/opt/sbin/xray" >> xray.list
fi

if [ -e "/opt/etc/dat/geodata_antifilter.dat" ]; then
    echo "/opt/etc/dat/geodata_antifilter.dat" >> xray.list
fi

if [ -e "/opt/etc/dat/geodata_antizapret.dat" ]; then
    echo "/opt/etc/dat/geodata_antizapret.dat" >> xray.list
fi

if [ -e "/opt/etc/dat/geodata_v2ray.dat" ]; then
    echo "/opt/etc/dat/geodata_v2ray.dat" >> xray.list
fi

if [ -e "/opt/etc/dat/geoip_antifilter.dat" ]; then
    echo "/opt/etc/dat/geoip_antifilter.dat" >> xray.list
fi

if [ -e "/opt/etc/dat/geoip_v2ray.dat" ]; then
    echo "/opt/etc/dat/geoip_v2ray.dat" >> xray.list
fi

if [ -e "/opt/etc/dat" ]; then
    echo "/opt/etc/dat" >> xray.list
fi

if [ -e "/opt/etc/configs/00_base.json" ]; then
    echo "/opt/etc/configs/00_base.json" >> xray.list
fi

if [ -e "/opt/etc/configs/01_log.json" ]; then
    echo "/opt/etc/configs/01_log.json" >> xray.list
fi

if [ -e "/opt/etc/configs/02_stats.json" ]; then
    echo "/opt/etc/configs/02_stats.json" >> xray.list
fi

if [ -e "/opt/etc/configs/03_dns.json" ]; then
    echo "/opt/etc/configs/03_dns.json" >> xray.list
fi

if [ -e "/opt/etc/configs/04_reverse.json" ]; then
    echo "/opt/etc/configs/04_reverse.json" >> xray.list
fi

if [ -e "/opt/etc/configs/05_fake-dns.json" ]; then
    echo "/opt/etc/configs/05_fake-dns.json" >> xray.list
fi

if [ -e "/opt/etc/configs/06_transport.json" ]; then
    echo "/opt/etc/configs/06_transport.json" >> xray.list
fi

if [ -e "/opt/etc/configs/07_inbounds.json" ]; then
    echo "/opt/etc/configs/07_inbounds.json" >> xray.list
fi

if [ -e "/opt/etc/configs/08_outbounds.json" ]; then
    echo "/opt/etc/configs/08_outbounds.json" >> xray.list
fi

if [ -e "/opt/etc/configs/09_policy.json" ]; then
    echo "/opt/etc/configs/09_policy.json" >> xray.list
fi

if [ -e "/opt/etc/configs/10_routing.json" ]; then
    echo "/opt/etc/configs/10_routing.json" >> xray.list
fi

if [ -e "/opt/etc/xray" ]; then
    echo "/opt/etc/xray" >> xray.list
fi

if [ -e "/opt/etc/init.d/s24xray" ]; then
    echo "/opt/etc/init.d/s24xray" >> xray.list
fi

if [ -e "/opt/var/log/xray/error.log" ]; then
    echo "/opt/var/log/xray/error.log" >> xray.list
fi

if [ -e "/opt/var/log/xray/access.log" ]; then
    echo "/opt/var/log/xray/access.log" >> xray.list
fi

if [ -e "/opt/var/log/xray" ]; then
    echo "/opt/var/log/xray" >> xray.list
fi

if [ -e "/opt/var/run/xray.pid" ]; then
    echo "/opt/var/run/xray.pid" >> xray.list
fi

eof

}



register_xray_status() {
    # Генерация хэш-сумм для .json файлов
    hash_00_base=$(sha256sum "$install_conf_dir/00_base.json" | awk '{print $1}')
    hash_01_log=$(sha256sum "$install_conf_dir/01_log.json" | awk '{print $1}')
    hash_02_stats=$(sha256sum "$install_conf_dir/02_stats.json" | awk '{print $1}')
    hash_03_dns=$(sha256sum "$install_conf_dir/03_dns.json" | awk '{print $1}')
    hash_04_reverse=$(sha256sum "$install_conf_dir/04_reverse.json" | awk '{print $1}')
    hash_05_fake_dns=$(sha256sum "$install_conf_dir/05_fake-dns.json" | awk '{print $1}')
    hash_06_transport=$(sha256sum "$install_conf_dir/06_transport.json" | awk '{print $1}')
    hash_07_inbounds=$(sha256sum "$install_conf_dir/07_inbounds.json" | awk '{print $1}')
    hash_08_outbounds=$(sha256sum "$install_conf_dir/08_outbounds.json" | awk '{print $1}')
    hash_09_policy=$(sha256sum "$install_conf_dir/09_policy.json" | awk '{print $1}')
    hash_10_routing=$(sha256sum "$install_conf_dir/10_routing.json" | awk '{print $1}')

    new_entry="

package: xray
version: $xray_current_version
depends: libc, libssp, librt, libpthread, ca-bundle
status: install user installed
architecture: $status_architecture
conffiles:
 /opt/etc/xray/configs/00_base.json $hash_00_base
 /opt/etc/xray/configs/01_log.json $hash_01_log
 /opt/etc/xray/configs/02_stats.json $hash_02_stats
 /opt/etc/xray/configs/03_dns.json $hash_03_dns
 /opt/etc/xray/configs/04_reverse.json $hash_04_reverse
 /opt/etc/xray/configs/05_fake-dns.json $hash_05_fake_dns
 /opt/etc/xray/configs/06_transport.json $hash_06_transport
 /opt/etc/xray/configs/07_inbounds.json $hash_07_inbounds
 /opt/etc/xray/configs/08_outbounds.json $hash_08_outbounds
 /opt/etc/xray/configs/09_policy.json $hash_09_policy
 /opt/etc/xray/configs/10_routing.json $hash_10_routing
installed-time: $(date +%s)"

    existing_content=$(cat "$status_file")
    new_content="$existing_content$new_entry"
    echo "$new_content" > "$status_file"
}


# Функция для создания или обновления инициализационного скрипта для Xray
register_xray_initd() {
  local initd_file="$initd_dir/S24xray"
  
  local script_content="#!/bin/sh
### begin init info
# provides:          xray
# required-start:    \$local_fs \$network
# required-stop:     \$local_fs \$network
# default-start:     2 3 4 5
# default-stop:      0 1 6
# short-description: start/stop xray
### end init info

path=/opt/bin:/opt/sbin:/sbin:/bin:/usr/sbin:/usr/bin
xray_path=/opt/sbin/xray
xray_config=/opt/etc/xray/
pidfile=/opt/var/run/xray.pid

xray_status()
{
  if [ -f \$pidfile ]; then
    local pid=\$(cat \$pidfile)
    if ps -p \$pid > /dev/null; then
      return 0 # Процесс существует и работает
    else
      return 1 # Процесс не существует
    fi
  else
    return 1 # pid файл отсутствует
  fi
}

start()
{
  if xray_status; then
    echo \"xray уже запущен\"
  else
    \$xray_path -confdir dir \$xray_config &
    echo \$! > \$pidfile
    echo \"xray запущен\"
  fi
}

stop()
{
  if xray_status; then
    kill \"\$(cat \$pidfile)\"
    rm -f \$pidfile
    echo \"xray остановлен\"
  else
    echo \"xray не запущен\"
  fi
}

# Ожидание завершения процесса
wait_for_process()
{
  local pid=\$1
  while ps -p \$pid > /dev/null; do
    sleep 1
  done
}

case \"\$1\" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  status)
    if xray_status; then
      echo \"xray запущен\"
    else
      echo \"xray не запущен\"
    fi
    ;;
  restart)
    stop
    wait_for_process \"\$(cat \$pidfile)\"
    start
    ;;
  *)
    echo \"Команды: \$0 {start|stop|restart|status}\"
    ;;
esac

exit 0
"
  
  # Создание или замена файла
  if [ -e "$initd_file" ]; then
    rm "$initd_file"
  fi

  echo "$script_content" > "$initd_file"
  chmod +x "$initd_file"
}
