register_cron_initd() {
    local initd_file="$initd_dir/S05crond"

    local script_content='#!/bin/sh
### Начало информации о службе
# Краткое описание: Запуск / Остановка Cron
### Конец информации о службе

green="\033[32m"
red="\033[31m"
yellow="\033[33m"
reset="\033[0m" 

cron_initd="/opt/sbin/crond"
cron_pidfile="/opt/var/run/crond.pid" # Путь к файлу с PID процесса Cron

# Функция для проверки статуса cron
cron_status() {
    if [ -e "$cron_pidfile" ]; then
        local pid=$(cat "$cron_pidfile")
        if [ -d "/proc/$pid" ]; then
            return 0 # Процесс существует и работает
        else
            return 1 # Процесс не существует
        fi
    else
        return 1 # PID-файл отсутствует
    fi
}

# Функция для запуска cron
start() {
    if cron_status; then
        echo -e "  Cron ${red}уже запущен${reset}"
    else
        $cron_initd -L /dev/null
        echo -e "  Cron ${green}запущен${reset}"
        echo $$ > "$cron_pidfile" # Сохраняем PID текущего процесса в файл
    fi
}

# Функция для остановки cron
stop() {
    if cron_status; then
        kill $(cat "$cron_pidfile")
        rm "$cron_pidfile" # Удаляем PID-файл после остановки
        echo -e "  Cron ${green}остановлен${reset}"
    else
        echo -e "  Cron ${red}не запущен${reset}"
    fi
}

# Функция для перезапуска cron
restart() {
    stop > /dev/null 2>&1
    start > /dev/null 2>&1
    echo -e "  Cron ${green}перезапущен${reset}"
}

# Обработка аргументов командной строки
case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        restart
        ;;
    status)
        if cron_status; then
            echo -e "  Cron ${green}запущен${reset}"
        else
            echo -e "  Cron ${red}не запущен${reset}"
        fi
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

    echo -e "$script_content" > "$initd_file"
    chmod +x "$initd_file"
}
