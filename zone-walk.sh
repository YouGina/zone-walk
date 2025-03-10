#!/bin/bash
zone=$1

ns=$(dig +short ns $zone | head -n1)
current=$zone
while : ; do
        output=$(dig +dnssec nsec $current @"${ns}" | grep "IN\sNSEC.*\..*" | awk '{print $5}')
        if [[ "$output" == "${zone}." || "$output" == *$'\\000'* ]]; then
                if [[ "$output" == *$'\\000'* ]]; then
                echo "Not vulnerable, cannot enumerate"
                fi
                break;
        fi
        echo $output
        current=$output
done
