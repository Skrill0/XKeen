# Функция для установки файлов конфигурации xray
install_configs() {
    if [ -d "$xkeen_conf_dir" ]; then
        xkeen_files="$xkeen_conf_dir"/*.json
        files_to_replace=""

        for file in $xkeen_files; do
            filename=$(basename "$file" .json)
            if [ -f "$install_conf_dir/$filename.json" ]; then
                files_to_replace="$files_to_replace $filename"
            else
                cp "$file" "$install_conf_dir/"
                echo -e "  Файл ${yellow}$filename${reset} скопирован."
            fi
        done

        if [ -n "$files_to_replace" ]; then
            echo
            echo
            echo -e "  У Вас уже есть конфигурация ${yellow}xray${reset}."
            echo -e "  Хотите ${yellow}заменить${reset} следующие файлы?"
            echo
            for filename in $files_to_replace; do
                echo -e "     $filename"
            done

            echo
            echo -e "  В случае согласия будет выполнено ${yellow}резервное копирование${reset} Ваших файлов."
            echo -e "  Вы сможете найти их в директории «${yellow}/opt/backups/${reset}»."
            if input_concordance_list "Сделайте выбор: "; then
                backup_configs

                for filename in $files_to_replace; do
                    cp "$xkeen_conf_dir/$filename.json" "$install_conf_dir/"
                done
            fi
        fi
    else
        echo "  Директория $xkeen_conf_dir ${red}не найдена${reset}."
    fi
}
