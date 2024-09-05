credits() {
    echo "Programmer: Nathan Chonot"
}

RUNCMD() {
    if [[ "$INPUT" == "/credits" ]]; then
        credits
    else
        if [[ -f /usr/*bin/$INPUT ]]; then
            $INPUT
        else
            echo "command.$INPUTWD"
        fi
     fi
}

while true; do
    read -p $'\n\e[1;92m\e[0m\e[1;77m\e[0m\e[1;92m ┌─[NNOSSHELL]
 └──╼ > ' INPUT
    INPUTWD=$(echo "$INPUT" | sed 's/ /./g')
    RUNCMD
done
