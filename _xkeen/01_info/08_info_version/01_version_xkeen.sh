# Функция для получения версии из xkeen API и сохранения ее в переменной
info_version_xkeen() {
    # Используем curl для получения данных с xkeen API, затем используем jq для извлечения версии и удаления префикса "v"
    version=$(curl -s "$xkeen_api_url" | jq -r '.name' | sed 's/v//')
    
    # Присваиваем полученную версию переменной xkeen_github_version
    xkeen_github_version="$version"
}