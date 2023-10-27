;; cleaner ui
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; line numbers
(setq-default display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Set text width
(setq-default fill-column 80)

;; highlight current line
;;(global-hl-line-mode +1)
;;(add-hook 'term-mode-hook (lambda () (setq-local global-hl-line-mode nil))) ; disable in term mode
;;(set-face-attribute 'hl-line nil :background "gainsboro")

;; theme
;; (add-to-list 'custom-theme-load-path "~/.config/emacs/themes/")
;; (set-background-color "gray90")
;; (set-foreground-color "gray10")
;; (add-to-list 'default-frame-alist '(foreground-color . "gray10"))
;; (add-to-list 'default-frame-alist '(background-color . "gray90"))
(load-theme 'naysayer t)
;; (set-face-attribute 'region nil :background "light gray")

;; (set-face-attribute 'line-number-current-line nil :background nil :foreground "black")
;; (set-face-italic 'font-lock-comment-face nil) ; Make comments italic

;; Cursor shape
;;(setq-default cursor-type 'bar)

;; font
(set-face-attribute 'default nil :font "sfmono nerd font" :height 180)
(set-face-attribute 'fixed-pitch nil :font "sfmono nerd font" :height 180)
(setq default-frame-alist '((font . "sfmono nerd font-18")))

;; disable backup files
(setq make-backup-files nil)

;; disable autosave
(setq auto-save-default nil)

;; remeber where you where recently
(require 'saveplace)
(setq save-place-file "~/.config/emacs/saveplace")
(save-place-mode +1)

;; keep a list of recently opened files
;; source: https://www.emacswiki.org/emacs/RecentFiles
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(setq-default recent-save-file "~/.config/emacs/.recentf")

;; call `recentf-save-list` periodically, e.g. every 5 minutes
;; source: https://www.emacswiki.org/emacs/RecentFiles
(run-at-time nil (* 5 60) 'recentf-save-list)

;; save minibuffer history (https://stackoverflow.com/a/1230877/13041067)
(savehist-mode +1)
;;(setq savehist-additional-variables '(kill-ring search-ring regexp-search-ring))
(setq savehist-file "~/.config/emacs/.savehist")

;; remember minibuffer history
(setq history-length 25)

;; hey emacs, don't write to this file!
(setq custom-file (locate-user-emacs-file "custom-var.el"))
(load custom-file 'noerror 'nomessage)

;; revert buffer when the underlying file has changed
(global-auto-revert-mode 1)

;; Auto close bracket
(electric-pair-mode 1)
;; No delay when deleting pairs
(setq-default delete-pair-blink-delay 0)
(setq electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit)
(setq electric-pair-preserve-balance t)
(setq electric-pair-pairs
      '((8216 . 8217)
        (8220 . 8221)
        (171 . 187)))
(setq electric-pair-skip-self 'electric-pair-default-skip-self)
(setq electric-pair-skip-whitespace nil)
(setq electric-pair-skip-whitespace-chars '(9 10 32))
(setq electric-quote-context-sensitive t)
(setq electric-quote-paragraph t)
(setq electric-quote-string nil)
(setq electric-quote-replace-double t)

;; disable alarms
(setq ring-bell-function 'ignore)

;; start the initial frame maximized
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; start every frame maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Don't jump when cursor passess the edge of the screen through scrolling
(setq scroll-conservatively 101)

;; Show column number
(column-number-mode +1)

;; Don't pop-up UI dialog when prompting
(setq use-dialog-box nil)

;; Disable stupid cursor jump in latex when you do $$
(setq blink-matching-paren nil)

;; Always follow symlinks in a version-controlled path
(setq vc-follow-symlinks t)
