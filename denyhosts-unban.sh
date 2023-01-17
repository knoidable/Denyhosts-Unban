#!/bin/bash
# denyhosts-unban
# Remove a specific IP from denyhosts files
# Copyright (c) 2013 Sam Powis
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see https://www.gnu.org/licenses/gpl-3.0.html
#
# @name denyhosts-unban.sh
# @version 2013-01-22
# @summary setup
# @params {string} <ip.address.to.remove>

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
