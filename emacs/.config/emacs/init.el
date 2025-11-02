;; --- Early Settings ---

;; Reduce the number of times the garbage collector will run during the startup
;; process
;; The default is 800 kilobytes.  Measured in bytes.
;; --------------------------------------
(setq gc-cons-threshold (* 50 1000 1000))
;; --------------------------------------

(setq debug-on-error t)

(require 'package)

;; Melpa
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; (use-package benchmark-init
;;   :ensure t
;;   :config
;;   ;; To disable collection of benchmark data after init is done.
;;   (add-hook 'after-init-hook 'benchmark-init/deactivate))


;; --- UI Settings ---

;; Open in maximized window size
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; No window decorations
(add-to-list 'default-frame-alist '(undecorated . t))

;; Font
(defvar rc/font-name "Noto sans mono" "The default font family name.")
(defvar rc/font-size "19" "The default font family size.")
(setq rc/font (concat rc/font-name "-" rc/font-size))
(set-face-attribute 'default nil :font rc/font)
(add-to-list 'default-frame-alist `(font . ,rc/font))

;; Theme
(use-package emacs
  :ensure nil
  :config
  (setq modus-themes-mixed-fonts t)
  ; (load-theme 'modus-vivendi t)
  (load-theme 'zenburn t)

  )

;; Don't show the splash screen
(setq inhibit-startup-message t)

;; Disable bell beep
(setq ring-bell-function 'ignore)

;; Turn off some unneeded UI elements
(menu-bar-mode 1)                       ; This is actually useful
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Don't pop up UI dialogs when prompting
(setq use-dialog-box nil)

;; Display line numbers in every buffer
(global-display-line-numbers-mode -1)

;; Display column number in mode-line
(column-number-mode 1)

;; Move customization variables to a separate file and load it
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

;; Open in foreground
(select-frame-set-input-focus (selected-frame))

;; I'd rather type less
(setq confirm-kill-emacs 'y-or-n-p)
(defalias 'yes-or-no-p 'y-or-n-p)
(setopt use-short-answers t)
(setq vc-follow-symlinks t)

(set-frame-parameter (selected-frame) 'alpha-background 95)

(add-to-list 'default-frame-alist '(alpha 95 95))


;; --- Keybindings ------------------------------------------------------------

;;;; the region is replaced when a character is inserted or deleted (e.g., with
;; backspace).
(delete-selection-mode 1)

;;;; Backward delete (and not kill) word
;; source: https://jblevins.org/log/clipboard
(defun backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (backward-word arg) (point))))

(global-set-key (kbd "C-M-<backspace>") 'backward-kill-word)
(global-set-key (kbd "M-<backspace>") 'backward-delete-word)


;; Do not indent the current line when RET is pressed. Instead only indent the
;; next line
;; (NOTE: I need to test this and see if I like it)
(setq-default electric-indent-inhibit t)

;;; I prefer cmd key for meta
(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'none)

;; Use M-` to switch to other frames
(global-set-key "\M-`" 'other-frame)

(global-set-key (kbd "M-s M-f") 'find-file-at-point)

;; Courtesy of tsoding
(defun rc/duplicate-line ()
  "Duplicate current line"
  (interactive)
  (let ((column (- (point) (point-at-bol)))
        (line (let ((s (thing-at-point 'line t)))
                (if s (string-remove-suffix "\n" s) ""))))
    (move-end-of-line 1)
    (newline)
    (insert line)
    (move-beginning-of-line 1)
    (forward-char column)))

(global-set-key (kbd "C-,") 'rc/duplicate-line)

;; Stolen from http://ergoemacs.org/emacs/emacs_unfill-paragraph.html
;; Courtesy of tsoding
(defun rc/unfill-paragraph ()
  "Replace newline chars in current paragraph by single spaces.
This command does the inverse of `fill-paragraph'."
  (interactive)
  (let ((fill-column 90002000)) ; 90002000 is just random. you can use `most-positive-fixnum'
    (fill-paragraph nil)))

(global-set-key (kbd "C-c M-q") 'rc/unfill-paragraph)

;; Courtesy of tsoding
(defun rc/insert-timestamp ()
  (interactive)
  (insert (format-time-string "(%Y-%m-%d %H:%M:%S)")))

(global-set-key (kbd "C-x t .") 'rc/insert-timestamp)

;;;; [paren]
;; courtesy of prot
(use-package paren
  :ensure nil
  :hook (prog-mode . show-paren-local-mode)
  :config
  (setq show-paren-style 'parenthesis)
  (setq show-paren-when-point-in-periphery nil)
  (setq show-paren-when-point-inside-paren nil)
  (setq show-paren-context-when-offscreen 'overlay)) ; Emacs 29

;;;; [elec-pair]
;; Auto close brackets and quotes
(use-package elec-pair
  :ensure nil
  :hook ((prog-mode . electric-pair-mode)
         (org-mode  . electric-pair-mode))
  :config
  (with-eval-after-load 'elec-pair
    (when (boundp 'electric-pair-mode-map)
      (define-key electric-pair-mode-map "," 'self-insert-command)
      (define-key electric-pair-mode-map ":" 'self-insert-command)
      (define-key electric-pair-mode-map "(" 'self-insert-command)
      (define-key electric-pair-mode-map ")" 'self-insert-command)
      (define-key electric-pair-mode-map (kbd ">") #'self-insert-command)
      (define-key electric-pair-mode-map (kbd "<") #'self-insert-command)))

  ;; A binding to delete pairs after the cursor
  (global-set-key (kbd "M-(") 'delete-pair)
  ;; make electric-pair-mode work on more brackets.
  (setq electric-pair-pairs '((?\{ . ?\})
                              (?\[ . ?\])))
  (setq electric-pair-preserve-balance t
        electric-pair-skip-whitespace nil
        electric-pair-delete-adjacent-pairs t
        electric-pair-open-newline-between-pairs nil
        electric-pair-skip-whitespace-chars '(9 10 32)
        electric-pair-skip-self 'electric-pair-default-skip-self))

;; ;;;; [visual-fill-column]
;; ;; NOTE: I don't like this for now as I need to know where my lines exceed 80
;; ;;       chars.
;; (use-package visual-fill-column
;;   :ensure t
;;   :hook ((markdown-mode org-mode) . rc/center-text)
;;   :config
;;   (defun rc/center-text ()
;;     (visual-fill-column-mode)
;;     (setq visual-fill-column-center-text t)))

;;;; [emacs]
(use-package emacs
  :ensure nil
  :preface
  (defvar rc/indent-width 4)
  :bind (("M-o" . (lambda () (interactive)(end-of-line)(newline-and-indent))))
  :config
  ;; Set the tab size
  (setq-default tab-width 4)
  ;; Use spaces instead of tabs for indentation
  (setq-default indent-tabs-mode nil)

  ;; Adds a newline to the end of any file that doesn't have one, just
  ;; after it visits the file.
  (setq require-final-newline t)

  ;; Insert newline at the end of the file
  (setq require-final-newline t)

  (setq ring-bell-function 'ignore)
  (setq scroll-preserve-screen-position t)
  ;;(setq scroll-conservatively 0)

  ;; Set the text width (fill column)
  (setq-default fill-column 80)
  (add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

  ;; File path completion
  (global-set-key (kbd "C-x /") 'comint-dynamic-complete-filename))

;;;; [cc-mode]
(use-package cc-mode
  :ensure nil
  :bind (:map c-mode-base-map
              ;; Compile and recompile
              ("C-c C-;" . compile)
              ("C-;" . recompile))
  :config
  ;; C/C++-mode indentation
  (c-set-offset 'innamespace '-)

  (add-hook 'c++-mode-hook
            (lambda ()
              ;; Enable electric-indent
              (setq electric-indent-inhibit nil)))

  (setq-default c-basic-offset 4
                c-default-style '((java-mode . "java")
                                  (awk-mode . "awk")
                                  (c-mode . "k&r")
                                  (c++-mode . "bsd")))

  ;; Align (line-up) closing parenthesis with the start of the opening
  ;; file.
  (add-to-list
   'c-offsets-alist '(arglist-close . c-lineup-close-paren))
  (setq cperl-indent-parens-as-block t)
  (setq perl-indent-parens-as-block t))

;;;; [whitespace]
;;;; Negative space highlight
;;;; courtesy of prot (https://protesilaos.com/emacs/dotemacs)
(use-package whitespace
  :ensure nil
  :bind (("C-c z" . delete-trailing-whitespace)
         ("C-x x w" . whitespace-mode))
  :hook ((prog-mode . whitespace-mode))
  :config
  ;; NOTE 2023-08-14: This is experimental.  I am not sure I like it.
  (setq whitespace-style
        '(face
          tabs
          ;; spaces
          newline
          tab-mark
          ;;space-mark
          ;;newline-mark
          trailing
          missing-newline-at-eof
          space-after-tab::tab
          space-after-tab::space
          space-before-tab::tab
          space-before-tab::space)))

;;;; [flyspell]
;;;; https://200ok.ch/posts/2020-08-22_setting_up_spell_checking_with_multiple_dictionaries.html

;; ;; src: https://emacs.stackexchange.com/a/78613
;; (defun rc/fix-ispell-contraction ()
;;   "Fixes contractions (e.g. shouldn't) aren't not being checked properly.
;; See https://github.com/casouri/lunarymacs/blob/master/star/checker.el#L44-L49."
;;   (add-to-list 'ispell-dictionary-alist
;;                '("en_GB" "[[:alpha:]]" "[^[:alpha:]]" "[']"
;;                  nil ("-d" "en_GB") nil utf-8)))

(use-package flyspell
  :ensure nil
  ;; :if (executable-find "aspell")
  :hook
  ((org-mode markdown-mode text-mode) . flyspell-mode)
  :bind
  ;; Toggle mode depending the mode (prog-mode or otherwise)
  ("C-x x s" . (lambda ()
                 (interactive)
                 (if (derived-mode-p 'prog-mode)
                     ;; toggle, but restrict to prog-mode behavior
                     (if flyspell-mode
                         (flyspell-mode -1)
                       (flyspell-prog-mode))
                   ;; in text-like modes: toggle normally
                   (flyspell-mode 'toggle))))
  :config
  (setq flyspell-issue-message-flag nil)
  (setq ispell-dictionary "en_GB")
  ;; In addition to "brew install hunspell" download dicts to
  ;; ~/Library/Spelling/
  ;; https://cgit.freedesktop.org/libreoffice/dictionaries/plain/en/en_GB.aff
  ;; https://cgit.freedesktop.org/libreoffice/dictionaries/plain/en/en_GB.dic
  ;; https://cgit.freedesktop.org/libreoffice/dictionaries/plain/en/hyph_en_GB.dic
  ;; https://cgit.freedesktop.org/libreoffice/dictionaries/plain/en/en_US.aff
  ;; https://cgit.freedesktop.org/libreoffice/dictionaries/plain/en/en_US.dic
  ;; https://cgit.freedesktop.org/libreoffice/dictionaries/plain/en/hyph_en_US.dic
  ;; (with-eval-after-load "ispell"
  ;;   (setenv "LANG" "en_US.UTF-8")
  ;;   (setq ispell-program-name "hunspell")
  ;;   (setq ispell-dictionary "en_GB,en_US")
  ;;   (ispell-set-spellchecker-params)
  ;;   (ispell-hunspell-add-multi-dic "en_GB,en_US")
  ;;   (setq ispell-personal-dictionary "~/.hunspell_personal"))
  ;; (unless (file-exists-p ispell-personal-dictionary)
  ;;   (write-region "" nil ispell-personal-dictionary nil 0)))
)

;;;; Plain text (text-mode)
;;;; courtesy of prot
(use-package text-mode
  :ensure nil
  :mode "\\`\\(README\\|CHANGELOG\\|COPYING\\|LICENSE\\)\\'"
  :hook
  ((text-mode . turn-on-auto-fill)
   (prog-mode . (lambda () (setq-local sentence-end-double-space t))))
  :config
  (setq sentence-end-double-space nil)
  (setq sentence-end-without-period nil)
  (setq colon-double-space nil)
  (setq use-hard-newlines nil)
  (setq adaptive-fill-mode t))

;; Courtesy of mastering emacs
;; https://www.masteringemacs.org/article/find-files-faster-recent-files-package
(defun rc/ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

(use-package recentf
  :ensure nil
  :bind ("C-x C-r" . rc/ido-recentf-open)
  :hook (after-init . recentf-mode)
  :config
  (setq recentf-max-saved-items 50)
  ;; Remember recently edited files
  (recentf-mode 1))

;; ;;;; [savehist]
;; ;;;; somehow causes some errors about wrong type argument
;; (use-package savehist
;;   :ensure nil
;;   :config
;;   (savehist-mode 1))
;;   ;; Save search history and kill-ring buffer as well
;;   (setq savehist-additional-variables
;;         '(search-ring regexp-search-ring)) ; command-history
;;
;;   ;; NOTE(abzrg): The following causes some issues when exiting emacs (wrong arg
;;   ;;              type)
;;   (setq ;history-length 300
;;         savehist-autosave-interval 60
;;         history-delete-duplicates t
;;         savehist-save-minibuffer-history t)
;;
;;   ;; Save what you enter into minibuffer prompts
;;   (savehist-mode 1))

;;;; [saveplace]
;; Remember and restore the last cursor location of opened files
(use-package saveplace
  :ensure nil
  :config
  (save-place-mode 1))

;;;; [files]
(use-package files
  :ensure nil
  :config
  (setq confirm-kill-processes nil)
  ;; don't create .# files (crashes 'npm start')
  (setq create-lockfiles nil)
  ;; stop creating #autosave# files
  (setq auto-save-default nil)
  ;; No .saves-* metadata
  (setq auto-save-list-file-prefix nil)
  ;; Stop creating backup~ files
  (setq make-backup-files nil))

;;;; [autorevert]
(use-package autorevert
  :ensure nil
  :config
  (setq auto-revert-interval 2)
  (setq auto-revert-check-vc-info t)
  ;; Revert Dired and other buffers
  (setq global-auto-revert-non-file-buffers t)
  (setq auto-revert-verbose nil)
  ;; Revert buffers when the underlying file has changed
  (global-auto-revert-mode +1))

;;;; [dired]
(use-package dired
  :ensure nil
  :defer t
  :config
  ;; (dired-listing-switches
  ;;  "-goah --group-directories-first --time-style=long-iso")
  (setq dired-listing-switches
        "-aGFhlvt --group-directories-first --time-style=long-iso")

  ;; TODO(abzrg): comment
  (setq dired-dwim-target t)

  ;; Close all dired buffers after opening
  (setq dired-kill-when-opening-new-dired-buffer t))

;;;; [org]
(use-package org
  :ensure nil
  :mode (("\\.org\\'" . org-mode)
         ("TODO\\'"   . org-mode)
         ("README\\'"   . org-mode))
  :bind*  (("C-c a" . org-agenda)
           ("C-c c" . org-capture)
           ("C-c C-w" . org-refile))
  :config
  ;;; export settings

  (with-eval-after-load 'ox-latex
    ;; No default ugly red box from hyperref
    (add-to-list
     'org-latex-default-packages-alist
     "\\PassOptionsToPackage{hyperref}{hidelinks}")

    ;; Add memoir document class
    (add-to-list 'org-latex-classes
                 '("memoir"
                   "\\documentclass{memoir}"
                   ("\\chapter{%s}" . "\\chapter*{%s}")
                   ("\\section{%s}" . "\\section*{%s}")
                   ("\\subsection{%s}" . "\\subsection*{%s}")
                   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))

    ;; Add scrbook document class
    (add-to-list 'org-latex-classes
                 '("koma-book"
                   "\\documentclass{scrbook}"
                   ("\\part{%s}" . "\\part{%s}")
                   ("\\chapter{%s}" . "\\chapter{%s}")
                   ("\\section{%s}" . "\\section*{%s}")
                   ("\\subsection{%s}" . "\\subsection*{%s}")
                   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                   ("\\paragraph{%s}" . "\\paragraph*{%s}")))

    ;; Add scrartcl document class
    (add-to-list 'org-latex-classes
                 '("koma-article"
                   "\\documentclass{scrartcl}"
                   ("\\section{%s}" . "\\section*{%s}")
                   ("\\subsection{%s}" . "\\subsection*{%s}")
                   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                   ("\\paragraph{%s}" . "\\paragraph*{%s}")
                   ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

  ;; Start folded
  (setq org-startup-folded t)
  ;; Don't split the line at the cursor position. Go to the end of the line
  ;; before making a new line (courtesy of prot)
  (setq org-M-RET-may-split-line '((default . nil)))
  ;; Insert new heading after the current subtree (courtesy of prot)
  (setq org-insert-heading-respect-content t)
  ;; Insert state change notes and time stamps into a drawer
  (setq org-log-into-drawer t)
  ;; Record the time when an element was marked done/checked
  (setq org-log-done 'time)
  ;; Put archive files inside a directory
  (setq org-archive-location "archive/%s_archive::")
  ;; Include the inherited tags when archiving
  (setq org-archive-subtree-add-inherited-tags t)
  ;; Flushright tags to the 100 columns
  (setq org-tags-column -100)
  ;; Do not add empty line between heading and list items when M-RET is pressed
  ;; Courtesy of https://emacs.stackexchange.com/a/22111
  (setcdr (assoc 'plain-list-item org-blank-before-new-entry) nil)

  ;; Directory with org files (for capture templates and org agenda files)
  (setq org-directory "~/org")
  ;; All org files inside the org directory
  (setq org-agenda-files (list org-directory))

  ;; Todo keywords
  (setq org-todo-keywords
        '((sequence
           "TODO(t)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELLED(c@/!)")))

  ;; Use the date at point when capturing from agendas
  (setq org-capture-use-agenda-date t)

  (setq org-capture-templates
        '(
          ("t" "TODO Item"
           entry (file "~/org/todos.org")
           "* TODO [#B] %? %^g\n"
           :empty-lines 0)

          ("j" "Journal Entry"
           entry (file+datetree "~/org/journal.org")
           "* %?"
           :empty-lines 1)

          ("m" "Meeting"
           entry (file+datetree "~/org/meetings.org")
           "* %? :meeting:%^g \n** Attendees\n - \n** Notes\n** Action Items\n*** TODO [#A] "
           :tree-type week
           :clock-in t
           :clock-resume t
           :empty-lines 0)

          ("n" "Note"
           entry (file+headline "~/org/notes.org" "Random Notes")
           "** %?"
           :empty-lines 0)
          ))

  (setq org-tag-alist
        '(;; Places
          (:startgroup . nil)
          ("@home" . ?h)
          ("@work" . ?w)
          (:endgroup . nil)

          ;; Device
          (:startgroup . nil)
          ("@computer" . ?C)
          ("@phone" . ?P)
          (:endgroup . nil)

          ;; Activities
          (:startgroup . nil)
          ("@programming" . ?p)
          ("@email" . ?e)
          ("@calls" . ?a)
          ("@chore" . ?c)
          ("@errands" . ?r)
          ("@study" . ?s)
          ("@reading" . ?R)
          (:endgroup . nil)

          ;; Git & GitHub
          (:startgroup . nil)
          ("@issue" . ?I)
          ("@pr" . ?M)                       ; [M]: [M]erge request
          (:endgroup . nil))))

;;;; [ido]
;; https://www.masteringemacs.org/article/introduction-to-ido-mode
(use-package ido
  :ensure nil
  :config
  (setq ido-file-history t)
  (setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  (setq ido-use-filename-at-point nil)
  (setq ido-create-new-buffer 'always)
  (setq-default confirm-nonexistent-file-or-buffer nil)
  (setq ido-file-extensions-order
        '(".vim" ".org" ".c" ".h" ".C" ".H" ".cpp" ".hpp" ".cc" ".hh"
          ".md" ".txt" ".py" ".emacs" ".xml" ".el" ".ini" ".cfg" ".cnf"))
  (setq ido-ignore-extensions t)
  (setq completion-ignored-extensions
        (append '(".rbc")
                completion-ignored-extensions))
  (ido-mode 1))

;;;; [ediff]
(use-package ediff
  :ensure nil
  :custom
  ;; Necessary
  (ediff-split-window-function 'split-window-horizontally)
  (ediff-window-setup-function 'ediff-setup-window-plain)

  (ediff-keep-variants nil)
  (ediff-make-buffers-readonly-at-startup nil)
  (ediff-merge-revisions-with-ancestor t)
  (ediff-show-clashes-only t))

;;;; [project]
(use-package project
  :ensure nil
  :config
  (setq project-vc-extra-root-markers '(".project" ".bare"))
  (setopt project-switch-commands #'project-dired))

;;;; [editorconfig]
(use-package editorconfig
  :ensure nil
  :config
  (editorconfig-mode 1))

;;;; [undo-fu] Undo helper with redo
(use-package undo-fu
  :ensure t
  :config
  (global-set-key (kbd "C-/") 'undo-fu-only-undo)
  (global-set-key (kbd "M-_") 'undo-fu-only-redo))

;;;; [vundo] Visualize the undo tree.
(use-package vundo
  :ensure t
  :bind ("C-x C-u" . vundo))

;; (non-essential) academic-phrases
;; (use-package academic-phrases
;;  :ensure t)

;;;; [magit]
(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

;;;; [markdown-mode]
(use-package markdown-mode
  :ensure t
  :after edit-indirect
  ;; :hook
  ;; ((gfm-mode markdown-mode) . (lambda () (visual-line-mode)))
  :mode (("\\.md\\'" . gfm-mode))
  :custom
  (markdown-enable-math t)
  (markdown-enable-html t)
  (markdown-enable-wiki-links t)
  (markdown-asymmetric-header t)
  (markdown-nested-imenu-heading-index t)
  (markdown-fontify-code-blocks-natively t)
  :config
  (with-eval-after-load 'markdown-mode
    ;; Map 'console' code blocks to sh-mode
    (add-to-list 'markdown-code-lang-modes '("console" . sh-mode))
    ;; Map 'foam' code blocks to c++-mode
    (add-to-list 'markdown-code-lang-modes '("foam" . c++-mode))
    ;; Map 'math' code blocks to latex-mode
    (add-to-list 'markdown-code-lang-modes '("math" . latex-mode))))

;;;; [edit-indirect]
(use-package edit-indirect
  :ensure t
  :commands edit-indirect)

;;;; [multiple-cursor]
(use-package multiple-cursors
  :ensure t
  :bind (("C->" . mc/mark-next-like-this-symbol)
         ("C-<" . mc/mark-previous-like-this-symbol)
         ("C-c C-<" . 'mc/mark-all-like-this)
         ("C-S-c C-S-c" . 'mc/edit-lines)
         ("C-\"" . 'mc/skip-to-next-like-this)
         ("C-:" . 'mc/skip-to-previous-like-this)))

;; ;; [auctex]
;; (use-package tex
;;   :ensure t
;;   :config
;;   (setq TeX-parse-self t             ; parse on load
;;         TeX-auto-save t              ; parse on save
;;         ;; Use hidden directories for AUCTeX files.
;;         TeX-auto-local ".auctex-auto"
;;         TeX-style-local ".auctex-style"
;;         TeX-source-correlate-mode t
;;         TeX-source-correlate-method 'synctex
;;         ;; Don't start the Emacs server when correlating sources.
;;         TeX-source-correlate-start-server nil
;;         ;; Automatically insert braces after sub/superscript in `LaTeX-math-mode'.
;;         TeX-electric-sub-and-superscript t
;;         ;; Just save, don't ask before each compilation.
;;         TeX-save-query nil))

(use-package gnuplot
  :ensure t
  :mode (("\\.gp\\'"      . gnuplot-mode)
         ("\\.gnuplot\\'" . gnuplot-mode)
         ("\\.plt\\'"     . gnuplot-mode)
         ("\\.gpi\\'"     . gnuplot-mode)))

(use-package cmake-mode
  :ensure t
  :mode (("\\.cmake\\'"      . cmake-mode)
         ("CMakeLists\\.txt\\'" . cmake-mode)))


;; -------------
;; END OF CONFIG

;; Make gc pauses faster by decreasing the threshold.
;; --------------------------------------
(setq gc-cons-threshold (* 2 1000 1000))
;; --------------------------------------

;; Useful References
;;
;; 1. Prot: https://protesilaos.com/emacs/dotemacs
;;
