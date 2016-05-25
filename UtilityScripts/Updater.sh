#!/bin/bash

# helpers
function echo_task { echo -e '\033[1mTASK: '"$1"'\033[0m'; }
function echo_ok { echo -e '\033[33m'"$1"'\033[0m'; }
function echo_warn  { echo -e '\033[31mWARNING: '"$1"'\033[0m'; }

function runUpdates {
    case "$1" in
        'homebrew')
            echo "/// Homebrew"
            echo_task "Updating formulae"
            brew update
            echo_ok "Formulae updated"
            echo_task "Removing temporary files"
            brew cleanup
            echo_ok "Cleanup done"
            ;;
        'caskapps')
            echo "/// Cask"
            echo_task "Updating apps"
            brew cask update
            echo_ok "Cask apps updated"
            echo_task "Removing temporary files"
            brew cask cleanup
            echo_ok "Cleanup done"
            ;;
        'zshplugins')
            echo "/// oh-my-zsh "
            echo_task "Updating plugins"
            source $HOME/.zplug/zplug
            zplug update
            echo_ok "Zsh plugins updated"
            echo_task "Remove repositories which are no longer managed"
            zplug clean
            echo_ok "Cleanup done"
            echo_task "Remove the cache file"
            zplug clear
            echo_ok "Cleanup done"
            ;;
    esac
    echo
}

function cronmode {
    echo
    echo_warn "Running in cronmode!"
    echo
    if hash brew &> /dev/null;
    then
        runUpdates homebrew
    fi

    # Update cask apps
    if brew info brew-cask &> /dev/null;
    then
        runUpdates caskapps
    fi

    # Update oh-my-zsh plugins
    #if [ $SHELL == "/bin/zsh" ]
    #then
    #   runUpdates zshplugins
    #fi
}

function regularmode {
    # Update homebrew formulae
    if hash brew &> /dev/null;
    then
        read -p "Update homebrew formulae? <y/n> " prompt
        if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
            then
                runUpdates homebrew
        fi
    fi

    # Update cask apps
    if brew info brew-cask &> /dev/null;
    then
        read -p "Update cask apps? <y/n> " prompt
        if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
            then
                runUpdates caskapps
        fi
    fi

    # Update oh-my-zsh plugins
    #if [ $SHELL == "/bin/zsh" ]
    #then
    #   read -p "Update oh-my-zsh plugins? <y/n> " prompt
    #   if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
    #       then
    #           runUpdates zshpugins
    #   fi
    #fi
}

if [ $# -eq 0 ]
    then
        regularmode
    else
        while getopts ":c" opt; do
            case $opt in
                c)
                    cronmode
                    ;;
                \?)
                    regularmode
                    ;;
            esac
        done
fi
