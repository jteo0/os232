#!/bin/bash
# 21:B274C337
# REV05: Mon 11 Sep 2023 19:00
# REV04: Sun 02 Apr 2023 19:00
# REV03: Sun 19 Feb 2023 04:00
# REV02: Wed 14 Sep 2022 12:00
# REV01: Mon 12 Sep 2022 09:00
# START: Sat 06 Nov 2021 11:00

SEQ="00"
INCLUDE="./98-include.sh"
[ -f $INCLUDE     ] && . $INCLUDE || { echo "$INCLUDE not found"; exit; }
[ -d ../WEEK$WEEK ] || mkdir -pv ../WEEK$WEEK
# ZCZC START #### #### #### ####
FILE="$WEEKDIR/WEEK$WEEK-$SEQ-BASIC.txt"
STAMP=$(stamp)
[ -f $FILE      ] && /bin/rm -f $FILE
[ -d $WEEKDIR/  ] || mkdir -pv $WEEKDIR/
fecho WEEKSQ    $WEEK $SEQ
fecho VERSUM    $(versum $0)
fecho VERINC    $(versum $INCLUDE)
fecho SCRIPT    $(head -3 $0 | tail -1)
fecho XCHECK    $(xcheck)
fecho VERDSK    $(verdisk)
# fecho CMOUNT    $(cat /proc/mounts | grep lfs)
fecho VERLNX    $(verkernel)
fecho RESULT    ===== RESULT IN $FILE =====
fecho CHDIR1    $(IsDir "RESULT")
fecho CHDIR2    $(IsDir "mydemo")
fecho CHDIR3    $(IsDir "mywork")
fecho CHDIR4    $(IsDir "git/os232/TXT")
fecho CHDIR5    $(IsDir "git/os")

exit 0

