#!/bin/bash

for i in {2..254}
do
        {
        ip=192.168.100.$i
        ping -c2 -W1 $ip &>/dev/null

        if [ $? -eq 0 ]
        then
                echo "$ip" | tee -a ip_result_100_x.txt
        fi
        }&
done
wait
echo "Finished."
