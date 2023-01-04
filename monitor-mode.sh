#!/bin/bash

# Check if the wireless interface was specified
if [ -z "$1" ]
then
  echo "Error: No wireless interface specified."
  exit 1
fi

# Set the wireless interface
wireless_interface=$1

# Check if the wireless interface is up
ifconfig $wireless_interface | grep "UP" > /dev/null
if [ $? -ne 0 ]
then
  echo "Error: Wireless interface is not up."
  exit 1
fi

# Check if the wireless interface is in monitor mode
iwconfig $wireless_interface | grep "Mode:Monitor" > /dev/null
if [ $? -eq 0 ]
then
  echo "Wireless interface is already in monitor mode."
  exit 0
fi

# Put the wireless interface into monitor mode
echo "Putting wireless interface into monitor mode..."
airmon-ng start $wireless_interface

echo "Done."
