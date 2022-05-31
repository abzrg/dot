;; Some UI settings
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)

;; Font settings
(set-face-attribute 'default nil :font "Menlo" :height 180)
(set-face-attribute 'fixed-pitch nil :font "Menlo" :height 180)
(setq default-frame-alist '((font . "Menlo-18")))

;; ;; Theme settings
(load-theme 'gruber-darker t)
(custom-theme-set-faces
 'gruber-darker
 `(org-block ((t (:foreground "#565f73"))))
 `(shadow ((t (:foreground "#565f73")))))
;;(add-to-list 'default-frame-alist '(background-color . "honeydew"))

(column-number-mode)
(global-display-line-numbers-mode t)

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
;; M-x recentf-open-file
(recentf-mode 1)

;; auto close bracket insertion. New in emacs 24
(electric-pair-mode 1)
;; make electric-pair-mode work on more brackets
(setq electric-pair-pairs
      '(
        (?\" . ?\")
        (?\{ . ?\})))


;;;; whitespace mode

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
                    :background "grey22"
                    :foreground "darkgray"
                    :weight 'bold)
(set-face-attribute 'whitespace-trailing nil
                    :background "grey22"
                    :foreground "darkgray"
                    :weight 'normal)
(add-hook 'prog-mode-hook 'whitespace-mode)
(add-hook 'prog-mode-hook 'whitespace-mode)

;; view whitespace in diff for checking up bad whitespace before
;; committing
(add-hook 'diff-mode-hook (lambda ()
                            (setq-local whitespace-style
                                        '(face
                                          tabs
                                          tab-mark
                                          spaces
                                          space-mark
                                          trailing
                                          indentation::space
                                          indentation::tab
                                          newline
                                          newline-mark))
                            (whitespace-mode 1)))


;; ------------------ bindings ------------

;; use cmd instead of meta (on macos)
(setq mac-command-modifier 'meta)

;; copy-paste (macos compliant)
;;(global-set-key (kbd "M-v") 'yank)
;;(global-set-key (kbd "M-c") 'kill-ring-save)

;; undo/redo
(global-set-key (kbd "M-[") 'undo-fu-only-undo)
(global-set-key (kbd "M-]") 'undo-fu-only-redo)

;; better dynamic abbrev
(global-set-key [remap dabbrev-expand] 'hippie-expand)

;; zap trailing blanks
(global-set-key (kbd "C-c z") 'delete-trailing-whitespace)

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

;; ---

;; theme
(use-package vscode-dark-plus-theme
  :ensure t)

(use-package modus-themes
  :ensure t)
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
;;(use-package iedit
;;  :ensure t)

;; emacs mode for markdown
(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))


(use-package lua-mode
  :ensure t)


;; (add-hook 'ido-setup-hook
;;           (lambda ()
;;             (define-key ido-completion-map [up] 'previous-history-element)))
;; (setq ido-enable-flex-matching t)
;; (setq ido-everywhere t)
;; (ido-mode 1)
;; ;; Display recent files in the "buffer" part.
;; (setq ido-use-virtual-buffers t)
;; (setq ido-create-new-buffer 'always)
;; (setq ido-file-extensions-order '(".c" ".cpp" ".cc" ".h" ".org" ".txt" ".py" ".emacs" ".xml" ".el" ".ini" ".cfg" ".cnf"))

;; ;; smex completion
;; (require 'smex) ; Not needed if you use package.el
;; (smex-initialize) ; Can be omitted. This might cause a (minimal) delay
;;                                         ; when Smex is auto-initialized on its first run.
;; (global-set-key (kbd "M-x") 'smex)
;; (global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; ;; This is your old M-x.
;; (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)



(use-package vertico
  :ensure t
  :init
  (vertico-mode)

  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  ;; (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  (setq vertico-cycle t)
  :config
  (vertico-flat-mode)
)

(use-package ansi-color
  :config
  (defun my-colorize-compilation-buffer ()
    (when (eq major-mode 'compilation-mode)
      (ansi-color-apply-on-region compilation-filter-start (point-max))))
  :hook (compilation-filter . my-colorize-compilation-buffer))


;;--------------------------

;; C/C++

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(setq-default c-basic-offset 4)
(setq c-default-style "linux"
      c-basic-offset 4)

;; (global-set-key (kbd "M-[") 'undo-fu-only-undo)
;; (add-hook 'c-mode-hook
;;     (lambda ()
;;         (define-key coffee-mode-map (kbd "C-c c") 'coffee-compile-file)))


(setq async-shell-command-display-buffer nil)

(defun clang-foramt ()
  "Sum argument number and"
  (interactive)
  (save-buffer)
  (async-shell-command (concat "clang-format -i -style=file " (buffer-file-name))))


(with-eval-after-load 'c-mode
  (define-key c-mode-map (kbd "C-c f") 'clang-format))


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


;; -----------------------------------

;; Latex

;; source: https://www.lvguowei.me/post/emacs-orgmode-minted-setup/
(setq org-latex-listings 'minted
      org-latex-packages-alist '(("" "minted"))
      org-latex-pdf-process
      '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
;; Prevent src block line too long
(setq org-latex-minted-options '(("breaklines" "true")
                                 ("breakanywhere" "true")
                                 ("frame" "single")
                                 ("linenos=true")))
