#!/bin/bash

clear
declare -a CMD_HISTORY
HISTORY_INDEX=0
CURRENT_INPUT=""

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

handle_arrow_keys() {
    case "$1" in
        $'\e[A')
            if (( HISTORY_INDEX > 0 )); then
                ((HISTORY_INDEX--))
                INPUT="${CMD_HISTORY[HISTORY_INDEX]}"
                echo -ne "\r\033[K└──╼ > $INPUT"
            fi
            ;;
        $'\e[B')
            if (( HISTORY_INDEX < ${#CMD_HISTORY[@]} )); then
                ((HISTORY_INDEX++))
                if (( HISTORY_INDEX == ${#CMD_HISTORY[@]} )); then
                    INPUT="$CURRENT_INPUT"
                else
                    INPUT="${CMD_HISTORY[HISTORY_INDEX]}"
                fi
                echo -ne "\r\033[K└──╼ > $INPUT"
            fi
            ;;
    esac
}

while true; do
    read -e -p $'\n\e[1;92m\e[0m\e[1;77m\e[0m\e[1;92m ┌─[NNOSSHELL ('"$USER"')]                                                                                                 └──╼ > ' INPUT
    CURRENT_INPUT="$INPUT"
    if [[ -n "$INPUT" ]]; then
        CMD_HISTORY+=("$INPUT")
        HISTORY_INDEX=${#CMD_HISTORY[@]}
        run_command
    fi
done

