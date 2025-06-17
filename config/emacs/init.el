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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(gruvbox-theme smart-mode-line evil dashboard counsel catppuccin-theme all-the-icons)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
