#!/bin/bash

# Define the desired format
format="\u@\h:\w"

# Append the command to trim the bash path to $PWD with the desired format to ~/.bashrc
echo "export PS1=\"\$(echo -n \$format)\"" >> ~/.bashrc

# Source the updated ~/.bashrc to apply the changes immediately
source ~/.bashrc