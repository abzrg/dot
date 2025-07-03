;;; Compiled snippets and support files for `rust-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'rust-mode
                     '(("while" "while ${1:condition} {\n    $0\n}\n"
                        "while ... { ... }" nil nil nil
                        "/Users/ali/.emacs.snippets/rust-mode/while" nil nil)
                       ("prln" "println!(\"$1\"$2);$0" "println!(...);" nil nil
                        nil "/Users/ali/.emacs.snippets/rust-mode/print" nil nil)
                       ("loop" "loop {\n    $0\n}\n" "loop { ... }" nil nil nil
                        "/Users/ali/.emacs.snippets/rust-mode/loop" nil nil)
                       ("if" "if ${1:condition} {\n    $0\n}" "if ... { ... }"
                        nil nil nil "/Users/ali/.emacs.snippets/rust-mode/if"
                        nil nil)
                       ("forr" "for ${1:i} in ${2}..${3} {\n    $0\n}"
                        "forr ... { ... }" nil nil nil
                        "/Users/ali/.emacs.snippets/rust-mode/forr" nil nil)
                       ("fore"
                        "fore ${1:item} in ${2:elements}.iter() {\n    $0\n}"
                        "fore ... { ... }" nil nil nil
                        "/Users/ali/.emacs.snippets/rust-mode/fore" nil nil)
                       ("else" "else {\n    $0\n}\n" "else { ... }" nil nil nil
                        "/Users/ali/.emacs.snippets/rust-mode/else" nil nil)
                       ("elif" "else if ${1:condition} {\n    $0\n}\n"
                        "else if ... { ... }" nil nil nil
                        "/Users/ali/.emacs.snippets/rust-mode/elif" nil nil)))


;;; Do not edit! File generated at Fri Apr  4 11:10:58 2025
