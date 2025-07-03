;;; Compiled snippets and support files for `c-like-syntax'
;;; Snippet definitions:
;;;
(yas-define-snippets 'c-like-syntax
                     '(("while" "while (${1:condition}) {\n    $0\n}"
                        "while (...) { ... }" nil nil nil
                        "/Users/ali/.emacs.snippets/c-like-syntax/while" nil nil)
                       ("if" "if (${1:condition}) {\n    $0\n}"
                        "if (...) { ... }" nil nil nil
                        "/Users/ali/.emacs.snippets/c-like-syntax/if" nil nil)
                       ("for"
                        "for (${1:init}; ${2:condition}; ${3:increment}) {\n    $0\n}"
                        "for (...; ...; ...) { ... }" nil nil nil
                        "/Users/ali/.emacs.snippets/c-like-syntax/for" nil nil)
                       ("else" "else {\n    $0\n}" "else { ... }" nil nil nil
                        "/Users/ali/.emacs.snippets/c-like-syntax/else" nil nil)
                       ("elif" "else if (${1:condition}) {\n    $0\n}"
                        "else if (...) { ... }" nil nil nil
                        "/Users/ali/.emacs.snippets/c-like-syntax/elif" nil nil)))


;;; Do not edit! File generated at Fri Apr  4 11:10:58 2025
