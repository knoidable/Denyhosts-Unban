#!/bin/bash
#Remove a specific IP from denyhosts files
#By Sam Powis

#stop the service
/etc/init.d/denyhosts stop

#if the service stopped OK, make a temp directory and proceed
OUT=$?
if [ $OUT -eq 0 ] && [ -f /etc/denyhosts.conf ]
  then
	mkdir ~/hosts

#get denyhosts working dir, add trailing slash if not present
  WORKDIR=`grep "WORK_DIR =" /etc/denyhosts.conf |cut -f3 -d" "`
	[[ $WORKDIR != */ ]] && WORKDIR="$WORKDIR"/

#remove IP address from denyhosts files and output to temp dir
	sed -e '/'"$1"'/d' "$WORKDIR"/hosts > ~/hosts/hosts
	sed -e '/'"$1"'/d' "$WORKDIR"/hosts-restricted > ~/hosts/hosts-restricted
	sed -e '/'"$1"'/d' "$WORKDIR"/hosts-root > ~/hosts/hosts-root
	sed -e '/'"$1"'/d' "$WORKDIR"/hosts-valid > ~/hosts/hosts-valid
	sed -e '/'"$1"'/d' "$WORKDIR"/users-hosts > ~/hosts/users-hosts
	sed -e '/'"$1"'/d' /etc/hosts.deny >~/hosts/hosts.deny

#copy temp files into place
	cp ~/hosts/hosts $WORKDIR
	cp ~/hosts/hosts-* $WORKDIR
	cp ~/hosts/hosts.deny /etc/
	cp ~/hosts/users-hosts $WORKDIR

#remove temp files
	rm -rf ~/hosts

#restart denyhosts
	/etc/init.d/denyhosts start

fi
