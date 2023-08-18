#!/bin/sh

# in  System \ Preferences \ Preferred Applications \ mail
# set to: $META_HOME/bin/open_mailto.sh %s

$BROWSER https://mail.google.com/mail?view=cm&tf=0&to=`echo $1 | sed ‘s/mailto://’`
