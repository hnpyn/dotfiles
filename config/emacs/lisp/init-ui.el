(when (display-graphic-p)
  (scroll-bar-mode -1)
  (set-face-attribute 'default nil :height 120))

(setq inhibit-startup-screen t)
(setq visible-bell t)

(tool-bar-mode -1)
(menu-bar-mode -1)
(global-display-line-numbers-mode t)
(column-number-mode)

(set-face-attribute
 'default nil :font
 (font-spec :family "Liga SFMono Nerd Font" :size 16))

(use-package dashboard
  :ensure t
  :config
  (setq dashboard-banner-logo-title "Welcome to Emacs!")
  ;; (setq dashboard-projects-backend 'projectile) 
  (setq dashboard-startup-banner 'official)
  (setq dashboard-items '((recents  . 5)
			  (bookmarks . 5)
			  (projects . 10)))
  (dashboard-setup-startup-hook))

;; (use-package gruvbox-theme
;;   :config
;;   (load-theme 'gruvbox-dark-medium t))

(use-package catppuccin-theme
  :config
  (load-theme 'catppuccin :no-confirm)
  (setq catppuccin-flavor 'mocha) ; 'latte, 'frappe, 'macchiato, or 'mocha
  (catppuccin-reload))

(use-package smart-mode-line
  :config
  (setq custom-safe-themes t)
  (setq sml/theme 'dark)
  (sml/setup))

(use-package all-the-icons
  :if (display-graphic-p))

(provide 'init-ui)
