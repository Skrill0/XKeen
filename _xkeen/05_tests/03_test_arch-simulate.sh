# Функция для вывода прослушиваемых портов для указанного приложения
tests_arch_aarch64() {
    echo "Architecture:            aarch64"
    echo "  CPU op-mode(s):        32-bit, 64-bit"
    echo "  Byte Order:            Little Endian"
    echo "CPU(s):                  2"
    echo "  On-line CPU(s) list:   0,1"
    echo "Vendor ID:               ARM"
    echo "  Model name:            Cortex-A53"
    echo "    Model:               4"
    echo "    Thread(s) per core:  1"
    echo "    Core(s) per cluster: 2"
    echo "    Socket(s):           -"
    echo "    Cluster(s):          1"
    echo "    Stepping:            r0p4"
    echo "    CPU(s) scaling MHz:  100%"
    echo "    CPU max MHz:         1350.0000"
    echo "    CPU min MHz:         300.0000"
    echo "    BogoMIPS:            25.00"
    echo "    Flags:               fp asimd evtstrm aes pmull sha1 sha2 crc32"
    echo "Caches (sum of all):"
    echo "  L1d:                   64 KiB (2 instances)"
    echo "  L1i:                   64 KiB (2 instances)"
    echo "  L2:                    512 KiB (1 instance)"
}

tests_arch_mips_1024kc() {
    echo "Architecture:          mips"
    echo "  Byte Order:          Little Endian"
    echo "CPU(s):                4"
    echo "  On-line CPU(s) list: 0-3"
    echo "Model name:            -"
    echo "  Model:               MIPS 1004Kc V2.15"
    echo "  Thread(s) per core:  2"
    echo "  Core(s) per socket:  2"
    echo "  Socket(s):           1"
    echo "  BogoMIPS:            583.68"
    echo "  Flags:               mips16 dsp mt"
}

tests_arch_mips_24kec() {
    echo "Architecture: mips"
    echo "  Byte Order: Little Endian"
    echo "CPU(s): 1"
    echo "  On-line CPU(s) list: 0"
    echo "Model name: -"
    echo "  Model: MIPS 24KEc V5.5"
    echo "  Thread(s) per core: 1"
    echo "  Core(s) per socket: 1"
    echo "  Socket(s): 1"
    echo "  BogoMIPS: 385.02"
    echo "  Flags: mips16 dsp"
}

# Проверка модели и архитектуры процессора для тестов
info_cpu_test() {
    info_model_raw=$(tests_arch_mips_1024kc | awk '/Model name:/ { sub(/^Model name:\s*/, ""); print }' | tr '[:upper:]' '[:lower:]' | tr ' ' '_')  # Получаем информацию об архитектуре и модели процессора из тестовых данных и приводим ее к нужному формату
    info_model_raw2=$(tests_arch_mips_1024kc | awk '/Model:/ { sub(/^Model:\s*/, ""); print }' | tr '[:upper:]' '[:lower:]' | tr ' ' '_')  # Получаем информацию о модели процессора из тестовых данных и приводим ее к нужному формату

    # Проверяем "Model name" на соответствие наборам инструкций
    if [[ "$info_model_raw" == *"mips1004"* || "$info_model_raw" == *"mips_1004"* ]]; then
        architecture="mipsel_24kc"
    elif [[ "$info_model_raw" == *"mips34"* || "$info_model_raw" == *"mips_34"* ]]; then
        architecture="mipsel_74kc"
    elif [[ "$info_model_raw" == *"mips24"* || "$info_model_raw" == *"mips_24"* ]]; then
        architecture="mipsel_74kc"
    elif [[ "$info_model_raw" == *"cortex-a53"* || "$info_model_raw" == *"cortex_a53"* ]]; then
        architecture="cortex-a53"
    else
        # Если совпадений в "Model name" нет, проверяем "Model"
        if [[ "$info_model_raw2" == *"mips1004"* || "$info_model_raw2" == *"mips_1004"* ]]; then
            architecture="mipsel_24kc"
        elif [[ "$info_model_raw2" == *"mips34"* || "$info_model_raw2" == *"mips_34"* ]]; then
            architecture="mipsel_74kc"
        elif [[ "$info_model_raw2" == *"mips24"* || "$info_model_raw2" == *"mips_24"* ]]; then
            architecture="mipsel_74kc"
        elif [[ "$info_model_raw2" == *"cortex-a53"* || "$info_model_raw2" == *"cortex_a53"* ]]; then
            architecture="cortex-a53"
        fi

        if [ "$architecture" == "" ]; then
            echo "[error] Не удалось сгенерировать ключевое слово для архитектуры и модели процессора." >> "$xkeen_error_log"
        fi
    fi

    # Получаем существующее содержимое файла статуса
    existing_content=$(cat "$status_file")
    
    # Получаем архитектуру из файла статуса, если она уже существует
    status_architecture=$(echo "$existing_content" | grep -e "^Architecture:" | awk '{print $2}' | head -n 1)
}

