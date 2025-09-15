#!/bin/sh
set -eo pipefail
set -x

rm -f "$LOGS_PATH/Retroarch.txt"
exec >>"$LOGS_PATH/Retroarch.txt"
exec 2>&1

echo "$0" "$@"

PAK_DIR="$(dirname "$0")"
USERDATA_DIR="$USERDATA_PATH/retroarch"
PACK_DIR="$SDCARD_PATH/Emus/$PLATFORM/Retroarch.pak"

mkdir -p "$USERDATA_DIR"

export LD_LIBRARY_PATH="$PAK_DIR/resources/lib:/usr/trimui/lib:$PACK_DIR/lib:$LD_LIBRARY_PATH"

cleanup() {
    rm -f /tmp/stay_awake

    if [ -f "$USERDATA_DIR/cpu_governor.txt" ]; then
        cat "$USERDATA_DIR/cpu_governor.txt" >/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        rm -f "$USERDATA_DIR/cpu_governor.txt"
    fi
    if [ -f "$USERDATA_DIR/cpu_min_freq.txt" ]; then
        cat "$USERDATA_DIR/cpu_min_freq.txt" >/sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
        rm -f "$USERDATA_DIR/cpu_min_freq.txt"
    fi
    if [ -f "$USERDATA_DIR/cpu_max_freq.txt" ]; then
        cat "$USERDATA_DIR/cpu_max_freq.txt" >/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
        rm -f "$USERDATA_DIR/cpu_max_freq.txt"
    fi

}

main() {
    echo "1" >/tmp/stay_awake
    trap "cleanup" EXIT INT TERM HUP QUIT

    cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor >"$USERDATA_DIR/cpu_governor.txt"
    cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq >"$USERDATA_DIR/cpu_min_freq.txt"
    cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq >"$USERDATA_DIR/cpu_max_freq.txt"
    echo performance >/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    echo 1608000 >/sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
    echo 1800000 >/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq

    cd "$PAK_DIR" || exit 1

    minui-power-control retroarch &

    ./retroarch -c retroarch.cfg --menu -v "$@"
}

main "$@"