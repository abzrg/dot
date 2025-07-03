;;; Compiled snippets and support files for `c++-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'c++-mode
                     '(("vec" "std::vector<$1> $2;$0" "std::vector<T>" nil nil
                        nil "/Users/ali/.emacs.snippets/c++-mode/vec" nil nil)
                       ("uns" "using namespace std;" "using namespace std;" nil
                        nil nil "/Users/ali/.emacs.snippets/c++-mode/uns" nil
                        nil)
                       ("try" "try {\n    $0\n}" "try { ... }" nil nil nil
                        "/Users/ali/.emacs.snippets/c++-mode/try" nil nil)
                       ("qdebug"
                        "qDebug() << \"----------------------------------------\";\nqDebug() << \"$0\";\nqDebug() << \"----------------------------------------\";"
                        "qdebug" nil nil nil
                        "/Users/ali/.emacs.snippets/c++-mode/qdebug" nil nil)
                       ("once"
                        "#ifndef ${1:`(upcase (replace-regexp-in-string \"\\\\.\" \"_\" (file-name-nondirectory (buffer-file-name))))`_}\n#define $1\n\n$0\n\n#endif  // $1"
                        "#ifndef XXX; #define XXX; #endif" nil nil nil
                        "/Users/ali/.emacs.snippets/c++-mode/once" nil nil)
                       ("ns"
                        "namespace ${1:Namespace} {\n    $0\n}  // namespace $1"
                        "namespace Namespace" nil nil nil
                        "/Users/ali/.emacs.snippets/c++-mode/ns" nil nil)
                       ("fore" "for ($1: $2) {\n    $0\n}"
                        "for (...: ...) { ... }" nil nil nil
                        "/Users/ali/.emacs.snippets/c++-mode/fore" nil nil)
                       ("catch" "catch ($1) {\n    $0\n}" "catch (...) { ... }"
                        nil nil nil "/Users/ali/.emacs.snippets/c++-mode/catch"
                        nil nil)))


;;; Do not edit! File generated at Fri Apr  4 11:10:58 2025
