;; Some UI settings
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)

;; Font settings
(set-face-attribute 'default nil :font "MonacoB Nerd Font Mono" :height 170)
(set-face-attribute 'fixed-pitch nil :font "MonacoB Nerd Font Mono" :height 170)
(setq default-frame-alist '((font . "MonacoB Nerd Font Mono-17")))

;; Theme settings
(load-theme 'gruber-darker t)
(custom-theme-set-faces
 'gruber-darker
 `(org-block ((t (:foreground "#565f73"))))
 `(shadow ((t (:foreground "#565f73")))))
;;(add-to-list 'default-frame-alist '(background-color . "honeydew"))

(column-number-mode)
;;(global-display-line-numbers-mode t)

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
(savehist-mode 1)

;; Move customization variables to a separate file and load it
(setq custom-file (locate-user-emacs-file "custom-var.el"))
(load custom-file 'noerror 'nomessage)

;; Revert buffer when the underlying file has changed
(global-auto-revert-mode 1)

;; Don't pop-up UI dialog when prompting
(setq use-dialog-box nil)

;; Remember recently opened files
;;	M-x recentf-open-file
(recentf-mode 1)

;; auto close bracket insertion. New in emacs 24
(electric-pair-mode 1)
;; make electric-pair-mode work on more brackets
(setq electric-pair-pairs
      '(
        (?\" . ?\")
        (?\{ . ?\})))


;; ------------------ bindings ------------

;; use cmd instead of meta (on macos)
(setq mac-command-modifier 'meta)

;; copy-paste (macos compliant)
;;(global-set-key (kbd "M-v") 'yank)
;;(global-set-key (kbd "M-c") 'kill-ring-save)

;; undo/redo
(global-set-key (kbd "M-[") 'undo-fu-only-undo)
(global-set-key (kbd "M-]") 'undo-fu-only-redo)


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


;; multiple cursor
(use-package iedit
  :ensure t)

;;--------------------------

;; C/C++

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(setq-default c-basic-offset 4)
(setq c-default-style "linux"
      c-basic-offset 4)


;; -----------------------------------
;; use C-w for killing words backward
;; source: https://stackoverflow.com/a/14047437/13041067
(defun kill-region-or-backward-word ()
  "If the region is active and non-empty, call `kill-region'.
Otherwise, call `backward-kill-word'."
  (interactive)
  (call-interactively
   (if (use-region-p) 'kill-region 'backward-kill-word)))

(global-set-key (kbd "C-w") 'kill-region-or-backward-word)
