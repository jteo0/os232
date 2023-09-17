#!/bin/bash
# 45:77105089
# REV30: Mon 11 Sep 2023 18:00
# REV29: Sat 13 May 2023 15:00
# REV19: Sun 26 Feb 2023 15:00
# REV09: Sun 19 Feb 2023 00:00
# REV01: Mon 12 Sep 2022 09:00
# START: Sun 20 Feb 2022 16:00

WEEK="02"
DATE0="11-Sep-2023"
LFSDIR="/mnt/lfs"
WEEKDIR="$HOME/RESULT/W$WEEK"
CPLIST=""
WHOAMI=$(whoami)
MYGROUP=$(id -gn)
MYHOST=$(hostname)
MYHOME=$(echo ~/)
error() {
  echo "ZCZC ERROR $@" | tee -a $FILE
  exit 1
}
hash4() {
  local tmpVAR=$(md5sum <<< "$@"|tr [a-f] [A-F])
  echo ${tmpVAR:0:4}
}
stamp() {
  local tmpVAR1=$(printf "%X" $((($(date +%s)-$(date --date="$DATE0" +%s))/86400%16)))
  local tmpVAR2=$(printf "%X" $((10#$(date +%H)*16/24)))
  local tmpVAR3=$(hash4 $RANDOM$RANDOM$RANDOM)
  local STAMP="${tmpVAR1: -1}$tmpVAR2${tmpVAR3:0:1}"
  echo $STAMP
}
fecho1() {
  echo ZCZC ${STAMP}$(hash4 "$STAMP$WHOAMI$@") $@
}
fecho() {
  fecho1 $@ | tee -a $FILE
}
verdisk() {
    local FSYS1="/"
    local FSYS2="/mnt/lfs/"
    local tmpVAR=$(df -h "$FSYS1"|tail -1|awk '{print $1}';)
    [ -d "$FSYS2" ] && tmpVAR="$tmpVAR $(df -h "$FSYS2" |tail -1|awk '{print $1}';)"
    df -h $tmpVAR|tail -2|awk '{print $2}';
    for II in $tmpVAR ; do
      ls -l /dev/disk/by-uuid/ | grep $(basename $II) | awk '{print $9}'|tr '[a-z]' '[A-Z]'|cut -d- -f5,5
    done
}
vermount() {
    cat /proc/mounts  | grep -E "/dev.+/mnt/lfs"
}
verkernel() {
    cat /proc/version | cut -d' ' -f3,3
}
versum() {
    CFILE=$1
    printf "%X:%s " $(tail -n +3 $CFILE|wc -l) $(tail -n +3 $CFILE|sha1sum|cut -c1-8|tr '[a-z]' '[A-Z]')
    head -2 $CFILE|tail -1|cut -c3-
}
reportDir() {
    [ -d $1 ] || { fecho "ERROR $1 not found"; return; }
    local tmpVAR="$(find $1 -type d|wc) $(find $1 -type f|wc) $(du -s $1)"
    fecho "$(echo $tmpVAR|awk '{print "CHKDIR", $8, $2, $3, $4, $6, $7}')"
}
IsDir() {
    [ -d $HOME/$1/ ] && echo $1 YES || echo $1 NO 
}
xcheck() {
    echo "HOST $MYHOST USER $WHOAMI GROUP $MYGROUP HOME $MYHOME ARCH $(arch) NPROC $(nproc)"
}
