;; Resources:
;;
;; 1. https://gist.github.com/pkazmierczak/4331666
;; 2. https://piotr.is/2010/emacs-as-the-ultimate-latex-editor/
;; 3. https://github.com/Avsecz/dotemacs/blob/master/dot-emacs-config/auctex-config.el
;; 4. https://www.emacswiki.org/emacs/RefTeX
;; 5. https://www.gnu.org/software/emacs/manual/html_node/reftex/RefTeX-in-a-Nutshell.html

;; ----------------------------------------------------------------------------

;; Increase the font size of the preview
(setq-default preview-scale-function 1.5)


;; AUCTEX settings
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)


;; bibtex
(setq reftex-bibliography-commands
'("bibliography" "nobibliography" "addbibresource"))

;; So that RefTeX finds my bibliography
;; (https://tex.stackexchange.com/a/54825/220469)
(setq reftex-default-bibliography '("references.bib" "../references.bib"))

;; ---------
;; Math-mode
;; ---------
;; Convinient shortcuts (by default)
(add-hook 'TeX-mode-hook 'LaTeX-math-mode)
;; (custom-set-variables
;;  '(LaTeX-math-abbrev-prefix "¸")) ;rebind ` to ¸ in auctex (Does not work??)


;; ------------------------------
;; Spell Check with flyspell-mode
;; ------------------------------
;; could be ispell as well, depending on your preferences
(setq ispell-program-name "ispell")
;; this can obviously be set to any language your spell-checking program supports
(setq ispell-dictionary "english")

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-buffer)


;; ------------
;; Outline Mode
;; ------------
;; Another nice package is the Outline Mode. It allows the user to
;; hide some parts of the text file, which makes working with large
;; files much easier.
;; http://www.gnu.org/software/emacs/manual/html_node/emacs/Outline-Mode.html
(defun turn-on-outline-minor-mode ()
(outline-minor-mode 1))
(add-hook 'LaTeX-mode-hook 'turn-on-outline-minor-mode)
(add-hook 'latex-mode-hook 'turn-on-outline-minor-mode)
(setq outline-minor-mode-prefix "\C-c \C-o") ; Or something else
;; Now you can fold sections, subsections, chapters, or the whole
;; document. To hide all the contents of your current section, use C-c
;; C-o C-l. You can apply it to a chapter, subsection, etc. You can
;; also move to a next unit of your document with C-c C-o C-n, or to a
;; previous one with C-c C-o C-p. If you’re lost and want to see the
;; whole document again, use C-c C-o C-a.
(add-hook 'outline-minor-mode-hook
          (lambda () (local-set-key "\M-o"
                                    outline-mode-prefix-map)))

;; ------------------------------------------------------------------------
;; Folding and unfolding parts of the text might be confusing, though,
;; but there’s another way to navigate through a big TeX file, and you
;; can use Reftex mode for it. Reftex is a mode that helps with
;; managing references <full documentation>, but it can also be used
;; to create a table of contents for a TeX file and to navigate using
;; it. Here is my configuration for Reftex from my .emacs file:
;; - RefTeX: http://www.gnu.org/software/auctex/reftex.html
;; - full documentation: http://www.gnu.org/software/auctex/manual/reftex.index.html
(require 'tex-site)
(autoload 'reftex-mode "reftex" "RefTeX Minor Mode" t)
(autoload 'turn-on-reftex "reftex" "RefTeX Minor Mode" nil)
(autoload 'reftex-citation "reftex-cite" "Make citation" nil)
(autoload 'reftex-index-phrase-mode "reftex-index" "Phrase Mode" t)
(autoload 'reftex-label "reftex-label" "Make label" nil)
(autoload 'reftex-reference "reftex-reference" "Make label" nil)

(add-hook 'reftex-load-hook 'imenu-add-menubar-index)
(add-hook 'latex-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

(setq LaTeX-eqnarray-label "eq"
      LaTeX-section-label "sec"
      LaTeX-equation-label "eq"
      LaTeX-figure-label "fig"
      LaTeX-table-label "tab"
      LaTeX-myChapter-label "chap"
      TeX-auto-save t
      TeX-newline-function 'reindent-then-newline-and-indent
      TeX-parse-self t
      TeX-style-path '("style/" "auto/"
                       "/usr/share/emacs21/site-lisp/auctex/style/"
                       "/var/lib/auctex/emacs21/"
                       "/usr/local/share/emacs/site-lisp/auctex/style/")
      LaTeX-section-hook '(LaTeX-section-heading
                           LaTeX-section-title
                           LaTeX-section-toc
                           LaTeX-section-section
                           LaTeX-section-label))
(setq reftex-refstyle "\\ref")
(setq reftex-enable-partial-scans t)
(setq reftex-save-parse-info t)
(setq reftex-use-multiple-selection-buffers t)
(setq reftex-plug-into-AUCTeX t)

