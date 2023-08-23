#!/bin/sh

# Определение цветов для вывода в терминал
GREEN="\033[32m"     # Зеленый
RED="\033[31m"       # Красный
YELLOW="\033[33m"    # Желтый
DARK_GRAY="\e[90m" # Темно-серый
RESET="\033[0m"      # Сброс цветов

# Определение директорий
TMP_DIR="/opt/tmp/xkeen"                # Временная директория
XKEEN_LOG_DIR="/opt/var/log/xkeen"      # Директория логов для xkeen
XRAY_LOG_DIR="/opt/var/log/xray"        # Директория логов для xray
INITD_DIR="/opt/etc/init.d"             # Директория init.d
PID_DIR="/opt/var/run"                 # Директория для PID файлов
BACKUPS_DIR="/opt/backups"                # Директория для бекапов
INSTALL_DIR="/opt/sbin"                # Директория установки
GEO_DIR="/opt/etc/xray/dat"            # Директория для Geo баз
CRON_DIR="/opt/vat/spool/cron/crontabs"  # Директория для cron файла xkeen

# Определение URL API
XRAY_API_URL="https://api.github.com/repos/yichya/openwrt-xray/releases/latest"  # URL API для Xray
XKEEN_API_URL="https://api.github.com/repos/skrill/xreen/releases/latest"        # URL API для Xkeen

# Переменные для лог файлов
XKEEN_INFO_LOG="$XKEEN_LOG_DIR/info.log"	# Лог файл информации
XKEEN_ERROR_LOG="$XKEEN_LOG_DIR/error.log"	# Лог файл ошибок


#Переменные CPU
generated_keyword  	#Архитектура и модель через «_»
info_architecture 	#Архитектур
info_model 	#Модель

#Переменные cron
INFO_UPDATE_XRAY_CRON   	#Проверка установлена ли задача автоматического обновления Xray
INFO_UPDATE_XKEEN_CRON   	#Проверка установлена ли задача автоматического обновления Xkeen
INFO_UPDATE_GEOIP_CRON   	#Проверка установки задачи автоматического обновления GeoIP
INFO_UPDATE_GEODATA_CRON   	#Проверка установки задачи автоматического обновления GeoData

#Переменные установки Geo
GEO_EXISTS_GEODATA_ANTIZAPRET   	#Проверка установки базы GeoData AntiZapret
GEO_EXISTS_GEODATA_ANTIFILTER   	#Проверка установки базы GeoData AntiFilter
GEO_EXISTS_GEODATA_V2RAY   	#Проверка установки базы GeoData v2ray
GEO_EXISTS_GEOIP_ANTIFILTER   	#Проверка установки базы GeoData AntiFilter
GEO_EXISTS_GEOIP_V2RAY   	#Проверка установки базы GeoIP v2ray

#Переменные установки пакетов
INFO_PACKAGES_LSCPU    	#Проверка пакета lscpu
INFO_PACKAGES_CURL    	#Проверка пакета curl
INFO_PACKAGES_JQ    	#Проверка пакета jq
INFO_PACKAGES_LIBC   	#Проверка пакета libc

#Проверка Xray
XRAY_INSTALLED #Проверка установки Xray
XRAY_CURRENT_VERSION #Проверка текущей версии Xray
XRAY_GITHUB_VERSION #Проверка GitHub версии Xray

#Проверка Xkeen
XKEEN_CURRENT_VERSION #Проверка текущей версии Xkeen
XKEEN_GITHUB_VERSION #Проверка GitHub версии Xkeen

INFO_COMPARE_XRAY #Проверка нужно ли обновление Xray
INFO_COMPARE_XKEEN #Проверка нужно ли обновление Xkeen

#Выборы пользователя GeoIP
chose_geodata_v2fly_select #Нужно ли установить GeoData v2fly
chose_geodata_antifilter_select #Нужно ли установить GeoData  AntiFilter
chose_geodata_antizapret_select #Нужно ли установить GeoData  AntiZapret

chose_delete_geodata_v2fly_select #Нужно ли удалить GeoData v2fly
chose_delete_geodata_antifilter_select #Нужно ли удалить GeoData AntiFilter
chose_delete_geodata_antizapret_select #Нужно ли удалить GeoData  AntiZapret

#Выборы пользователя GeoData
chose_geoip_antifilter_select #Нужно ли установить GeoData  AntiFilter
chose_geoip_v2fly_select #Нужно ли установить GeoData  v2fly

chose_delete_geoip_antifilter_select #Нужно ли удалить GeoData AntiFilter
chose_delete_geoip_v2fly_select #Нужно ли удалить GeoData v2fly

#Выборы пользователя Cron
chose_xkeen_cron_select  #Нужно ли включить автоматическое обновление Xkeen
chose_xray_cron_select #Нужно ли включить автоматическое обновление Xray
chose_geodata_cron_select #Нужно ли включить автоматическое обновление GeoData
chose_geoip_cron_select #Нужно ли включить автоматическое обновление GeoIP

chose_all_cron_select #Нужно ли удалить все задачи cron

#Выборы пользователя для времени cron
chose_xkeen_cron_time #Время Xkeen
chose_xray_cron_time #Время Xray
chose_geodata_cron_time #Время GeoData
chose_geoip_cron_time #Время GeoIP

#