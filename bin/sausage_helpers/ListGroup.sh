#!/bin/bash

#Location of helper scripts
MYDIR=$STUBL_HOME/bin/sausage_helpers

group=$1

osver=`cat /etc/redhat-release | awk '{ print $(NF-1) }'`
if [ $osver == "6.6" ]; then
  USERS_IN_GROUP=$MYDIR/users_in_group_os6.6.sh
else
  USERS_IN_GROUP=$MYDIR/users_in_group.sh
fi

if [ "$group" == "" ]; then
  echo "Missing group name"
  echo "usage: ListGroup <group_name>"
  exit
fi

for usr in `$USERS_IN_GROUP ${group}`; do
  finger $usr | head -n1
done

