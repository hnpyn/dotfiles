;; load
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; module
(require 'packages)
(require 'init-keybinds)
(require 'init-editor)
(require 'init-ui)

;; perf
(add-hook 'emacs-startup-hook
          (lambda () (message "Emacs ready in %s seconds"
                              (emacs-init-time))))

