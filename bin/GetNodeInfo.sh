#!/bin/bash

# ===================================================
# GetNodeInfo.sh
#
#  A script for system administrators to determine
#  node information to be displayed as part of the 
#  slurmbf  output.
#
#  Retrieves information about disk and swap space
#  for each active node and stores in a log file.
#  The log file is accessed by the slurmbf command
#  and GetNodeInfo.sh only needs to be called if/when
#  the log file should be updated.
# ===================================================

# determine STUBL install location
# Copied from Apache Ant:
# https://git-wip-us.apache.org/repos/asf?p=ant.git;a=blob;f=src/script/ant;h=b5ed5be6a8fe3a08d26dea53ea0fb3f5fab45e3f
if [ -z "$STUBL_HOME" -o ! -d "$STUBL_HOME" ] ; then
  ## resolve links - $0 may be a link to stubl's home
  PRG="$0"
  progname=`basename "$0"`

  # need this for relative symlinks
  while [ -h "$PRG" ] ; do
    ls=`ls -ld "$PRG"`
    link=`expr "$ls" : '.*-> \(.*\)$'`
    if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
    else
    PRG=`dirname "$PRG"`"/$link"
    fi
  done

  STUBL_HOME=`dirname "$PRG"`/..

  # make it fully qualified
  STUBL_HOME=`cd "$STUBL_HOME" > /dev/null && pwd`
fi

# setup STUBL environment
. $STUBL_HOME/conf/stubl 

LOGFILE=$STUBL_HOME/log/NodeInfo.log

if [ "$1" == "" ]; then
  rm $LOGFILE
  echo "HOSTNAME   DISK(Kb)   SWAP(Kb)" | tee $LOGFILE 
  for i in `snodes | grep -v down | grep -v drain | sed '1d' | awk '{ print $1;}'`; do
    echo -n "$i" | tee -a $LOGFILE

    #determine disk space in /scratch
    (ssh $i "df $STUBL_SCRATCH_DIR")|tail -n1 | awk '{ printf("  %8d  ", $4);}' | tee -a $LOGFILE

    #determine swap space
    (ssh  $i "free") | tail -n1 | awk '{ print $2 }' | tee -a $LOGFILE
  done
else
  echo -n "$1" | tee -a $LOGFILE

  #determine disk space in /scratch
  (ssh $1 "df $STUBL_SCRATCH_DIR")|tail -n1 | awk '{ printf("  %8d  ", $4);}' | tee -a $LOGFILE

  #determine swap space
  (ssh  $1 "free") | tail -n1 | awk '{ print $2 }' | tee -a $LOGFILE
fi

