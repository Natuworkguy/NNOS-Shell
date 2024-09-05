#!/bin/bash

clear

run_command() {
    local CMD=($INPUT)
    local INPUTWD="${INPUT// /./}"
    if [[ "${CMD[0]}" == "sudo" && "${CMD[1]}" == "-i" ]]; then
        sudo bash $0
    elif [[ "${CMD[0]}" == "exit" ]]; then
        exit 0
    elif command -v "${CMD[0]}" &> /dev/null; then
        "${CMD[@]}"
    else
        echo "command.$INPUTWD: Not found"
    fi
}

while true; do
    read -p $'\n\e[1;92m\e[0m\e[1;77m\e[0m\e[1;92m ┌─[NNOSSHELL ('"$USER"')]
 └──╼ > ' INPUT
    run_command
done
