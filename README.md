# 0x03. Shell, init files, variables and expansions

This project covers shell initialization files, variables, and expansions in Bash scripting.

## Scripts

### Mandatory Tasks

- **0-alias**: Creates an alias `ls` with value `rm *`
- **1-hello_you**: Prints "hello" followed by the current Linux user
- **2-path**: Adds `/action` to the PATH environment variable
- **3-paths**: Counts the number of directories in the PATH
- **4-global_variables**: Lists all environment variables
- **5-local_variables**: Lists all local variables, environment variables, and functions
- **6-create_local_variable**: Creates a new local variable `BEST` with value `School`
- **7-create_global_variable**: Creates a new global variable `BEST` with value `School`
- **8-true_knowledge**: Prints the result of 128 plus the `TRUEKNOWLEDGE` environment variable
- **9-divide_and_rule**: Prints the result of `POWER` divided by `DIVIDE` environment variables
- **10-love_exponent_breath**: Displays `BREATH` to the power of `LOVE`
- **11-binary_to_decimal**: Converts `BINARY` from base 2 to base 10
- **12-combinations**: Prints all possible combinations of two letters (a-z), except "oo"
- **13-print_float**: Prints `NUM` with two decimal places

### Advanced Tasks

- **100-decimal_to_hexadecimal**: Converts `DECIMAL` from base 10 to base 16
- **101-rot13**: Encodes and decodes text using rot13 encryption
- **102-odd**: Prints every other line from input, starting with the first line
- **103-water_and_stir**: Adds two numbers in custom bases (WATER in base "water", STIR in base "stir") and prints result in base "bestchol"

## Requirements

- All scripts must be exactly 2 lines long
- All scripts must start with `#!/bin/bash`
- All files must end with a new line
- No use of `&&`, `||`, `;`, `bc`, `sed`, or `awk` (except where specifically required)
- All files must be executable

## Usage

Make all scripts executable:

```bash
chmod +x 0x03-shell_variables_expansions/*
```

Run any script:

```bash
./0x03-shell_variables_expansions/script_name
```

For scripts that use environment variables, set them first:

```bash
export VARIABLE_NAME=value
./0x03-shell_variables_expansions/script_name
```

## References

- [Bash Manual](https://www.gnu.org/software/bash/manual/)
- `man bash`, `help <command>`

## License

Educational use only. Redistribution or publication is prohibited.
