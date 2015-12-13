#!/tmp-vorcers/ash

BB=/tmp-vorcers/busybox
RUNPARTS=/tmp-vorcers/run-parts
MOUNTS=/mounts
INIT_D=/system/etc/init.d

export PATH=/sbin:/system/sbin:/system/bin:/system/xbin:$PATH


message()
{
	log -p i -t "vorcers-kernel-pre-run-parts" "INFO: $1"
}
message "Init vorcers-kernel extras..."

#$BB echo > $ERRORS
#message "Vorcers' log"
#message "-------`$BB date`-----------------------\n" 
#message "-------pwd: `$BB pwd`"
#message "-------mount:"
#$BB mount >> $ERRORS
#message "------df:"
#$BB df >> $ERRORS
#message "\n"

#create tmpfs for mounts
message "Create tmpfs for mounts..."
message "$BB mount -o remount rw /"
$BB mount -o remount,rw /
message "$BB mkdir $MOUNTS"
$BB mkdir $MOUNTS
message "$BB chmod 777 $MOUNTS"
$BB chmod 777 $MOUNTS
message "$BB mount -t tmpfs tmpfs $MOUNTS -o mode=0777,uid=0,gid=0"
$BB mount -t tmpfs tmpfs $MOUNTS -o mode=0777,uid=0,gid=0

message "--init.d--"

#check if there is any /system/etc/init.d
if [ -d $INIT_D ]
then
	message "$INIT_D found do run parts via: /system/bin/logwrapper $RUNPARTS $INIT_D"
	logwrapper $RUNPARTS $INIT_D

else
	message "$INIT_D _not_ found"
fi
 
#sorry I need to remount / rw ... someone could have remounted it ro.

message "$BB mount -o remount rw /"
$BB mount -o remount,rw /

message "The great FINAL: Delete myself, LOL! WTF!?"
message "$BB rm -r /tmp-vorcers"
$BB rm -r /tmp-vorcers
#no $BB at the end ???  WTF?!? ---> this should work.
toolbox sleep 5 && toolbox mount -o remount,ro 

