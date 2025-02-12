#!/bin/bash

clear

run_command() {
    if [[ "$INPUT" == "sudo -i" ]]; then
        sudo $0
    elif [[ "$INPUT" == "exit" ]]; then
        exit 0
    elif command -v "$INPUT" &> /dev/null; then
        $INPUT
    else
        echo "command.$INPUTWD: Not found"
    fi
}

while true; do
    read -p $'\n\e[1;92m\e[0m\e[1;77m\e[0m\e[1;92m ┌─[NNOSSHELL ('"$USER"')]
 └──╼ > ' INPUT
    INPUTWD="${INPUT// /./}"
    run_command
done

