#!/bin/bash

if [[ -f ~/.nsconfig ]]; then
    source ~/.nsconfig
    if [[ "$USE_THIS_CONFIG" == "False" ]]; then
        ALL="@"
        MAIN="0"
        SPAR="1"
        CLEAR="True"
    fi
else
    echo "Config file not found. Creating it at ~/.nsconfig..."
    echo 'ALL="@"' > ~/.nsconfig
    echo 'MAIN="0"' >> ~/.nsconfig
    echo 'CLEAR="True"' >> ~/.nsconfig
    echo '# Defines if NNOS Shell clears before starting up.' >> ~/.nsconfig
    echo '# Allowed values: True, False' >> ~/.nsconfig
    echo 'USE_THIS_CONFIG="False"' >> ~/.nsconfig
    echo '# Defines if this config is used.' >> ~/.nsconfig
    echo 'If it is set to false none of the settings above will apply.' >> ~/.nsconfig
    echo '# Allowed values: True, False' >> ~/.nsconfig
    echo "Finished creating config."
    echo "Run NNOSSHELL again to use config and continue."
    exit 1
fi

if [[ "$CLEAR" == "True" ]]; then
    clear
fi

run_command() {
    local CMD=($INPUT)
    local INPUTWD="${INPUT// /./}"
    if [[ ${#CMD[@]} -ge 2 && "${CMD[$MAIN]}" == "sudo" && "${CMD[$SPAR]}" == "-i" ]]; then
        sudo bash $0
    elif [[ "${CMD[$MAIN]}" == "exit" ]]; then
        if [[ ${#CMD[@]} -ge 2 ]]; then
            exit ${CMD[$SPAR]}
        else
            exit 0
        fi
    elif command -v "${CMD[$MAIN]}" &> /dev/null; then
        "${CMD[@]}" | sed 's/*:*line*: //g'
        if [[ $? -ne 0 ]]; then
            echo "Command ${CMD[$MAIN]} failed with exit code $?"
        fi
    else
        echo "Command.$INPUTWD: Not found"
    fi
}

while true; do
    read -p $'\n\e[1;92m\e[0m\e[1;77m\e[0m\e[1;92m ┌─[NNOS.SHELL ('"$USER: $PWD"')]
 └──╼ > ' INPUT
    run_command
done

