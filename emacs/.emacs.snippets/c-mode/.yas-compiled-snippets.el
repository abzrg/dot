;;; Compiled snippets and support files for `c-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'c-mode
                     '(("main"
                        "int main(int argc, char *argv[])\n{\n    $0\n    return 0;\n}\n"
                        "int main(argc, argv) { ... }" nil nil nil
                        "/Users/ali/.emacs.snippets/c-mode/main" nil nil)
                       ("incq" "#include \"$0\"" "#include \"...\"" nil nil nil
                        "/Users/ali/.emacs.snippets/c-mode/incq" nil nil)
                       ("inc" "#include <$0>" "#include <...>" nil nil nil
                        "/Users/ali/.emacs.snippets/c-mode/inc" nil nil)))


;;; Do not edit! File generated at Fri Apr  4 11:10:58 2025
