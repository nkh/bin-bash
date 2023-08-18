#!/bin/bash

echo "*************** nc server *****************\n"

echo page: $1
printf "\n"

echo "Resources:"
vmstat -S M
printf "\n"

echo "Addresses:"
ifconfig
printf "\n"


