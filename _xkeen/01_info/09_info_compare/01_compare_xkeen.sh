#!/bin/sh

# Функция для сравнения версий Xkeen
info_compare_xkeen() {
    # Сравнение версий и сохранение результата в переменной
    if [ "$XKEEN_CURRENT_VERSION" = "$XKEEN_GITHUB_VERSION" ]; then
        INFO_COMPARE_XKEEN="actual"
    elif [ "$XKEEN_CURRENT_VERSION" \< "$XKEEN_GITHUB_VERSION" ]; then
        INFO_COMPARE_XKEEN="update"
    else
        INFO_COMPARE_XKEEN="not_release"
    fi
}
