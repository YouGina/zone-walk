#!/bin/bash
zone=$1

ns=$(dig +short ns $zone | head -n1)
echo $ns
current=$zone
while : ; do
        output=$(dig +dnssec nsec $current @"${ns}" | grep "IN\sNSEC.*\..*" | awk '{print $5}')
        echo $output
        [[ $output != "${zone}." ]] || break
        current=$output
done
