#!/bin/sh
#
# list all the users in a given group
#
group="$1"
if [ "${group}" = "" ]
then
  echo "usage $0 group" >&2
  exit 1
fi
gid=`getent group $group | cut -d: -f3`

if [ "${gid}" = "" ]
then
  echo "no such group \"${group}\"" >&2
  exit 1
fi

getent group $group | cut -d: -f4 | tr ',' '\n' | sort | uniq

