#!/bin/sh -e

# Prepend the new todo to the list of todos
TODO="$HOME/todo.md"


main() {
    capture=`mktemp`
    trap 'rm -f "$capture"' EXIT INT TERM

    # Pre-text
printf -- "\
- [ ] 
  %s
  %s
" "`date`" "`pwd`" > "$capture"

    # open a new tmp buffer for capturing a todo
    "$EDITOR" "$capture" -c '1norm $' || die 1 "Error in capture [todo].\n"

    # Prepend the todo file with the newly captured todo
    printf "\n" >> "$capture"
    cat "$TODO" >> "$capture"
    cp "$capture" "$TODO"
}

die() {
    printf "%s" "$2"
    exit "$1"
}

# -------------

main
