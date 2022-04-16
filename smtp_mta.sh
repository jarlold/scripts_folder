#!/usr/bin/bash

if [ $1 == "--help" ] || [ $1 == "-h" ]; then
  echo "Script to generate a fake e-mail, and send it to an SMTP server"
  echo "You'll have to do you own MX lookup to find the mail server for"
  echo "the domain of the reciever. If no message is supplied, the message"
  echo "will be read from standard input."
  echo "[USAGE] smtp_fake_mta.sh destination_server port from_addr to_addr subject message"
  echo "[EXAMPLE] smtp_fake_mta.sh mail.jarlold.net 25 sender@test.com reciever@test.com"
  exit
fi

mail_server=$1
port=$2

FROM=$3
TO=$4

Subject=$5


if [ -n "$6" ]; then
  message=$6
else
  message=$(cat)

fi


packet1="HELO $mail_server\r\n"
packet2="MAIL FROM: $FROM\r\n"
packet3="RCPT TO: $TO\r\n"
packet4="DATA\r\n"
packet5="From: $FROM\r\n"
packet6="To: $TO\r\n"
packet7="Subject: $Subject\r\n"
packet8="$message\r\n"
packet9="\r\n.\r\n"

# Open the socket
exec 3<>/dev/tcp/$mail_server/$port


timeout 1 cat <&3

printf "$packet1" >&3
timeout 1 cat <&3

printf "$packet2" >&3
timeout 1 cat <&3

printf "$packet3" >&3
timeout 1 cat <&3

printf "$packet4" >&3
timeout 1 cat <&3

printf "$packet5" >&3
printf "$packet6" >&3
printf "$packet7" >&3
#printf "Content-Type: text/html;\r\n" >&3
printf "\r\n$packet8" >&3
printf "$packet9" >&3

timeout 1 cat <&3


