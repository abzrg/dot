;; use cmd instead of meta (on macos)
;; TODO check for os
(setq mac-command-modifier 'meta)

;; bind find file to an easier key chord
(global-set-key (kbd "M-p") 'find-file)

;; undo/redo (make use of annoying C-x C-u)
(global-set-key (kbd "M-[") 'undo-fu-only-undo)
(global-set-key (kbd "M-]") 'undo-fu-only-redo)
(global-set-key (kbd "C-x C-u") 'undo-fu-only-undo)
(global-set-key (kbd "C-x u") 'undo-fu-only-undo)

;; saving in tmux sucks because i use <c-s> as suffix
(global-set-key
 (kbd "C-x s")
 #'(lambda ()
     (interactive)
     (if (buffer-modified-p)
         (save-buffer (buffer-file-name))
       (message "(No changes need to be saved)"))))

(global-set-key
 (kbd "M-s M-s")
 #'(lambda ()
     (interactive)
     (if (buffer-modified-p)
         (save-buffer (buffer-file-name))
       (message "(No changes need to be saved)"))))


;; A better interface for recentf
(require 'recentf-minibuffer-dialog)
(global-set-key (kbd "M-s M-r") 'recentf-minibuffer-dialog)


;; ffap -- find-file-at-point
(global-set-key (kbd "M-s M-f") 'find-file-at-point)
