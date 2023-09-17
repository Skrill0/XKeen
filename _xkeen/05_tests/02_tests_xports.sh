# Определение на каких портах слушает Xray
tests_ports_xray() {
    local app_name="xray"
    local listening_ports_tcp
    local listening_ports_udp
    local output="  Xray ${green}слушает${reset}"
    
    listening_ports_tcp=$(netstat -ltunp | grep LISTEN | grep "$app_name" | grep "tcp")
    listening_ports_udp=$(netstat -ltunp | grep LISTEN | grep "$app_name" | grep "udp")

    if [ -n "$listening_ports_tcp" ] || [ -n "$listening_ports_udp" ]; then
        local printed=false
        IFS=$'\n'
        for line in $listening_ports_tcp $listening_ports_udp; do
            gateway=$(echo "$line" | awk '{print $4}' | cut -d':' -f1)
            port=$(echo "$line" | awk '{print $4}' | cut -d':' -f2)
            protocol=""
            if [ -n "$(echo "$line" | grep "tcp")" ]; then
                protocol="TCP"
            fi
            if [ -n "$(echo "$line" | grep "udp")" ]; then
                if [ -n "$protocol" ]; then
                    protocol="${protocol} и UDP"
                else
                    protocol="UDP"
                fi
            fi
            if [ "$printed" = false ]; then
                echo -e "$output"
                printed=true
            fi
            echo -e "\n     ${dark_gray}Шлюз${reset} $gateway\n     ${dark_gray}Порт${reset} $port\n     ${dark_gray}Протокол${reset} $protocol"
        done
    else
        echo -e "  $app_name ${red}не слушает${reset} на каких-либо портах"
    fi
	
	break
}
