#!/bin/bash

logs="/var/log/system_health.log"
max_cpu=80
max_mem=90
max_disk=80
DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "--- Health Check Started at $DATE ---" >> $logs

check_cpu() {
  CPU_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
  remove_decimal=${CPU_usage%.*}
  echo "CPU Usage: ${remove_decimal}%" >> $logs

  if [ "$remove_decimal" -gt "$max_cpu" ]; then
    echo "WARNING: High CPU usage: ${remove_decimal}%" >> $logs
  fi
}

check_mem() {
  memory_used=$(free | awk '/Mem/{printf("%.0f"), $3/$2*100}')
  echo "Memory Usage: ${memory_used}%" >> $logs

  if [ "$memory_used" -gt "$max_mem" ]; then
    echo "WARNING: High Memory usage: ${memory_used}%" >> $logs
  fi
}

check_disk() {
  DISK_usage=$(df -h / | awk 'NR==2 {gsub("%",""); print $5}')
  echo "Disk Usage: ${DISK_usage}%" >> $logs

  if [ "$DISK_usage" -gt "$max_disk" ]; then
    echo "WARNING: Disk usage above threshold: ${DISK_usage}%" >> $logs
  fi
}

check_network() {
  ping -c 2 google.com  > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    # Fix: Use correct log variable ($logs)
    echo "Network: OK" >> $logs
  else
    echo "CRITICAL: Network DOWN" >> $logs
  fi
}

check_process() {
  SERVICE="ssh"
  if systemctl is-active --quiet $SERVICE; then
    echo "$SERVICE: Running" >> $logs
  else
    echo "$SERVICE: Not running — Restarting..." >> $logs
    sudo systemctl start $SERVICE
    sudo  status ssh
 fi
}

main() {
  check_cpu
  check_mem
  check_disk
  check_network
  check_process
  echo "===== Health Check Completed =====" >> $logs
  echo "" >> $logs
}


main
