#!/bin/sh

install_configs() {

    # Проверяем, существует ли директория XKEEN_CONF_DIR
    if [ -d "$XKEEN_CONF_DIR" ]; then
        # Получаем список .json файлов из XKEEN_CONF_DIR
        xkeen_files="$XKEEN_CONF_DIR"/*.json
        
        # Список файлов для замены
        files_to_replace=""
        
        # Проверяем, есть ли аналогичные файлы в INSTALL_CONF_DIR
        for file in $xkeen_files; do
            filename=$(basename "$file" .json)
            if [ -f "$INSTALL_CONF_DIR/$filename.json" ]; then
                files_to_replace="$files_to_replace $filename"
            else
                cp "$file" "$INSTALL_CONF_DIR/"
                echo -e "Файл $YELLOW$filename$RESET скопирован."
            fi
        done
        
        # Если есть файлы для замены, спрашиваем пользователя
        if [ -n "$files_to_replace" ]; then
            echo
			echo
            echo -e "$YELLOWУ Вас уже есть конфигурация Xray$RESET"
			echo "Хотите заменить следующие файлы?"
            echo
            for filename in $files_to_replace; do
                echo -e "$filename"
            done
            
			echo
			echo -e "В случае согласия будет выполнено резервное копирование Ваших файлов."
			echo -e "Вы сможете найти их в директории «$YELLOW/opt/backups/$RESET»"
            if input_concordance_list "Выберите ${RED}0${RESET} — «${RED}No${RESET}» или ${GREEN}1${RESET} — «${GREEN}Yes${RESET}»: "; then
                # Создаем резервную копию перед заменой
                backup_configs
                
                for filename in $files_to_replace; do
                    cp "$XKEEN_CONF_DIR/$filename.json" "$INSTALL_CONF_DIR/"
                done
            fi
        fi
    else
        echo "Директория $XKEEN_CONF_DIR не найдена."
    fi
}