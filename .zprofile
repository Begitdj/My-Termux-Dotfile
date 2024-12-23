#!/data/data/com.termux/files/usr/bin/env zsh

c1="\e[1;32m" # Green
c2="\e[39m"   # Wite
STOP="\e[0m"

LOGO="
  ;,           ,;
   ';,.-----.,;'
  ,'           ',
 /    ${c2}O     O${c1}    \\
|                 |
'-----------------'
"
printf "${c1}${LOGO}${STOP}"

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

# Fix loadavg
uptime | grep -Po "average: \K.+"| awk -F", " '{ print $1,$2,$3 }' > $tmp/loadavg

# get load averages
IFS=" " read LOAD1 LOAD5 LOAD15 <<<$(cat $tmp/loadavg)
# get free memory
IFS=" " read USED AVAIL TOTAL <<<$(free -htm | grep "Mem" | awk {'print $3,$7,$2'})
# get processes
PROCESS=$(ps -eo user=|sort|uniq -c | awk '{ print $2 " " $1 }')
PROCESS_ALL=$(echo "$PROCESS"| awk {'print $2'} | awk '{ SUM += $1} END { print SUM }')
PROCESS_ROOT=$(echo "su -c ${PROCESS}"| grep root | awk {'print $2'})
PROCESS_USER=$(echo "$PROCESS"| grep -v root | awk {'print $2'} | awk '{ SUM += $1} END { print SUM }')
# get processors
PROCESSOR_NAME=$(grep "model name" /proc/cpuinfo | cut -d ' ' -f3- | awk {'print $0'} | head -1)
PROCESSOR_COUNT=$(grep -ioP 'processor\t:' /proc/cpuinfo | wc -l)

if [[ -d /system/app/ && -d /system/priv-app ]]; then
    DISTRO="Android $(getprop ro.build.version.release)"
    MODEL="$(getprop ro.product.brand) $(getprop ro.product.model)"
fi

W="\e[0;39m"
G="\e[1;32m"
C="\e[1;36m"
BOLD='\033[1m'

echo -e "
${W}${BOLD}System Info:
$C  Distro    : $W$DISTRO
$C  Host      : $W$MODEL
$C  Kernel    : $W$(uname -sr)

$C  Uptime    : $W$(uptime -p)
$C  Load      : $G$LOAD1$W (1m), $G$LOAD5$W (5m), $G$LOAD15$W (15m)
$C  Processes : $G$PROCESS_USER$W (user), $G$PROCESS_ALL$W (total)

$C  CPU       : $W$PROCESSOR_NAME ($G$PROCESSOR_COUNT$W vCPU)
$C  Memory    : $G$USED$W used, $G$AVAIL$W avail, $G$TOTAL$W total$W"

# config
max_usage=90
alert_usage=75
bar_width=50
# colors
green="\e[1;32m"
red="\e[1;31m"
yellow="\e[1;33m"
BOLD='\033[1m'
NC='\033[0m'

# disk usage: ignore zfs, squashfs & tmpfs
# readarray -t dfs < <(df -H -t sdcardfs -t fuse -t fuse.rclone | tail -n+2)
dfs=("${(@f)$(df -H -t sdcardfs -t fuse -t fuse.rclone | tail -n+2)}")
printf "\n${BOLD}Disk Usage:${NC}\n"

for line in "${dfs[@]}"; do
    # get disk usage
    usage=$(echo "$line" | awk '{print $5}' | sed 's/%//')
    used_width=$((($usage*$bar_width)/100))
    # color is green if usage < max_usage, else red
    if [ "${usage}" -ge "${alert_usage}" ]; then
        color=$yellow
    elif [ "${usage}" -ge "${max_usage}" ]; then
        color=$red
    else
        color=$green
    fi
    # print green/red bar until used_width
    bar="${color}\uee03"
    for ((i=0; i<$used_width; i++)); do
        bar+="\uee04"
    done
    # print dimmmed bar until end
    bar+="${color}"
    for ((i=$used_width; i<$bar_width; i++)); do
        bar+="\uee01"
    done

    # print empty end if usage < max_usage, else filled
    if [ "${usage}" -ge "${max_usage}" ]; then
        bar+="${color}\uee05"
    else
        bar+="${color}\uee02"
    fi

    # escape color
    bar+="${NC}"

    # print usage line & bar
    echo "${line}" | awk '{ printf("%-31s%+3s used out of %+4s\n", $6, $3, $2); }' | sed -e 's/^/  /'
    echo -e "${bar}" | sed -e 's/^/  /'
done
