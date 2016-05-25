#!/bin/bash

# helpers
function echo_task { echo -e '\033[1mTASK: '"$1"'\033[0m'; }
function echo_ok { echo -e '\033[33m'"$1"'\033[0m'; }
function echo_warn  { echo -e '\033[31mWARNING: '"$1"'\033[0m'; }

# checking .config/tools.brew
echo_task "Reading .config/tools.brew"
IFS=$'\n' read -d '' -r -a formulae < .config/tools.brew

if [[ ${formulae[@]} > 0 ]]
    then
        echo_ok "${#formulae[@]} formulae to install"
        for i in "${formulae[@]}"
        do
            echo
        	echo_task "Install $i"
        	brew install $i
        	echo_ok "Done brewing $i"
        done
    else
        echo_warn "No formulae selected"
fi
