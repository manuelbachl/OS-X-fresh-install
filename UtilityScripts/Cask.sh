#!/bin/bash

# helpers
function echo_task { echo -e '\033[1mTASK: '"$1"'\033[0m'; }
function echo_ok { echo -e '\033[33m'"$1"'\033[0m'; }
function echo_warn  { echo -e '\033[31mWARNING: '"$1"'\033[0m'; }

function install {
    if [[ $1 == 'fonts' ]]
        then
            # checking .config/fonts.cask
            echo_task "Reading .config/fonts.cask"
            IFS=$'\n' read -d '' -r -a casks < .config/fonts.cask
        else
            # checking .config/apps.cask
            echo_task "Reading .config/apps.cask"
            IFS=$'\n' read -d '' -r -a casks < .config/apps.cask
    fi
    if [[ ${casks[@]} > 0 ]]
        then
            echo_ok "${#casks[@]} $1 to install"
            for i in "${casks[@]}"
            do
                echo
                echo_task "Install $i"
                brew cask install $i
                echo_ok "Done brewing cask $i"
            done
        else
            echo_warn "No $1 selected"
    fi
}

if [ $# -eq 0 ]
    then
        echo "Parameter missing"
    else
        while getopts ":f" opt; do
            case $opt in
                f)
                    install fonts
                    ;;
                \?)

                    ;;
            esac
        done
        while getopts ":a" opt; do
            case $opt in
                a)
                    install apps
                    ;;
                \?)

                    ;;
            esac
        done
fi


