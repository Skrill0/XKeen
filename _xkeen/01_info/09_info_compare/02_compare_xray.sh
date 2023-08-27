#!/bin/sh

# Функция для сравнения версий Xray
info_compare_xray() {
    # Сравнение версий и сохранение результата в переменной
    if [ "$XRAY_CURRENT_VERSION" = "$XRAY_GITHUB_VERSION" ]; then
        INFO_COMPARE_XRAY="actual"
    elif [ "$XRAY_CURRENT_VERSION" \< "$XRAY_GITHUB_VERSION" ]; then
        INFO_COMPARE_XRAY="update"
    else
        INFO_COMPARE_XRAY="not_release"
    fi
}
