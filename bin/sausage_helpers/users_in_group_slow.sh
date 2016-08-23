#!/bin/sh


CACHE_FILE=`pwd`/groups.cache
bBuildCache=`echo "$@" | grep '\--rebuild-cache' | wc -l`

if [ "$bBuildCache" != "0" ]; then
  TMP_CACHE_FILE=/tmp/groups.cache.$$
  rm -f $TMP_CACHE_FILE
  for i in `ls /user`; do 
    groups $i >> $TMP_CACHE_FILE
  done
  mv $TMP_CACHE_FILE $CACHE_FILE
  exit
fi

#
# list all the users in a given group
#
group="$1"
if [ "${group}" = "" ]
then
  echo "usage $0 group" >&2
  exit 1
fi
gid=`cut -d: -f2 $CACHE_FILE | grep $group`

if [ "${gid}" = "" ]
then
  echo "no such group \"${group}\"" >&2
  exit 1
fi

grep ":* $group " $CACHE_FILE | cut -d: -f1 | sort | uniq

