#!/bin/sh -e

JRNL="$HOME/jrnl.gpg"
RECEPIENT="alixbozorgzadeh@gmail.com"


main() {
    capture=`mktemp`
    trap 'rm -f "$capture" "${capture}.gpg"' EXIT INT TERM

    # Pre-text
printf "\
%s {{{

    

}}}
" "`date`" > "$capture"

    # open a new tmp buffer for capturing a thought
    "$EDITOR" "$capture" -c '3norm $' || die 1 "Error in capture.\n"

    # prepend the buffer into the decrypted file
    printf "\n" >> "$capture"
    decrypt "$JRNL" - >> "$capture" || die 2 "Error in decrypting the input file '$JRNL'\n".

    # Encrypt the capture into the original Journal file
    encrypt "$capture" "$RECEPIENT" || die 3 "Error encrypting the updated capture file.\n"

    # mv the encrypted file to the original journal file
    mv "${capture}.gpg" "$JRNL"
}

die() {
    printf "%s" "$2"
    exit "$1"
}

decrypt() {
    # (silently) decrypts the input file ($1) into output file ($2)
    # '-' for writing to stdout
    gpg --quiet --batch --no-verbose --output "$2" --decrypt "$1" 2>/dev/null
}

encrypt() {
    # encrypts (and signs) the input file ($1) into ($1.gpg) with hash of the recepient "$2"
    gpg --yes --quiet --batch --no-verbose --sign --encrypt --recipient "$2" "$1"
}

# -------------

main
