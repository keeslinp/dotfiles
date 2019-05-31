#!/bin/bash
server_name=$(basename `PWD`)
socket_file=$(kak -l | grep $server_name)

if [[ $socket_file == "" ]]; then        
    # Create new kakoune daemon for current dir
    kak -d -s $server_name
fi

# and run kakoune (with any arguments passed to the script)
kak -c $server_name $@
