#!/bin/sh

# Определение цветов для вывода в терминал
GREEN="\033[32m"     # Зеленый
RED="\033[31m"       # Красный
YELLOW="\033[33m"    # Желтый
DARK_GRAY="\e[90m" # Темно-серый
RESET="\033[0m"      # Сброс цветов

# Определение директорий
TMP_DIR_GLOBAL="/opt/tmp"                # Временная директория общая
TMP_DIR="/opt/tmp/xkeen"                # Временная директория Xkeen
XKEEN_LOG_DIR="/opt/var/log/xkeen"      # Директория логов для xkeen
XRAY_LOG_DIR="/opt/var/log/xray"        # Директория логов для xray
INITD_DIR="/opt/etc/init.d"             # Директория init.d
PID_DIR="/opt/var/run"                 # Директория для PID файлов
BACKUPS_DIR="/opt/backups"                # Директория для бекапов
INSTALL_DIR="/opt/sbin"                # Директория установки
XKEEN_DIR="/opt/etc/xkeen"		# Xkeen директория
GEO_DIR="/opt/etc/xray/dat"            # Директория для Geo баз
CRON_DIR="/opt/var/spool/cron/crontabs"  # Директория для cron файла xkeen
CRON_FILE="root"		# Сron файл
INSTALL_CONF_DIR="/opt/etc/xray/configs"		# Директория для хранения конфигурации в Xray
XKEEN_CONF_DIR="$XKEEN_DIR/02_install/08_install_configs/02_configs_dir/"		# Директория для хранения конфигурации в Xkeen
REGISTER_DIR="/opt/lib/opkg/info"
STATUS_FILE="/opt/lib/opkg/status"
XKEEN_CURRENT_VERSION="0.1"

INSTALLED_TIME=$(date +%s)
existing_content=$(cat "$STATUS_FILE")
INSTALLED_SIZE=$(du -s "$INSTALL_DIR" | cut -f1)
SOURCE_DATE_EPOCH=$(date +%s)

# Определение URL API
XRAY_API_URL="https://api.github.com/repos/yichya/openwrt-xray/releases/latest"  # URL API для Xray
XKEEN_API_URL="https://api.github.com/repos/skrill/xreen/releases/latest"        # URL API для Xkeen

# Проверка и создание директорий логов, если не существуют
mkdir -p "$XKEEN_LOG_DIR" || { echo "Ошибка: Не удалось создать директорию $XKEEN_LOG_DIR"; exit 1; }
mkdir -p "$XRAY_LOG_DIR" || { echo "Ошибка: Не удалось создать директорию $XRAY_LOG_DIR"; exit 1; }
mkdir -p "$INITD_DIR" || { echo "Ошибка: Не удалось создать директорию $INITD_DIR"; exit 1; }
mkdir -p "$PID_DIR" || { echo "Ошибка: Не удалось создать директорию $PID_DIR"; exit 1; }
mkdir -p "$BACKUPS_DIR" || { echo "Ошибка: Не удалось создать директорию $BACKUPS_DIR"; exit 1; }
mkdir -p "$INSTALL_DIR" || { echo "Ошибка: Не удалось создать директорию $INSTALL_DIR"; exit 1; }
mkdir -p "$GEO_DIR" || { echo "Ошибка: Не удалось создать директорию $GEO_DIR"; exit 1; }
mkdir -p "$CRON_DIR" || { echo "Ошибка: Не удалось создать директорию $CRON_DIR"; exit 1; }

# Переменные для лог файлов
XKEEN_INFO_LOG="$XKEEN_LOG_DIR/info.log"
XKEEN_ERROR_LOG="$XKEEN_LOG_DIR/error.log"

# Создание .log файлов, если они не существуют
touch "$XKEEN_INFO_LOG" || { echo "Ошибка: Не удалось создать файл $XKEEN_INFO_LOG"; exit 1; }
touch "$XKEEN_ERROR_LOG" || { echo "Ошибка: Не удалось создать файл $XKEEN_ERROR_LOG"; exit 1; }

# Функция для вызова API с обработкой ошибок
call_api() {
    local url="$1"
    local response

    response=$(curl -sS "$url")
    if [ $? -ne 0 ]; then
        log_error "Ошибка при вызове API: $url"
        exit 1
    fi

    echo "$response"
}

# Проверка наличия и непустого значения переменных
for var in GREEN RED YELLOW RESET TMP_DIR XKEEN_LOG_DIR XRAY_LOG_DIR INITD_DIR PID_DIR BACKUPS_DIR INSTALL_DIR XRAY_API_URL XKEEN_API_URL XKEEN_INFO_LOG XKEEN_ERROR_LOG GEO_DIR CRON_DIR; do
    if [ -z "${var}" ]; then
        log_error "Переменная $var не определена или имеет пустое значение"
        exit 1;
    fi
done
