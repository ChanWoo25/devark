# Bash Redirection Cheat Sheet

## File Descriptors
| FD  | Stream | Description     |
| --- | ------ | --------------- |
| 0   | stdin  | Standard input  |
| 1   | stdout | Standard output |
| 2   | stderr | Standard error  |

## Common Redirection Operators

| Operator | Description                                 |
| -------- | ------------------------------------------- |
| `>`      | Redirect stdout (overwrite)                 |
| `>>`     | Redirect stdout (append)                    |
| `2>`     | Redirect stderr (overwrite)                 |
| `2>>`    | Redirect stderr (append)                    |
| `&>`     | Redirect stdout and stderr (overwrite)      |
| `&>>`    | Redirect stdout and stderr (append)         |
| `2>&1`   | Redirect stderr to wherever stdout is going |

## Examples

```bash
# Redirect stdout to a file
ls > out.txt

# Redirect stderr to a file
ls nonexistent 2> err.txt

# Redirect stdout and stderr to separate files
command > out.txt 2> err.txt

# Redirect stdout and stderr to the same file
command &> all.txt

# or (POSIX-compatible):
command > all.txt 2>&1

# Append stdout and stderr to a file
command &>> log.txt

# Suppress all output (quiet mode)
command &> /dev/null

# Send a message to stderr manually
echo "This is an error!" 1>&2

# Read from a file (stdin)
command < input.txt
```

## Tips

- `&>` is shorthand for `> file 2>&1` in Bash.
- Use `>>` for logs to avoid overwriting files.
- `/dev/null` discards output (like a black hole).
- Combine with `tee` to write and show output:
  ```bash
  command 2>&1 | tee log.txt
  ```
