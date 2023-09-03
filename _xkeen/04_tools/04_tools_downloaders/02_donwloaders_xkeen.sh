# Загрузка xkeen

download_xkeen() {
    # Получение URL для загрузки последней версии xkeen с помощью cURL и grep
    download_url=$(curl -s "$xkeen_api_url" | grep -o '"browser_download_url": "[^"]*' | grep -o 'https://[^"]*')

    # Если URL для загрузки доступен
    if [ -n "$download_url" ]; then
        filename=$(basename "$download_url")
        extension="${filename##*.}"
        
        # Создание временной директории для загрузки файла
        mkdir -p "$tmp_dir"
        
        echo -e "  ${yellow}Выполняется загрузка${reset} последней версии xkeen"

        # Загрузка файла с использованием cURL и сохранение его во временной директории
        curl -L -o "/tmp/$filename" "$download_url" &> /dev/null

        # Если файл был успешно загружен
        if [ -e "/tmp/$filename" ]; then
            mv "/tmp/$filename" "$tmp_dir/xkeen.$extension"
			echo -e "  Xkeen ${green}успешно загружен${reset}"
        fi
    else
        echo -e "  ${red}Ошибка${reset}: Не удалось получить URL для загрузки xkeen"
    fi
}
