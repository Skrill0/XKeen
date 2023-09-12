# Загрузка Xray

download_xray() {
    # Получение URL для загрузки последней версии Xray с помощью cURL и jq
    download_url=$(curl -s "$xray_api_url" | jq -r --arg arch "$architecture" '.assets[] | select(.name | endswith("linux-"+$arch + ".zip")) | .browser_download_url')

    # Если URL для загрузки доступен
    if [ -n "$download_url" ]; then
        filename=$(basename "$download_url")
        extension="${filename##*.}"
        
        # Создание временной директории для загрузки файла
        mkdir -p "$tmp_dir"
        
        echo -e "  ${yellow}Выполняется загрузка${reset} последней версии Xray"

        # Загрузка файла с использованием cURL и сохранение его во временной директории
        curl -L -o "$tmp_dir/$filename" "$download_url" &> /dev/null

        # Если файл был успешно загружен
        if [ -e "$tmp_dir/$filename" ]; then
            mv "$tmp_dir/$filename" "$tmp_dir/xray.$extension"
			echo -e "  Xray ${green}успешно загружен${reset}"
        else
            echo -e "  ${red}Ошибка${reset} при загрузке файла"
        fi
    else
        echo -e "  ${red}Ошибка${reset}: Не удалось получить URL для загрузки Xray"
    fi
}
