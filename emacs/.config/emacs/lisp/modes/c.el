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

;; clang-tidy
(defun clang-tidy ()
  (interactive)
  (setq compile-command-orig (symbol-value 'compile-command))
  (compile "clang-tidy -checks='*' *.[ch] ")
  (setq compile-command (symbol-value 'compile-command-orig)))


(add-hook 'c-mode-hook
          (lambda ()
            (define-key c-mode-map (kbd "C-c f")
                        'clang-format)))

(add-hook 'c++-mode-hook
          (lambda ()
            (define-key c-mode-map (kbd "C-c f")
                        'clang-format)))


;; Quickly Switch between header/source files
(add-hook 'c-mode-common-hook
  (lambda()
    (local-set-key  (kbd "C-c o") 'ff-find-other-file)))
