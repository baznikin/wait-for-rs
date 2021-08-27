#!/bin/bash

# Usage:
#  timeout 30 ./wait-for-rs.sh <kubectl selector here>

env jq -n . >/dev/null 2>&1 || ( echo "jq required! please install it" && exit 1 )
env kubectl version . >/dev/null 2>&1 || ( echo "kubectl required! please install it" && exit 1 )

while true; do
  STATUS=`kubectl -o json get "$@" | jq '.status.conditions[] | select(.type == "Progressing").message '`
  echo ${STATUS} | grep "has timed out progressing" && exit 1
  echo ${STATUS} | grep "has successfully progressed" && exit 0
  sleep 1
done
