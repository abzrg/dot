(setq mac-command-modifier 'meta)
(org-babel-load-file
 (expand-file-name
  "config.org"
  user-emacs-directory))
(put 'LaTeX-narrow-to-environment 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(yasnippet zenburn-theme nasm-mode gruber-darker-theme git-modes editorconfig edit-indirect dockerfile-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
