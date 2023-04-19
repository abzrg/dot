;; OpenFOAM style -- source: Henry Weller dot-emacs

(defvar OPENFOAM_DIR (getenv "WM_PROJECT_DIR"))
(defvar OPENFOAM_TAGS_DIR (concat OPENFOAM_DIR "/.tags"))

(defun OpenFOAM-make-tags ()
  "Create/update the tags files for etags."
  (interactive)
  (call-process "foamTags"))

(defun OpenFOAM-tags ()
  "Load the etags table."
  (interactive)
  (setq large-file-warning-threshold nil)
  ;; Set the etags table to use
  (visit-tags-table (concat OPENFOAM_TAGS_DIR "/etags")))

(defun OpenFOAM-tag ()
  "Use `etags' to find the definition or declaration of the tag at point."
  (interactive)
  (OpenFOAM-tags)
  (etags-select-find-tag))


;;;  Set the auto-mode-alist for all C++ related files
(setq auto-mode-alist
      (
       append
       '(
         ("\\.C$"    . c++-mode)
         ("\\.H$"    . c++-mode)
         ("\\.l$"    . c++-mode)
         ("\\.L$"    . c++-mode)
         ("\\.y$"    . c++-mode)
         ("\\.Y$"    . c++-mode)
         ("\\.cc$"   . c++-mode)
         ("\\.hh$"   . c++-mode)
         ("\\.cxx$"   . c++-mode)
         ("\\.hxx$"   . c++-mode)
         ("\\.java$" . c++-mode)
         ("\\.cfg$" . c++-mode)
         ("\\.c$"    . c-mode)
         ("\\.h$"    . c-mode)
         )
       auto-mode-alist))

;; https://openfoamwiki.net/index.php/HowTo_xemacsIndentation
;; https://github.com/Henry/dot-emacs/blob/de960ff5d63b477cfa942b7a7fb1ad10f453a293/init/init-OpenFOAM.el
(defconst OpenFOAM-style
  '(
    (c-basic-offset . 4)
    (c-tab-always-indent . t)
    (c-comment-only-line-offset . (0 . 0))
    (c-indent-comments-syntactically-p . t)
    (c-block-comments-indent-p . nil)
    ;;(comment-style . 'multi-line)
    (comment-start . "// ")
    (comment-end . "")
    (c-cleanup-list . '((defun-close-semi) (list-close-comma) (scope-operator)))
    (c-backslash-column . 79)
    (c-backslash-max-column . 79)
    (c-auto-align-backslashes . t)
    (c-toggle-auto-state . 1)
    (c-toggle-auto-hungry-state . 1)

    ;; http://doc.endlessparentheses.com/Var/c-offsets-alist.html
    ;; https://www.gnu.org/software/emacs/manual/html_node/ccmode/c_002doffsets_002dalist.html
    (c-offsets-alist
     ;;(c . +)                     ;; inside a multi-line C style block comment
     (defun-open . 0)            ;; brace that opens a function definition
     (defun-close . 0)           ;; brace that closes a function definition
     (defun-block-intro . +)     ;; the first line in a top-level defun
     (class-open . 0)            ;; brace that opens a class definition
     (class-close . 0)           ;; brace that closes a class definition
     (inline-open . 0)           ;; brace that opens an in-class inline method
     (inline-close . 0)          ;; brace that closes an in-class inline method
     (topmost-intro . 0)         ;; the first line in a topmost construct
     ;; definition
     (topmost-intro-cont . 0)    ;; topmost definition continuation lines
     (member-init-intro . +)     ;; first line in a member initialization list
     (member-init-cont . 0)      ;; subsequent member initialization list lines
     (inher-intro . 0)           ;; first line of a multiple inheritance list
     (inher-cont . +)            ;; subsequent multiple inheritance lines
     (block-open . 0)            ;; statement block open brace
     (block-close . 0)           ;; statement block close brace
     (brace-list-open . 0)       ;; open brace of an enum or static array list
     (brace-list-close . 0)      ;; open brace of an enum or static array list
     (brace-list-intro . +)      ;; first line in an enum or static array list
     (brace-list-entry . 0)      ;; subsequent lines in an enum or static array
     ;; list
     (statement . 0)             ;; a C/C++/ObjC statement
     (statement-cont . 0)        ;; a continuation of a C/C++/ObjC statement
     (statement-block-intro . +) ;; the first line in a new statement block
     (statement-case-intro . +)  ;; the first line in a case `block'
     (statement-case-open . +)   ;; the first line in a case `block'
     ;; starting with brace
     (substatement . +)          ;; the first line after an if/while/for/do/else
     (substatement-open . 0)     ;; the brace that opens a substatement block
     (case-label . +)            ;; a case or default label
     (access-label . -)          ;; C++ private/protected/public access label
     (label . -)                 ;; any non-special C/C++/ObjC label
     (do-while-closure . 0)      ;; the `while' that ends a do/while construct
     (else-clause . 0)           ;; the `else' of an if/else construct
     (comment-intro . 0)         ;; line containing only a comment introduction
     (arglist-intro . +)         ;; the first line in an argument list
     (arglist-cont . 0)          ;; subsequent argument list lines when no
     ;; subsequent argument list lines when no the
     ;; arglist opening paren
     (arglist-cont-nonempty . 0) ;; subsequent argument list lines when at
     ;; subsequent argument list lines when at line
     ;; as the arglist opening paren
     (arglist-close . 0)         ;; line as the arglist opening paren
     (stream-op . +)             ;; lines continuing a stream operator construct
     (inclass . +)               ;; the construct is nested inside a class
     ;; definition
     (cpp-macro . 0)             ;; the construct is nested inside a class
     ;; definition
     (friend . 0)                ;; a C++ friend declaration
     )
    )
  "OpenFOAM C++ Programming Style"
  )

(defun OpenFOAM-mode-hook ()
  ;; If OpenFOAM env is loaded, load tags
  (if (string-empty-p (getenv "WM_PROJECT_DIR"))
      (message "OpenFOAM env is not loaded!")
    (progn
      (message "Adding OpenFOAM tags to tag tabel.")
      (OpenFOAM-tags)))

  ;; (setq cc-search-directories ("." "/usr/include" "/usr/local/include/*"))
  (setq cc-search-directories (list
                               "." "/opt/homebrew/opt/llvm/include/*/*"
                               (concat (getenv "FOAM_SRC") "/*/lnInclude")
                               (concat (getenv "FOAM_SRC") "/*/*/lnInclude")
                               (concat (getenv "FOAM_SRC") "/*/*/*/lnInclude")
                               (concat (getenv "FOAM_SRC") "/*/*/*/*/lnInclude")
                               (concat (getenv "FOAM_SRC") "/*/*/*/*/*/lnInclude")
                               (concat (getenv "FOAM_SRC") "/*/*/*/*/*/*/lnInclude")
                               (concat (getenv "FOAM_SRC") "/*/*/*/*/*/*/*/lnInclude")
                               ))

  ;; Switch on fly-spell mode in comments
  (flyspell-prog-mode)

  (c-add-style "OpenFOAM" OpenFOAM-style t)

  ;; Switch off "electric" indent mode which cc-mode switches on
  ;; This mode automatically indents line when "punctuation" is typed
  (setq-default c-electric-flag nil)
  (electric-indent-mode -1)

  ;; Electric operator mode
  (if (package-installed-p 'electric-operator)
      (electric-operator-mode 1))

  ;; Switch on auto-fill in comments
  (set (make-local-variable 'fill-nobreak-predicate)
       (lambda ()
         (not (eq (get-text-property (point) 'face)
                  'font-lock-comment-face))))
  )


(add-hook 'c-mode-common-hook 'OpenFOAM-mode-hook)
(add-hook 'c++-mode-hook 'OpenFOAM-mode-hook)

