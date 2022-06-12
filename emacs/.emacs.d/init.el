;; Some UI settings
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)

(defun my/disable-scroll-bars (frame)
  (modify-frame-parameters frame
                           '((vertical-scroll-bars . nil)
                             (horizontal-scroll-bars . nil))))
(add-hook 'after-make-frame-functions 'my/disable-scroll-bars)

;; Font settings
(set-face-attribute 'default nil :font "Menlo" :height 180)
(set-face-attribute 'fixed-pitch nil :font "Menlo" :height 180)
(setq default-frame-alist '((font . "Menlo-18")))

;; ;; Theme settings
;; (load-theme 'gruber-darker t)
;; (custom-theme-set-faces
;;  'gruber-darker
;;  `(org-block ((t (:foreground "#565f73"))))
;;  `(shadow ((t (:foreground "#565f73")))))
;; ;;(add-to-list 'default-frame-alist '(background-color . "honeydew"))
(load-theme 'modus-operandi t)

(column-number-mode)
;;(global-display-line-numbers-mode t)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Completely disable alarms
(setq ring-bell-function 'ignore)

;; start the initial frame maximized
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
;; start every frame maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Don't jump when cursor passess the edge of the screen through scrolling
(setq scroll-conservatively 101)

;; Remember where you where
(require 'saveplace)
(setq save-place-file "~/.emacs.d/saveplace")
(save-place-mode +1)

;; Remeber minibuffer history
(setq history-length 25)

;; Move customization variables to a separate file and load it
(setq custom-file (locate-user-emacs-file "custom-var.el"))
(load custom-file 'noerror 'nomessage)

;; Revert buffer when the underlying file has changed
(global-auto-revert-mode 1)

;; Don't pop-up UI dialog when prompting
(setq use-dialog-box nil)

;; Remember recently opened files
;; M-x recentf-open-file
(recentf-mode 1)

;; auto close bracket insertion. New in emacs 24
(electric-pair-mode 1)
;; make electric-pair-mode work on more brackets
(setq electric-pair-pairs
      '(
        (?\" . ?\")
        (?\{ . ?\})))


;; whitespace mode
;; src: https://www.reddit.com/r/emacs/comments/2keh6u/comment/cll0l03/?utm_source=share&utm_medium=web2x&context=3
(require 'whitespace)
(setq whitespace-display-mappings
   ;; all numbers are Unicode codepoint in decimal. try (insert-char 182 ) to see it
  '(
    (space-mark 32 [183] [46]) ; 32 SPACE, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
    (newline-mark 10 [182 10]) ; 10 LINE FEED
    (tab-mark 9 [187 9] [9655 9] [92 9]) ; 9 TAB, 9655 WHITE RIGHT-POINTING TRIANGLE 「▷」
    ))
(setq whitespace-style '(face tabs trailing tab-mark))
(set-face-attribute 'whitespace-tab nil
                    :background "#f0f0f0"
                    :foreground "#00a8a8"
                    :weight 'bold)
(set-face-attribute 'whitespace-trailing nil
                    :background "#e4eeff"
                    :foreground "#183bc8"
                    :weight 'normal)
(add-hook 'prog-mode-hook 'whitespace-mode)


;; ------------------ bindings ------------

;; use cmd instead of meta (on macos)
(setq mac-command-modifier 'meta)

;; copy-paste (macos compliant)
;;(global-set-key (kbd "M-v") 'yank)
;;(global-set-key (kbd "M-c") 'kill-ring-save)

;; undo/redo
(global-set-key (kbd "M-[") 'undo-fu-only-undo)
(global-set-key (kbd "M-]") 'undo-fu-only-redo)

;; use C-w for killing words backward
;; src: https://stackoverflow.com/a/14047437/13041067
(defun kill-region-or-backward-word ()
  "If the region is active and non-empty, call `kill-region'.
Otherwise, call `backward-kill-word'."
  (interactive)
  (call-interactively
   (if (use-region-p) 'kill-region 'backward-kill-word)))
(global-set-key (kbd "C-w") 'kill-region-or-backward-word)


;; Packages ----------------------------
;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)


(use-package vertico
  :ensure t
  :bind (:map vertico-map
              ("C-n" . vertico-next)
              ("C-p" . vertico-previous)
              ("C-f" . vertico-exit)
              :map minibuffer-local-map
              ("M-h" . backward-kill-word))
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

(use-package savehist
  :init
  (savehist-mode 1))

(use-package marginalia
  :after vertico
  :ensure t
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))


;; Org mode epub export
(use-package ox-epub
  :ensure t)


;; better undo/redo
(use-package undo-fu
  :ensure t)


;; autocomplet
(use-package auto-complete
  :ensure t
  :config
  (ac-config-default)
  (global-auto-complete-mode t))


;; snippets
(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :ensure t)


;; autocomplete C-headers
(use-package auto-complete-c-headers
  :ensure t
  :config
  (defun my:ac-c-headers-init ()
    (require 'auto-complete-c-headers)
    (add-to-list 'ac-sources 'ac-source-c-headers)
    (add-to-list 'achead:include-directories '"/Library/Developer/CommandLineTools/SDKs/MacOSX12.3.sdk/usr/include"))
  (add-hook 'c++-mode-hook 'my:ac-c-headers-init)
  (add-hook 'c-mode-hook 'my:ac-c-headers-init))


;; ;; latex package
;; (use-package auctex
;;   :ensure t)
(add-to-list 'load-path "~/.emacs.d/lisp/auctex")
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

;; autocomplete math
(use-package ac-math
  :ensure t)

(use-package auto-complete-auctex
  :ensure t
  :config
  (add-to-list 'ac-modes 'latex-mode))

;; clean auto indent mode
(use-package clean-aindent-mode
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'clean-aindent-mode))


;; ws-butler mode (remove trailing whitespace on save)
(use-package ws-butler
  :ensure t
  :config
  (add-hook 'c-mode-common-hook 'ws-butler-mode))


;; markdown mode
(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))

;; lua mode
(use-package lua-mode
  :ensure t)



;;--------------------------

;; C/C++

;; article on setting up emacs for c/c++
;; https://tuhdo.github.io/c-ide.html


(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(setq-default c-basic-offset 4)

;; Braces on the newline and not indented
(setq c-default-style "bsd")

;; Turn this:
;;
;; int i[] =
;;     {
;;         1, 2, 3, 4, 5
;;     }
;;
;; To:
;;
;; int i[] =
;; {
;;     1, 2, 3, 4, 5
;; }
;;
;; use: M-x c-show-syntactic-information
(require 'cc-mode)
(add-to-list 'c-offsets-alist '(statement-cont . 0))


;; better gdb layout
(setq
 ;; use gdb-many-windows by default
 gdb-many-windows t

 ;; Non-nil means display source file containing the main routine at startup
 gdb-show-main t)


;; If there is no output for an async shell command don't bother
;; popping up
(add-to-list 'display-buffer-alist '("*Async Shell Command*" display-buffer-no-window (nil)))

;; clang-format
(defun clang-format ()
  (interactive)
  (save-buffer)
  (async-shell-command
   (concat "clang-format -style=file -i "
           (buffer-file-name)))
  (revert-buffer-quick))

(add-hook 'c-mode-hook
          (lambda ()
            (define-key c-mode-map (kbd "C-c f")
                        'clang-format)))


;; ---------------------------------
;; Latex


(defun my-ac-latex-mode () ; add ac-sources for latex
   (setq ac-sources
         (append '(ac-source-math-unicode
           ac-source-math-latex
           ac-source-latex-commands)
                 ac-sources)))
(add-hook 'LaTeX-mode-hook 'my-ac-latex-mode)



;; ---------------------------------
;; Python

(use-package jedi
  :ensure t
  :config
  (add-hook 'python-mode-hook 'jedi:setup)
  ;; optional
  (setq jedi:complete-on-dot t))




;; ---------------------------------
;; Terminal

;; terminal with unique name
(defun terminal ()
  (interactive)
  (term "/opt/homebrew/bin/zsh")
  (rename-uniquely))

(global-set-key "\C-z" 'terminal)

;; Kill terminal buffer upon exit
;; src: https://emacs.stackexchange.com/a/64855/30552
(defun terminal-handle-exit (&optional process-name msg)
  (message "%s | %s" process-name msg)
  (kill-buffer (current-buffer)))
(advice-add 'term-handle-exit :after 'terminal-handle-exit)


;; ---------------------------------
;; Coloize compilation buffer
;;;; colorize output in compile buffer
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (ansi-color-apply-on-region compilation-filter-start (point-max)))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)



;; ---------------------------------
;; emacsclient not loading setting
(defun load-confg-fully ()
  (interactive)
  (load "~/.emacs.d/init.el"))
