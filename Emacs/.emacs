(require 'package)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(setq package-selected-packages '(lsp-mode yasnippet lsp-treemacs helm-lsp
					   projectile  hydra flycheck company
					   avy which-key helm-xref dap-mode
					   clang-format use-package
					   emmet-mode))

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

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)  ;; clangd is fast

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

(global-set-key [f8] 'treemacs)
(setq clang-format-style "gnu")

; Before saving, format the code
(defun c-format-on-save ()
  (add-hook 'before-save-hook #'clang-format-buffer nil 'local))

(add-hook 'c-mode-hook 'c-format-on-save)

(setq inhibit-splash-screen t)
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(global-display-line-numbers-mode)
(add-hook 'prog-mode-hook 'column-number-mode)

(require 'whitespace)
(setq whitespace-line-column 80)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(add-hook 'prog-mode-hook 'whitespace-mode)

; Emmet
(add-hook 'html-mode-hook 'emmet-mode)
