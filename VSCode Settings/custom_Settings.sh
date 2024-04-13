#!/bin/bash

# Define the trim_path function
trim_path() {
    local path=$1
    local trimmed_path=${path/#$HOME/\~}  # Trim the home directory part of the path
    echo $trimmed_path
}

# Define color codes
RESET_COLOR='\033[0m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'

# Customize the terminal prompt
PS1="\[$GREEN\]\u@\h \[$BLUE\]\$(trim_path \w) \[$RESET_COLOR\]\$ "

# You can add more commands or functionalities to the script as needed