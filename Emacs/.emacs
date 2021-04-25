(require 'package)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(setq package-selected-packages '(lsp-mode yasnippet lsp-treemacs helm-lsp
					   projectile hydra flycheck company avy
					   which-key helm-xref dap-mode))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

(helm-mode)
(require 'helm-xref)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)

(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

(setq gc-cons-treshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'ls-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

; Open treemacs when the <f8> key is pressed
(global-set-key [f8] 'treemacs)

; Include clang-format
(require 'clang-format)
(setq clang-format-style "gnu")

; Before saving, format the code
(defun c-format-on-save()
  (add-hook 'before-save-hook #'clang-format-buffer nil 'local))

(add-hook 'c-mode-hook 'c-format-on-save)

(require 'use-package)

(use-package lsp-ui)

; lsp ui
(add-hook 'c-mode-hook 'lsp-ui-mode)

; lsp sideline
(setq lsp-ui-sideline-show-diagnostics nil)
(setq lsp-ui-sideline-show-hover t)
(setq lsp-ui-sideline-show-code-actions t)
(setq lsp-ui-sideline-delay 0)

; lsp doc
(setq lsp-ui-doc-enable t)
(setq lsp-ui-doc-delay 0)

(setq inhibit-splash-screen t)
(setq inhibit-startup-screen t)

(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

(require 'whitespace)
(setq whitespace-line-column 80)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(add-hook 'prog-mode-hook 'whitespace-mode)

(use-package magit
  :ensure t
  :init
  (progn
    (bind-key "C-x g" 'magit-status)))

(use-package dashboard
  :ensure t
  :init
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 5)
			  (bookmarks . 5)
			  (projects . 5)))
  (setq dashboard-banner-logo-title "Real programers use Emacs :carita facherita fachera:")
  (setq dashboard-startup-banner "~/.emacs.d/lain.png")
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t))

; Load a theme
;(load-theme 'srcery t)

(use-package all-the-icons)

(require 'treemacs-all-the-icons)
(treemacs-load-theme "all-the-icons")
(treemacs-resize-icons 20)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package doom-themes
  :config
  ;; Global settings
  (setq doom-themes-enable-bold t
	doom-themes-enable-italic t)
  (load-theme 'doom-vibrant t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)

  ;;Enable custom treemacs theme
  (setq doom-themes-treemacs-theme "doom-colors")
  (doom-themes-treemacs-config)

  (doom-themes-org-config))

; Treemacs-magit
(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

;;; .emacs file end
