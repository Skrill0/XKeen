# Функция для сравнения версий Xray и определения статуса
info_compare_xray() {
    # Проверяем, установлен ли Xray
    if [ -z "$xray_current_version" ]; then
        info_compare_xray="not_installed" # Если Xray не установлен, статус - не установлен
		
    else
        # Сравниваем текущую версию Xray с версией из GitHub
        if [ "$xray_current_version" = "$xray_github_version" ]; then
            info_compare_xray="actual" # Если версии совпадают, Xray актуален
			
        elif [ "$xray_current_version" \< "$xray_github_version" ]; then
            info_compare_xray="update" # Если текущая версия меньше версии из GitHub, требуется обновление
			
        else
            info_compare_xray="not_release" # Если версия из GitHub меньше текущей версии (не выпущена), Xray не выпущен
        fi
    fi
}
