#!/bin/bash

echo "--- Simple Payroll System ---"

echo -n "Enter Employee Name: "
read name

echo -n "Hours Worked: "
read hours

echo -n "Hourly Rate: "
read rate

echo -n "Bonus Amount: "
read bonus
gross=$(echo "$hours * $rate + $bonus" | bc)

tax=$(echo "$gross * 0.15" | bc)

net=$(echo "$gross - $tax" | bc)

echo ""
echo "=========================="
echo "Payslip for: $name"
echo "Gross Pay:   $gross"
echo "Tax (15%):   $tax"
echo "--------------------------"
echo "Net Salary:  $net$"
echo "=========================="

if [ ! -f payroll.csv ]; then
    echo "Name,Net Pay,Date" > payroll.csv
fi

echo "$name,$net,$(date)" >> payroll.csv
echo "Saved to payroll.csv"

echo "{ \"name\": \"$name\", \"net_pay\": \"$net\", \"date\": \"$(date)\" }" > payroll.json
echo "Exported to payroll.json"
