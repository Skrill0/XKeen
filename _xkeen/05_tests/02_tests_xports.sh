# Функция для вывода прослушиваемых портов для указанного приложения
tests_ports_xray() {
    local app_name="xray"
    local listening_ports

    listening_ports=$(netstat -tuln | grep LISTEN | grep "$app_name")

    if [ -n "$listening_ports" ]; then
        echo "Порты, на которых слушает $app_name:"
        echo "$listening_ports"
		break
    else
        echo "$app_name не слушает на каких-либо портах."
		break
    fi
}