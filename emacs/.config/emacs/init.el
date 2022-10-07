(add-to-list 'load-path (concat user-emacs-directory "lisp/" ))
(add-to-list 'load-path (concat user-emacs-directory "themes/" ))

(load "gruber-darker-theme.el")
(load "basics.el" nil t t)
(load "whitespaces.el" nil t t)
(load "bindings.el" nil t t)
(load "packages.el" nil t t)
(load "majors.el" nil t t)
