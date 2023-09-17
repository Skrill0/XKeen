info_cpu() {

    # Попробуем получить архитектуру из uname
    case "$(uname -m | tr '[:upper:]' '[:lower:]')" in
        *'armv5tel'*)
            architecture='arm32-v5'
            ;;
        *'armv6l'*)
            architecture='arm32-v6'
            if grep Features /proc/cpuinfo | grep -qw 'vfp'; then
                architecture='arm32-v5'
            fi
            ;;
        *'armv7'*)
            architecture='arm32-v7a'
            if grep Features /proc/cpuinfo | grep -qw 'vfp'; then
                architecture='arm32-v5'
            fi
            ;;
        *'armv8'* | *'aarch64'*)
            architecture='arm64-v8a'
            ;;
        *'mips64le'* | *'mips64'* )
            architecture='mips64'
            ;;
        *'mipsle'* | *'mips 1004'* | *'mips 34'* | *'mips 24'*)
            architecture='mips32le'
            ;;
        *'mips'*)
            architecture='mips32'
            ;;
        *)
            # Если архитектура не определена через uname, используем резервную проверку /proc/cpuinfo
            local cpuinfo=$(grep -i 'model name' /proc/cpuinfo | sed -e 's/.*: //i' | tr '[:upper:]' '[:lower:]')

            if echo "$cpuinfo" | grep -q -e *'armv8'* -e *'aarch64'* -e *'cortex-a'*; then
                architecture='arm64-v8a'
            elif echo "$cpuinfo" | grep -q -e *'mips64le'*; then
                architecture='mips64le'
            elif echo "$cpuinfo" | grep -q -e *'mips64'*; then
                architecture='mips64'
            elif echo "$cpuinfo" | grep -q -e *'mips32le'* -e *'mips 1004'* -e *'mips 34'* -e *'mips 24'*; then
                architecture='mips32le'
            elif echo "$cpuinfo" | grep -q -e *'mips'*; then
                architecture='mips32'
            fi
            ;;
    esac

    # Проверяем Little Endian с помощью lscpu только при архитектуре "mips64" или "mips32"
    if [ "$architecture" = 'mips64' ] || [ "$architecture" = 'mips32' ]; then
        if [ "$info_packages_lscpu" = "not_installed" ]; then
            opkg install lscpu &>/dev/null
        fi

        local lscpu_output="$(lscpu 2>/dev/null | tr '[:upper:]' '[:lower:]')"
        if echo "$lscpu_output" | grep -q "little endian"; then
            architecture="${architecture}le"
        fi
    fi

    # Получаем информацию о архитектуре из файла состояния (status_file)
    status_architecture=$(grep -m 1 '^Architecture:' "$status_file" | awk '{print $2}')
}
