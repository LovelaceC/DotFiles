;;; package --- Summary
;;; Commentary:
(require 'package)

;;; Code:
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(use-package try :ensure t)
(use-package which-key :ensure t :config (which-key-mode))

(require 'yasnippet)
(yas-global-mode 1)

(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)
    ))

(use-package auto-complete
  :ensure t
  :init
  (global-flycheck-mode t))

(use-package magit
  :ensure t
  :init
  (progn
    (bind-key "C-x g" 'magit-status)))

(use-package neotree
  :ensure t
  :init
  (progn
    (bind-key "<f8>" 'neotree-toggle)))

(require 'clang-format)
(setq clang-format-style "gnu")

(defun clang-format-on-save()
  ;;; "Adds a hook so the code is formatted before its content is written to a file"
  (add-hook 'before-save-hook #'clang-format-buffer nil 'local))
(add-hook 'c-mode-hook 'clang-format-on-save)
(add-hook 'c++-mode-hook 'clang-format-on-save)

(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

(menu-bar-mode -1)

(require 'whitespace)
(setq whitespace-line-column 80)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(add-hook 'prog-mode-hook 'whitespace-mode)

(use-package dashboard
  :ensure t
  :init
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 5)
			  (bookmarks . 5)))
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-startup-banner "~/.emacs.d/img/logo.png")
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t))
