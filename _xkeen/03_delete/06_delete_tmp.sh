# Удаление временных файлов и директорий
delete_tmp() {
    if [ -d "$tmp_dir_global/xkeen" ]; then
        rm -r "$tmp_dir_global/xkeen"
    fi

    if [ -f "$cron_dir/root.tmp" ]; then
        rm "$cron_dir/root.tmp"
    fi
	echo -e "  Приступаю к ${yellow}очистке временных файлов${reset} после работы Xkeen…"
	sleep 1
	echo -e "  Очистка временных файлов после работы Xkeen ${green}успешно выполнена${reset}"
}
