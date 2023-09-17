# Регистрация xray

register_xray_control() {

    # Создание файла xray.control
    cat << EOF > "$register_dir/xray.control"
Package: xray
Version: $xray_current_version
Depends: libc, libssp, librt, libpthread, ca-bundle
Source: XTLS Team
SourceName: xray
Section: net
SourceDateEpoch: $source_date_epoch
Maintainer: Skrill
Architecture: $status_architecture
Installed-Size: $installed_size
Description: A unified platform for anti-censorship.
EOF
}

# Определение функции register_xray_list
register_xray_list() {

    # Переход в папку REGISTER_DIR
    cd "$register_dir/" || exit

    # Создание файла xray.list или перезапись, если файл уже существует
    cat > xray.list << EOF
/opt/sbin/xray
/opt/etc/xray/dat/geosite_antifilter.dat
/opt/etc/xray/dat/geosite_antizapret.dat
/opt/etc/xray/dat/geosite_v2fly.dat
/opt/etc/xray/dat/geoip_antifilter.dat
/opt/etc/xray/dat/geoip_v2fly.dat
/opt/etc/xray/dat
/opt/etc/xray/configs/01_log.json
/opt/etc/xray/configs/02_stats.json
/opt/etc/xray/configs/03_dns.json
/opt/etc/xray/configs/04_reverse.json
/opt/etc/xray/configs/05_fake-dns.json
/opt/etc/xray/configs/06_transport.json
/opt/etc/xray/configs/07_inbounds.json
/opt/etc/xray/configs/08_outbounds.json
/opt/etc/xray/configs/09_policy.json
/opt/etc/xray/configs/10_routing.json
/opt/etc/xray/configs/11_fallbacks.json
/opt/etc/xray/configs
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
    HASH_01_log=$(sha256sum "$install_conf_dir/01_log.json" | awk '{print $1}')
    HASH_02_stats=$(sha256sum "$install_conf_dir/02_stats.json" | awk '{print $1}')
    HASH_03_dns=$(sha256sum "$install_conf_dir/03_dns.json" | awk '{print $1}')
    HASH_04_reverse=$(sha256sum "$install_conf_dir/04_reverse.json" | awk '{print $1}')
    HASH_05_fake_dns=$(sha256sum "$install_conf_dir/05_fake-dns.json" | awk '{print $1}')
    HASH_06_transport=$(sha256sum "$install_conf_dir/06_transport.json" | awk '{print $1}')
    HASH_07_inbounds=$(sha256sum "$install_conf_dir/07_inbounds.json" | awk '{print $1}')
    HASH_08_outbounds=$(sha256sum "$install_conf_dir/08_outbounds.json" | awk '{print $1}')
    HASH_09_policy=$(sha256sum "$install_conf_dir/09_policy.json" | awk '{print $1}')
    HASH_10_routing=$(sha256sum "$install_conf_dir/10_routing.json" | awk '{print $1}')
	HASH_11_fallbacks=$(sha256sum "$install_conf_dir/11_fallbacks.json" | awk '{print $1}')

    # Генерация новой записи
    new_entry="

Package: xray
Version: $xray_current_version
Depends: libc, libssp, librt, libpthread, ca-bundle
Status: install user installed
Architecture: $status_architecture
Conffiles:
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
/opt/etc/xray/configs/11_fallbacks.json $HASH_11_fallbacks
Installed-Time: $(date +%s)"

    # Чтение существующего содержимого файла "status"
    existing_content=$(cat "$status_file")

    # Объединение существующего содержимого и новой записи
    new_content="$existing_content$new_entry"

    # Запись измененного содержимого обратно в файл "status"
    echo "$new_content" > "$status_file"
}

# Функция для создания или обновления инициализационного скрипта для Xray
register_xray_initd() {
    local initd_file="$initd_dir/S24xray"
  
    local script_content='#!/bin/sh
### Начало информации о службе
# Краткое-описание:        Запуск / Остановка Xray
### Конец информации о службе

green="\033[32m"
red="\033[31m"
yellow="\033[33m"
reset="\033[0m" 

xkeen_info_log="/opt/var/log/xkeen/info.log"
xkeen_error_log="/opt/var/log/xkeen/error.log"

path=/opt/bin:/opt/sbin:/sbin:/bin:/usr/sbin:/usr/bin
xray_path=xray
xray_config=/opt/etc/xray/configs
pidfile=/opt/var/run/xray.pid
app_name=Xkeen

export XRAY_LOCATION_ASSET=/opt/etc/xray/dat/

# Функция для ведения журнала в роутере
log_notice_init(){
    local header=${app_name}
    logger -p notice -t "${header}" "${1}"
}

# Функция для проверки статуса xray
xray_status()
{
  if [ -f $pidfile ]; then
    local pid=$(cat $pidfile)
    if [ -d /proc/$pid ]; then
      return 0 # Процесс существует и работает
    else
      return 1 # Процесс не существует
    fi
  else
    return 1 # pid файл отсутствует
  fi
}

# Функция для запуска xray
start()
{
	log_notice_init "Инициирован запуск Xray"
  if xray_status; then
    echo -e "  Xray уже ${green}запущен${reset}"
	log_notice_init "Не удалось запустить Xray, так как он уже запущен"
	
	echo "" >> "$xkeen_error_log"
	echo "[start] Проверка статуса Xray" >> "$xkeen_error_log"
    echo "	[error] Xray уже запущен" >> "$xkeen_error_log"
	echo "[end] Проверка статуса Xray выполнена" >> "$xkeen_error_log"
	echo "" >> "$xkeen_error_log"
  else
    $xray_path run -confdir $xray_config &
    echo $! > $pidfile
	echo -e "  Xray ${green}запущен${reset}"
	log_notice_init "Xray запущен"
	
    echo "" >> "$xkeen_info_log"    
	echo "[end] Проверка статуса Xray" >> "$xkeen_info_log"
	echo "	[info] Xray запущен" >> "$xkeen_info_log"
	echo "[end] Проверка статуса Xray выполнена" >> "$xkeen_info_log"
	echo "" >> "$xkeen_info_log"
  fi
}

# Функция для остановки xray
stop()
{
	log_notice_init "Инициирована остановка Xray"
  if xray_status; then
    kill "$(cat $pidfile)"
    rm -f $pidfile
    echo -e "  Xray ${yellow}остановлен${reset}"
	log_notice_init "Xray остановлен"
	
    echo "" >> "$xkeen_info_log"
	echo "[start] Проверка статуса Xray" >> "$xkeen_info_log"
	echo "	[info] Xray остановлен" >> "$xkeen_info_log"
	echo "[end] Проверка статуса Xray выполнена" >> "$xkeen_info_log"
	echo "" >> "$xkeen_info_log"
  else
    echo -e "  Xray ${red}не запущен${reset}"
	log_notice_init "Остановка Xray не удалась. Xray не был запущен"
	
	echo "" >> "$xkeen_error_log"
	echo "[start] Проверка статуса Xray" >> "$xkeen_error_log"
    echo "	[error] Xray не был запущен" >> "$xkeen_error_log"
	echo "[end] Проверка статуса Xray выполнена" >> "$xkeen_error_log"
	echo "" >> "$xkeen_error_log"
  fi
}

# Функция для ожидания завершения процесса
wait_for_process()
{
  local pid=$1
  while [ -d /proc/$pid ]; do
    sleep 1
  done
}

# Обработка аргументов командной строки
case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  status)
    if xray_status; then
      echo -e "  Xray ${green}запущен${reset}"
	  
	  echo "" >> "$xkeen_info_log"
      echo "[start] Проверка статуса Xray" >> "$xkeen_info_log"
	  echo "	[info] Xray запущен" >> "$xkeen_info_log"
	  echo "[end] Проверка статуса Xray выполнена" >> "$xkeen_info_log"
	  echo "" >> "$xkeen_info_log"
    else
	  echo -e "  Xray ${red}не запущен${reset}"
	  
	  echo "" >> "$xkeen_info_log"
	  echo "[start] Проверка статуса Xray" >> "$xkeen_info_log"
      echo "	[info] Xray не запущен" >> "$xkeen_info_log"
	  echo "[end] Проверка статуса Xray выполнена" >> "$xkeen_info_log"
	  echo "" >> "$xkeen_info_log"
    fi
    ;;
  restart)
    stop > /dev/null 2>&1
    if [ -f $pidfile ]; then
      local pid=$(cat $pidfile)
      wait_for_process "$pid"
    fi
    start > /dev/null 2>&1
    echo -e "  Xray ${green}перезапущен${reset}"
    ;;
  *)
    echo -e "  Команды: ${green}start${reset} | ${red}stop${reset} | ${yellow}restart${reset} | status"
    ;;
esac

exit 0
'

# Создание или замена файла
if [ -e "$initd_file" ]; then
    rm "$initd_file"
fi

echo "$script_content" > "$initd_file"
chmod +x "$initd_file"
}
