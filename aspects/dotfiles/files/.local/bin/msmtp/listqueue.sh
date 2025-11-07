#!/usr/bin/env sh

QUEUEDIR=$HOME/.config/msmtp/msmtp.queue/

for i in $QUEUEDIR/*.mail; do
	grep -E -s --colour -h '(^From:|^To:|^Subject:)' "$i" || echo "No mail in queue";
	echo " "
done
