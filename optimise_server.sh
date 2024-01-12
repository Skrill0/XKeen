#!/bin/sh

set_param() {
    echo "$1" >> /etc/sysctl.conf > /dev/null 2>&1
}

if ! sysctl net.ipv4.tcp_available_congestion_control | grep -q 'bbr'; then
    echo "tcp_bbr" > /etc/modules-load.d/modules.conf 2>/dev/null
fi

set_param "net.core.default_qdisc=fq"
set_param "net.ipv4.tcp_congestion_control=bbr"
set_param "net.core.rmem_max = 67108864"
set_param "net.core.wmem_max = 67108864"
set_param "net.core.netdev_max_backlog = 10000"
set_param "net.core.somaxconn = 4096"
set_param "net.ipv4.tcp_syncookies = 1"
set_param "net.ipv4.tcp_tw_reuse = 1"
set_param "net.ipv4.tcp_fin_timeout = 30"
set_param "net.ipv4.tcp_keepalive_time = 1200"
set_param "net.ipv4.tcp_keepalive_probes = 5"
set_param "net.ipv4.tcp_keepalive_intvl = 30"
set_param "net.ipv4.tcp_max_syn_backlog = 8192"
set_param "net.ipv4.tcp_max_tw_buckets = 5000"
set_param "net.ipv4.tcp_fastopen = 3"
set_param "net.ipv4.tcp_mem = 25600 51200 102400"
set_param "net.ipv4.udp_mem = 25600 51200 102400"
set_param "net.ipv4.tcp_rmem = 4096 87380 67108864"
set_param "net.ipv4.tcp_wmem = 4096 65536 67108864"
set_param "net.ipv4.tcp_mtu_probing = 1"
set_param "net.ipv4.tcp_slow_start_after_idle=0"

sysctl -p > /dev/null 2>&1

echo "  Оптимизация сервера \\033[32mвыполнена\\033[0m"
echo "  Рекомендуется перезагрузить сервер командой «reboot»"


rm -- "$0"
