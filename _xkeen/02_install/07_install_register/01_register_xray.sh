#!/bin/sh

register_xray_control() {

    # Создание файла xray.control
    cat << EOF > "$REGISTER_DIR/xray.control"
Package: xray
Version: $XRAY_CURRENT_VERSION
Depends: libc, libssp, librt, libpthread, ca-bundle
Source: XTLS Team
SourceName: xray
Section: net
SourceDateEpoch: $SOURCE_DATE_EPOCH
Maintainer: Skrill
Architecture: $status_architecture
Installed-Size: $INSTALLED_SIZE
Description: A unified platform for anti-censorship.
EOF
}

register_xray_list() {

    # Переход в папку REGISTER_DIR
    cd "$REGISTER_DIR/" || exit

    touch xray.list
    cat >> xray.list << EOF	
/opt/sbin/xray

/opt/etc/dat/geodata_antifilter.dat
/opt/etc/dat/geodata_antizapret.dat
/opt/etc/dat/geodata_v2ray.dat
/opt/etc/dat/geoip_antifilter.dat
/opt/etc/dat/geoip_v2ray.dat
/opt/etc/dat

/opt/etc/configs/00_base.json
/opt/etc/configs/01_log.json
/opt/etc/configs/02_stats.json
/opt/etc/configs/03_dns.json
/opt/etc/configs/04_reverse.json
/opt/etc/configs/05_fake-dns.json
/opt/etc/configs/06_transport.json
/opt/etc/configs/07_inbounds.json
/opt/etc/configs/08_outbounds.json
/opt/etc/configs/09_policy.json
/opt/etc/configs/10_routing.json
/opt/etc/configs

/opt/etc/xray
/opt/etc/init.d/S24xray

/opt/var/log/xray/error.log
/opt/var/log/xray/access.log
/opt/var/log/xray

/opt/var/run/xray.pid
EOF

}


register_xray_status() {
    # Генерация хэш-сумм для .json файлов
    HASH_00_base=$(sha256sum "$INSTALL_CONF_DIR/00_base.json" | awk '{print $1}')
    HASH_01_log=$(sha256sum "$INSTALL_CONF_DIR/01_log.json" | awk '{print $1}')
    HASH_02_stats=$(sha256sum "$INSTALL_CONF_DIR/02_stats.json" | awk '{print $1}')
    HASH_03_dns=$(sha256sum "$INSTALL_CONF_DIR/03_dns.json" | awk '{print $1}')
    HASH_04_reverse=$(sha256sum "$INSTALL_CONF_DIR/04_reverse.json" | awk '{print $1}')
    HASH_05_fake_dns=$(sha256sum "$INSTALL_CONF_DIR/05_fake-dns.json" | awk '{print $1}')
    HASH_06_transport=$(sha256sum "$INSTALL_CONF_DIR/06_transport.json" | awk '{print $1}')
    HASH_07_inbounds=$(sha256sum "$INSTALL_CONF_DIR/07_inbounds.json" | awk '{print $1}')
    HASH_08_outbounds=$(sha256sum "$INSTALL_CONF_DIR/08_outbounds.json" | awk '{print $1}')
    HASH_09_policy=$(sha256sum "$INSTALL_CONF_DIR/09_policy.json" | awk '{print $1}')
    HASH_10_routing=$(sha256sum "$INSTALL_CONF_DIR/10_routing.json" | awk '{print $1}')

    # Генерация новой записи
    new_entry="

Package: xray
Version: $XRAY_CURRENT_VERSION
Depends: libc, libssp, librt, libpthread, ca-bundle
Status: install user installed
Architecture: $status_architecture
Conffiles:
 /opt/etc/xray/configs/00_base.json $HASH_00_base
 /opt/etc/xray/configs/01_log.json $HASH_01_log
 /opt/etc/xray/configs/02_stats.json $HASH_02_stats
 /opt/etc/xray/configs/03_dns.json $HASH_03_dns
 /opt/etc/xray/configs/04_reverse.json $HASH_04_reverse
 /opt/etc/xray/configs/05_fake-dns.json $HASH_05_fake_dns
 /opt/etc/xray/configs/06_transport.json $HASH_06_transport
 /opt/etc/xray/configs/07_inbounds.json $HASH_07_inbounds
 /opt/etc/xray/configs/08_outbounds.json $HASH_08_outbounds
 /opt/etc/xray/configs/09_policy.json $HASH_09_policy
 /opt/etc/xray/configs/10_routing.json $HASH_10_routing
Installed-Time: $(date +%s)"

    # Чтение существующего содержимого файла "status"
    existing_content=$(cat "$STATUS_FILE")

    # Объединение существующего содержимого и новой записи
    new_content="$existing_content$new_entry"

    # Запись измененного содержимого обратно в файл "status"
    echo "$new_content" > "$STATUS_FILE"
}


register_xray_initd() {
  local INITD_FILE="$INITD_DIR/S24xray"
  
  local SCRIPT_CONTENT="#!/bin/sh
### BEGIN INIT INFO
# Provides:          xray
# Required-Start:    \$local_fs \$network
# Required-Stop:     \$local_fs \$network
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start/stop xray
### END INIT INFO

PATH=/opt/bin:/opt/sbin:/sbin:/bin:/usr/sbin:/usr/bin
XRAY_PATH=/opt/sbin/xray
XRAY_CONFIG=/opt/etc/xray/
PIDFILE=/opt/var/run/xray.pid

xray_status()
{
  if [ -f \$PIDFILE ]; then
    local pid=\$(cat \$PIDFILE)
    if ps -p \$pid > /dev/null; then
      return 0 # Процесс существует и работает
    else
      return 1 # Процесс не существует
    fi
  else
    return 1 # PID файл отсутствует
  fi
}

start()
{
  if xray_status; then
    echo \"Xray уже запущен\"
  else
    \$XRAY_PATH -confdir dir \$XRAY_CONFIG &
    echo \$! > \$PIDFILE
    echo \"Xray запущен\"
  fi
}

stop()
{
  if xray_status; then
    kill \"\$(cat \$PIDFILE)\"
    rm -f \$PIDFILE
    echo \"Xray остановлен\"
  else
    echo \"Xray не запущен\"
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
      echo \"Xray запущен\"
    else
      echo \"Xray не запущен\"
    fi
    ;;
  restart)
    stop
    wait_for_process \"\$(cat \$PIDFILE)\"
    start
    ;;
  *)
    echo \"Команды: \$0 {start|stop|restart|status}\"
    ;;
esac

exit 0
"
  
  # Создание или замена файла
  if [ -e "$INITD_FILE" ]; then
    rm "$INITD_FILE"
  fi

  echo "$SCRIPT_CONTENT" > "$INITD_FILE"
  chmod +x "$INITD_FILE"
}
