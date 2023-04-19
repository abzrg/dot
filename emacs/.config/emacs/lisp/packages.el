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

;; --------------------------------------------------------- ;;
(use-package undo-fu)

;; --------------------------------------------------------- ;;
(use-package transpose-frame)

;; --------------------------------------------------------- ;;
(use-package comment-dwim-2
  :config
  (global-set-key (kbd "M-;") 'comment-dwim-2)
  (define-key org-mode-map (kbd "M-;") 'org-comment-dwim-2))

;; --------------------------------------------------------- ;;
(use-package sr-speedbar
  :defer nil
  :commands (sr-speedbar-open)
  :init
  (setq
   speedbar-hide-button-brackets-flag t
   speedbar-indentation-width 2
   speedbar-show-unknown-files t
   speedbar-update-flag nil
   speedbar-use-images t)
  :config
  (global-set-key (kbd "M-s M-a") 'sr-speedbar-toggle))

;; --------------------------------------------------------- ;;
(use-package electric-operator
  :diminish
  :config
  (electric-operator-add-rules-for-mode
   'c-mode
   (cons "*" nil)
   (cons "/" nil))
  (electric-operator-add-rules-for-mode
   'c++-mode
   (cons "*" nil)
   (cons "/" nil)
   (cons "&" "& ")))

;; --------------------------------------------------------- ;;
(use-package comment-tags
  :diminish
  :config
  (autoload 'comment-tags-mode "comment-tags-mode")
  (setq comment-tags-keymap-prefix (kbd "C-c t"))
  (with-eval-after-load "comment-tags"
    ;; (setq comment-tags-keyword-faces
    ;;       `(("TODO" . ,(list :weight 'bold :foreground "#28ABE3"))
    ;;         ("FIXME" . ,(list :weight 'bold :foreground "#DB3340"))
    ;;         ("BUG" . ,(list :weight 'bold :foreground "#DB3340"))
    ;;         ("HACK" . ,(list :weight 'bold :foreground "#E8B71A"))
    ;;         ("KLUDGE" . ,(list :weight 'bold :foreground "#E8B71A"))
    ;;         ("XXX" . ,(list :weight 'bold :foreground "#F7EAC8"))
    ;;         ("INFO" . ,(list :weight 'bold :foreground "#F7EAC8"))
    ;;         ("DONE" . ,(list :weight 'bold :foreground "#1FDA9A"))))
    (setq comment-tags-comment-start-only t
          comment-tags-require-colon t
          comment-tags-case-sensitive t
          comment-tags-show-faces t
          comment-tags-lighter nil))
  (add-hook 'prog-mode-hook 'comment-tags-mode))

;; --------------------------------------------------------- ;;
;; Diminish (hide minor modes)
(use-package diminish
  :config
  (diminish 'eldoc-mode)
  (diminish 'global-whitespace-mode)
  (diminish 'abbrev-mode))

;; ;;--------------------------------------------------------- ;;
;; ;; evil
;; (use-package evil
;;   :config
;;   (evil-mode 1))


;; ---------------------------------------------------------

;; (use-package gmsh-mode)
