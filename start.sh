#!/bin/bash

name=$2
feedurl=$1
unread=0

while :
do
	newsboat -x reload
	new_unread=$(sqlite3 $HOME/.newsboat/cache.db "
select count(*)
from rss_item
where unread = 1
and feedurl = '$feedurl';
")

	if [ "$unread" != "$new_unread" ]
	then
		curl -d $name ntfy.sh/mytopic &>/dev/null &
		unread="$new_unread"
	fi
	sleep 30m
done
