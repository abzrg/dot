(add-to-list 'load-path (concat user-emacs-directory "lisp/" ))
(add-to-list 'load-path (concat user-emacs-directory "themes/" ))

(load "basics.el" nil t t)
(load "whitespaces.el" nil t t)
(load "bindings.el" nil t t)
(load "packages.el" nil t t)
(load "modes.el" nil t t)
(load "openfoam.el"nil t t)
