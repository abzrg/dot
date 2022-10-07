;; Hide all org blocks by default
(add-hook 'org-mode-hook 'org-hide-block-all)


;; Latex syntax highlighting in in org mode
(setq org-highlight-latex-and-related '(latex))


;; Get references in latex-export
(setq org-latex-pdf-process (list
   "latexmk -pdflatex='xelatex -shell-escape -interaction nonstopmode' -pdf -f  %f"))

;; Execution =C-c C-c=
(org-babel-do-load-languages
  'org-babel-load-languages
  '((emacs-lisp . t)
    (shell . t)
    (python . t)))

;; don't ask for confirmation (yes or no) when executing code
(setq org-confirm-babel-evaluate nil)


;; Structure Template
;; This is needed as of Org 9.2
(require 'org-tempo)

(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))


