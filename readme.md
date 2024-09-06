# NNOS Shell

A custom shell for the NNOS operating system, written in Bash, with support for configuration files, command history, and arrow key navigation.

## Features

- **Custom Configuration**: NNOS Shell reads from a configuration file (`~/.nsconfig`) to set up behavior such as whether to clear the screen on startup.
- **Command Execution**: Supports running standard shell commands, with basic error handling.
- **Command History**: Previous commands are stored and can be viewed by running the `history` command.
- **Arrow Key Support**: Use the up and down arrow keys to scroll through previous commands.
- **Dynamic Config Creation**: If the configuration file does not exist, it is automatically created with default values.

## Configuration

The configuration file (`~/.nsconfig`) controls the shell's behavior. If it does not exist, the shell will create it with the following default values:

```bash
ALL="@"
MAIN="0"
CLEAR="True"
# Defines if NNOS Shell clears before starting up.
# Allowed values: True, False
USE_THIS_CONFIG="False"
# Defines if this config is used.
# If it is set to false, none of the settings above will apply.
# Allowed values: True, False
```

### Configurable Options:

- `CLEAR`: Whether to clear the screen before starting the shell (`True` or `False`).
- `USE_THIS_CONFIG`: If set to `False`, the default internal settings will override the config file.

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/nnos-shell.git
   ```

2. Navigate to the directory:
   ```bash
   cd nnos-shell
   ```

3. Make the script executable:
   ```bash
   chmod +x nnos-shell.sh
   ```

4. Run the shell:
   ```bash
   ./nnos-shell.sh
   ```

## Usage

Once the NNOS Shell is running, you can execute commands as you would in any other shell. 

### Key Commands:
- **`exit`**: Exit the shell. You can optionally provide an exit code, e.g., `exit 1`.

## Examples

```bash
 ┌─[NNOS.SHELL (user: /home/user)]
 └──╼ > echo "Hello, World!"
Hello, World!
```
