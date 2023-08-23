#!/bin/sh

# Проверка модели и архитектуры процессора
info_cpu() {
    info_architecture=$(lscpu | awk '/Architecture:/ { print $2 }')
    info_model=$(lscpu | awk '/Model name:/ { sub(/^Model name:\s*/, ""); print }')

    generated_keyword=$(generate_keyword "$info_architecture" "$info_model")
}

export generated_keyword
export info_architecture
export info_model