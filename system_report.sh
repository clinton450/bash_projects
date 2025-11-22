#!/bin/bash

echo "system reporting........."
date
echo ""

echo "====== uptime ========"
uptime
echo ""

echo "========Currently Connected ======"
w
echo ""

echo "--- Last Logins ---"
last -a | head -3
echo ""

echo "======= Disk & Memory ======="

df -h / | awk 'NR==2 {print "Disk Used: " $5 " (Free: " $4 ")"}'
free -m | awk 'NR==2 {print "Memory Free: " $4 "MB / Total: " $2 "MB"}'
echo ""

echo "--- OOM (Out of Memory) Checks ---"

if [ -f /var/log/syslog ]; then
    start_log=$(head -1 /var/log/syslog | cut -c 1-15)
    oom_count=$(grep -ci "kill" /var/log/syslog)
    echo "OOM errors since $start_log: $oom_count"
else
    echo "Log file not found (Requires Sudo?)"
fi
echo ""

echo "--- Top Processes ---"
top -b -n 1 | head -12 | tail -5
echo ""

echo "======Open Ports ======"

if command -v nmap >/dev/null; then
    nmap -T4 127.0.0.1
else
    echo "Nmap not installed."
fi
echo ""

echo "--- Connection Summary ---"
ss -s
echo ""

echo "--- Virtual Memory Stats ---"
vmstat 1 5
echo "  "

echo "Report completed "
