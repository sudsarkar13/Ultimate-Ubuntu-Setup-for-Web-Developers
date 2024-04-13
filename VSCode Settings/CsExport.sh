#!/bin/bash

# Define the desired format with trimmed path
format="\u@\h:\W"

# Append the command to set the PS1 environment variable with the desired format to ~/.bashrc
echo "export PS1=\"\$(echo -n \$format)\"" >> ~/.bashrc

# Source the updated ~/.bashrc to apply the changes immediately
source ~/.bashrc