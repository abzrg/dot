;; initialize package source
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

;; --------------------------------------------------------- ;;

(use-package xclip
  :config
  (xclip-mode 1))


;; --------------------------------------------------------- ;;

(use-package multiple-cursors
  :config
  ;; let unkown commands to run for all cursors
  (setq mc/always-run-for-all 1)
  (global-set-key (kbd "C-M-<mouse-1>") 'mc/add-cursor-on-click)
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this))


;; ;; --------------------------------------------------------- ;;

;; (use-package org-download
;;   :config
;;   ;; Drag-and-drop to `dired`
;;   (add-hook 'dired-mode-hook 'org-download-enable))


;; --------------------------------------------------------- ;;

(use-package markdown-mode
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))


;; --------------------------------------------------------- ;;

(use-package yaml-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
  (add-hook 'yaml-mode-hook
            #'(lambda ()
               (define-key yaml-mode-map "\C-m" 'newline-and-indent))))


;; --------------------------------------------------------- ;;

(use-package magit
  :ensure t
  :init
  (progn
    (bind-key "C-x g" 'magit-status)))


;; --------------------------------------------------------- ;;

(use-package lua-mode)


;; --------------------------------------------------------- ;;

(use-package modern-cpp-font-lock)



  ;; auctex
  ;; lua-mode
  ;; magit
  ;; markdown-mode
  ;; modern-cpp-font-lock
  ;; multiple-cursors
  ;; transpose-frame
  ;; undo-fu
  ;; use-package
  ;; xclip
  ;; yaml-mode
