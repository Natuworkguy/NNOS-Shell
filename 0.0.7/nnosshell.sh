#!/bin/bash

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  cat << EOF
NNOS Shell
[-h, --help]: Display this help text
[-r, --reset]: Reinstall the config file
NNOS Shell is a secure and cool looking shell
made by the creators of NNOS; The Nathan Network.
Learn more at https://www.github.com/natuworkguy/nnos-shell/
EOF
  exit 0
fi

if [[ "$1" == "-r" || "$1" == "--reset" ]]; then
  read -p "Resetting will wipe all data in the config file [Y/n]: " RESETPROMPT
  if [[ "$RESETPROMPT" == "Y" || "$RESETPROMPT" == "y" ]]; then
      if [[ -f ~/.nsconfig ]]; then
          rm ~/.nsconfig &>> /dev/null
      else
          echo "The config file does not exist"
      fi
  elif [[ "$RESETPROMPT" == "N" || "$RESETPROMPT" == "n" ]]; then
      exit 0
  else
      echo "You must enter Y/y or N/n."
  fi
fi

CLEAR="False"

if [[ -d ~ && -f ~/.nsconfig ]]; then
    if [[ "$(head -n1 ~/.nsconfig | sed 's/#//g')" == "NSType NSConfigFile" ]]; then
        source ~/.nsconfig
    else
        cat << EOF
The config file is not valid.
This may be caused by you using an older version of NNOS Shell
or the config file being modified. Try running NNOS Shell with the -r flag
to reset the config.
EOF
    fi
    if [[ "$USE_THIS_CONFIG" == "False" ]]; then
        ALL="@"
        MAIN="0"
        SPAR="1"
        CLEAR="True"
    fi
else
    echo "Creating config file at ~/.nsconfig..."
    cat << EOF > ~/.nsconfig
#NSType NSConfigFile
CLEAR="True"
# Defines if NNOS Shell clears before starting up.
# Allowed values: True, False
USE_THIS_CONFIG="False"
# Defines if this config is used.
# If set to False, none of the settings above will apply.
# Allowed values: True, False
ALL="@"
MAIN="0"
SPAR="1"
CLEAR="True"
# Nerdy Stuff
EOF
    echo "Finished creating config."
    echo "Run NNOSSHELL again to use config and continue."
    exit 1
fi

if [[ "$CLEAR" == "True" ]]; then
    clear
fi

checkns() {
    if [[ ! -d . ]]; then
        echo "Cannot Start: The directory is not valid."
        exit 1
    fi
}

hang() {
    IFS=' ' read -r -a CMD <<< "$INPUT"
    IFS=$' \t\n'  # Reset IFS to default
    local INPUTWD="${INPUT// /.}"
    if [[ ${#CMD[@]} -ge 2 && "${CMD[$MAIN]}" == "sudo" && "${CMD[$SPAR]}" == "-i" ]]; then
        sudo bash "$0"
    elif [[ -z "$INPUT" ]]; then
        echo
    elif [[ "${CMD[$MAIN]}" == "cd" && -n "${CMD[$SPAR]}" ]]; then
        if ! cd "${CMD[$SPAR]}"; then
            echo "NS: Directory ${CMD[$SPAR]} not found"
        fi
    elif [[ "${CMD[$MAIN]}" == "nano" && -n "${CMD[$SPAR]}" ]]; then
        nano "${CMD[$SPAR]}"
    elif [[ "${CMD[$MAIN]}" == "vi" && -n "${CMD[$SPAR]}" ]]; then
        vi "${CMD[$SPAR]}"
    elif [[ "${CMD[$MAIN]}" == "exit" ]]; then
        exit 0
    elif command -v "${CMD[$MAIN]}" &> /dev/null; then
        "${CMD[@]}"
        if [[ $? -ne 0 ]]; then
            echo
            echo "NS: Command ${CMD[$MAIN]} failed with exit code $?"
        fi
    else
        echo "NS: Command.$INPUTWD: Not found"
    fi
}

checkns

while true; do
    read -p $'\n\e[1;92m ┌─[NNOS.SHELL ('"$USER: $PWD"')]
 └──╼ > ' INPUT
    hang
done
