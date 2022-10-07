;; If there is no output for an async shell command don't bother
;; popping up
(add-to-list 'display-buffer-alist '("*Async Shell Command*" dis\
play-buffer-no-window (nil)))
