;;; Compiled snippets and support files for `makefile-gmake-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'makefile-gmake-mode
                     '(("make"
                        "CFLAGS=-Wall -Wextra -std=c11 -pedantic\nLIBS=\n\n$1: $2\n	$(CC) $(CFLAGS) -o $1 $2 $(LIBS)\n"
                        "make" nil nil ((yas-indent-line 'fixed))
                        "/Users/ali/.emacs.snippets/makefile-gmake-mode/make"
                        nil nil)))


;;; Do not edit! File generated at Fri Apr  4 11:10:58 2025
