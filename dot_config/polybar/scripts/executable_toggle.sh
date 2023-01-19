#!/bin/bash

if mpc status | awk 'NR==2' | grep playing >/dev/null
then
    echo "" 
fi
    echo ""
 
