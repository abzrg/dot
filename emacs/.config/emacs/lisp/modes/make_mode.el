;; Set default makefile type to gmake (Henry Weller)
(add-to-list 'auto-mode-alist
             '("\\(/\\|\\`\\)[Mm]akefile" . makefile-gmake-mode))

(add-to-list 'auto-mode-alist '("Makefile.*" . makefile-gmake-mode))
