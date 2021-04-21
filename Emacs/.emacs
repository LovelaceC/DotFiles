(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
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
(define-key global-map [remap switch-to-buffer] #'heml-mini)

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
(bind-key "<f8>" 'treemacs)

; Mapped some lsp keybinds
(defun add-c-keys()
					; Rename symbol/function at point
  (local-set-key (kbd "M-l r") 'lsp-rename)
					; Find definitions
  (local-set-key (kbd "M-l g g") 'xref-find-definitions)
					; Find references
  (local-set-key (kbd "M-l g r") 'xref-find-references)
					; Browse symbols in the current document
  (local-set-key (kbd "M-l h i") 'helm-imenu)
					; Find symbol in current project
  (local-set-key (kbd "M-l h w") 'helm-lsp-workspace-symbol)
					; Describes thing at point
  (local-set-key (kbd "M-l s d") 'lsp-describe-thing-at-point)
  )

; Before saving, format the code
(defun c-format-on-save()
  (add-hook 'before-save-hook #'lsp-format-buffer nil 'local))

; Add some hooks
(add-hook 'c-mode-hook 'add-c-keys)
(add-hook 'c-mode-hook 'c-format-on-save)

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

(require 'use-package)

(use-package lsp-ui)

(setq inhibit-splash-screen t)
(setq inhibit-startup-screen t)

(menu-bar-mode -1)

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
			  (bookmarks . 5)))
  (setq dashboard-startup-banner "~/.emacs.d/logo.txt")
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t))

(load-theme 'srcery t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("8bb9cbdc1fe6f4451b1e1361113cd6e24b784f82f33a0f4d6c5f8991aa32b28c" default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
