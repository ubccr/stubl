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
gid="`ldapsearch -x \(\&\(cn=\"${group}\"\)\(ou:dn:=groups\)\) | egrep ^gidNumber: | awk '{print $NF}'`"
if [ "${gid}" = "" ]
then
  echo "no such group \"${group}\"" >&2
  exit 1
fi
( ldapsearch -x gidNumber=${gid} | grep ^uid: | awk -F[:\ ] '{print $NF}'
  ldapsearch -x "(&(cn=${group})(ou:dn:=groups))" | grep ^memberUid: | awk '{print $NF}' ) | sort | uniq
