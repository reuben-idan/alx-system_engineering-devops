# Shell, Init Files, Variables and Expansions

This repository contains concise Bash scripts and documentation designed to demonstrate essential shell concepts, including initialization files, variable management, expansions, arithmetic, and aliasing. All scripts are tailored for Ubuntu 20.04 LTS and strictly adhere to a two-line format.

## Contents

- **Shell Initialization**: Explore how `/etc/profile`, `/etc/profile.d/`, and `~/.bashrc` affect your shell environment.
- **Variables**: Learn about local, global, and reserved variables, including special parameters and environment management.
- **Expansions**: Understand shell expansions, quoting, and command substitution.
- **Shell Arithmetic**: Perform calculations directly in the shell.
- **Aliases**: Create, list, and manage shell aliases.

## Usage

1. Ensure each script is executable:
   ```bash
   chmod +x script_name
   ```
2. Run the script:
   ```bash
   ./script_name
   ```

## Requirements

- All scripts are exactly two lines and end with a newline.
- Only Bash built-ins and allowed commands are used (no `bc`, `sed`, or `awk`).
- Compatible editors: vi, vim, emacs.

## Structure

Each file demonstrates a targeted Bash concept. Refer to the filename for its purpose or consult in-script comments for details.

## References

- [Bash Manual](https://www.gnu.org/software/bash/manual/)
- `man bash`, `help <command>`

## License

Educational use only. Redistribution or publication is prohibited.
