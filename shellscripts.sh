#!/bin/sh
# Script to Clean the log older than 45 days.
#
#set smtp=smtp://smtp3.xuc.xdeus.net

SUBJECT=$1
RECEIVER=$2
PWD=$(pwd)

HOSTNAME=$HOSTNAME
SENDER=$(whoami)

[[ -z $1 ]] && SUBJECT="Notification from $HOSTNAME"
[[ -z $2 ]] && RECEIVER="kyung.lee@xxx.com"
TEXT="$PWD was cleaned for logs older than 45 days."


find . -mtime +45 | grep "2017-10-01_BILLING_AGGREGATION_LOG" | xargs rm -rf {};

echo -e $TEXT | mailx -s "$SUBJECT" -S smtp=smtp://smtp3.xuc.xdeus.net $RECEIVER
exit $?




/////////////////////////////

#!/bin/sh
# Script to check tomcat server status and restarts if something wrong
export LD_LIBRARY_PATH=/home/pcchrist/openssl/lib
export CATALINA_HOME=/opttt/tomcat/tomcat

SUBJECT=$1
RECEIVER=$2
#PWD=$(pwd)

HOSTNAME=$HOSTNAME
SENDER=$(whoami)

[[ -z $1 ]] && SUBJECT="Notification from $HOSTNAME"
[[ -z $2 ]] && RECEIVER="kyung.lee@xxx.com"
TEXT="tomcat is restarting."


#webserv="https://localhost:8443/public/"
rep=$(/home/pcchrist/curl/bin/curl -k "https://localhost:8443/public/")
repok=$(echo "$rep" | grep OK)
#echo $repok

if [ -n "$repok" ]; then
  #echo "OK!"
  #PS_OUTPUT=`cat $CATALINA_HOME/work/catalina.pid`
  #echo $PS_OUTPUT
else
  #echo "NOK!"
  #PS_OUTPUT=`ps -ef | grep tomcat | grep -Ev 'root|grep' | awk '{print $2}'`
  #PS_OUTPUT=`cat $CATALINA_HOME/work/catalina.pid`
  #echo $PS_OUTPUT
  echo -e $TEXT | mailx -s "$SUBJECT" -S smtp=smtp://smtp3.xuc.adeus.net $RECEIVER
  `/etc/init.d/tomcat/restart`
fi
