info_cpu() {

	# Попробуем получить архитектуру из uname
    case "$(uname -m)" in
        'armv5tel')
            architecture='arm32-v5'
            ;;
        'armv6l')
            architecture='arm32-v6'
            if grep Features /proc/cpuinfo | grep -qw 'vfp'; then
                architecture='arm32-v5'
            fi
            ;;
        'armv7' | 'armv7l')
            architecture='arm32-v7a'
            if grep Features /proc/cpuinfo | grep -qw 'vfp'; then
                architecture='arm32-v5'
            fi
            ;;
        'armv8' | 'aarch64' | 'ARMv8')
            architecture='arm64-v8a'
            ;;
        'mips')
            architecture='mips32'
            ;;
        'mipsle')
            architecture='mips32le'
            ;;
        'mips64' | 'MIPS64')
            architecture='mips64'
            ;;
        'mips64le' | 'MIPS64LE')
            architecture='mips64le'
            ;;
        *)
		
            # Если архитектура не определена через uname, используем резервную проверку /proc/cpuinfo
            local cpuinfo=$(grep -i 'model name' /proc/cpuinfo | sed -e 's/.*: //i' | tr '[:upper:]' '[:lower:]')

            if echo "$cpuinfo" | grep -q -e 'armv8' -e 'aarch64' -e 'cortex-a'; then
                architecture='arm64-v8a'
            elif echo "$cpuinfo" | grep -q -e 'mips64le'; then
                architecture='mips64le'
            elif echo "$cpuinfo" | grep -q -e 'mips64'; then
                architecture='mips64'
            elif echo "$cpuinfo" | grep -q -e 'mipsle'; then
                architecture='mips32le'
            elif echo "$cpuinfo" | grep -q -e 'mips'; then
                architecture='mips32'
            else
			
                # Если архитектура не определена через /proc/cpuinfo, используем резервную проверку lscpu
                if [ "$info_packages_lscpu" = "not_installed" ]; then
                    opkg install lscpu &>/dev/null
                fi

                local lscpu_output="$(lscpu 2>/dev/null)"
                if echo "$lscpu_output" | grep -q -e 'armv8' -e 'aarch64' -e 'cortex-a'; then
                    architecture='arm64-v8a'
                elif echo "$lscpu_output" | grep -q -e 'mips64le'; then
                    architecture='mips64le'
                elif echo "$lscpu_output" | grep -q -e 'mips64'; then
                    architecture='mips64'
                elif echo "$lscpu_output" | grep -q -e 'mipsle'; then
                    architecture='mips32le'
                elif echo "$lscpu_output" | grep -q -e 'mips'; then
                    architecture='mips32'
                else
                    # Если ничего не подошло, устанавливаем значение по умолчанию
                    architecture=''
                fi
            fi
            ;;
    esac

    # Проверяем Little Endian с помощью lscpu только при архитектуре "mips64"
    if [ "$architecture" = 'mips64' ] || [ "$architecture" = 'MIPS64' ]; then
        if [ "$info_packages_lscpu" = "not_installed" ]; then
            opkg install lscpu &>/dev/null
        fi

        local lscpu_output="$(lscpu 2>/dev/null)"
        if echo "$lscpu_output" | grep -q "Little Endian"; then
            architecture='mips64le'
        else
            architecture='mips64'
        fi
    fi
	
	# Получаем существующее содержимое файла статуса
    existing_content=$(cat "$status_file")
    
    # Получаем архитектуру из файла статуса, если она уже существует
    status_architecture=$(echo "$existing_content" | grep -e "^Architecture:" | awk '{print $2}' | head -n 1)
}