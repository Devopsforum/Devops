#!/bin/bash

# The service we want to check (according to systemctl)
SERVICE=apache2.service
# Where to send the restart mail to
MAILBOX=<your@mail.com>

if [ "`systemctl is-active $SERVICE`" != "active" ] 
	echo "mail" | sendmail -t $MAILBOX 
then 
	echo "$SERVICE wasnt running so attempting restart"
	systemctl restart $SERVICE
	echo "Mailing $MAILBOX with current status"
	echo "mailing" | sendmail -f <your@mail.com>
	systemctl status $SERVICE | sendmail -s "$SERVICE was restarted" $MAILBOX
	exit 0
fi 
echo "$SERVICE is currently running"
exit 0
