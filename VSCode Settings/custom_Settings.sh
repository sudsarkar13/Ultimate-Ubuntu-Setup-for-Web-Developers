#!/bin/bash

# Define the lines to add to the .bashrc file
lines_to_add="# Truncate the path in the prompt
PS1='\${debian_chroot:+(\$debian_chroot)}\\\u@\\\h:\${BLUE} \\\W\${RESET_COLOR}\\\$ '

# Define color codes
RESET_COLOR='\\\[\033[0m\\\]'
GREEN='\\\[\033[0;32m\\\]'
BLUE='\\\[\033[0;34m\\\]'

# Check if the lines are already in .bashrc
if grep -Fxq "$lines_to_add" ~/.bashrc; then
    echo "Lines already exist in .bashrc. No changes made."
else
    # Add the lines to .bashrc
    echo "$lines_to_add" >> ~/.bashrc
    echo "Lines added to .bashrc."
fi
