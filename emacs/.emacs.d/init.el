;; add package repo
(require 'package)
(setq package-archives '(("gnu"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
                         ("melpa"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize) ;; You might already have this line

;; install use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (require 'use-package)
  (setq use-package-always-ensure t
        use-package-expand-minimally t))

;; install packages
;; instal company for auto completion
(use-package company
  :config
  (global-company-mode t)
  :custom
  (company-idle-delay 0.0 "Provide instant autocompletion."))

;; install magit for git
(use-package magit)

;; install yasnippet for code snippets
(use-package yasnippet
  :config
  (yas-reload-all)
  :hook ((prog-mode) . yas-minor-mode))

;; install rust-mode for rust
(use-package rust-mode
  :config
  (setq indent-tabs-mode nil)
  (setq rust-format-on-save t)
  (prettify-symbols-mode))

;; install lsp-mode for code
(use-package lsp-mode
  :hook ((c++-mode python-mode rust-mode) . lsp-deferred)
  :commands lsp)
;; install lsp-ui for better lsp ui
(use-package lsp-ui
  :commands lsp-ui-mode)

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  ;; The :init section is always executed.
  :config
  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode))

;; Enable vertico for minibuffer
(use-package vertico
  :config
  (vertico-mode))

(use-package projectile
  :config
  (projectile-mode +1)
  :bind (:map projectile-mode-map
         ("M-p" . projectile-command-map)))

;; appearence setup
;; install doom themes
(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; install doom mode line
(use-package doom-modeline
  :init (doom-modeline-mode 1))

;; set up builtin packages config
(use-package org
  :ensure nil
  :custom
  (org-directory "~/daily/org/")
  (org-catch-invisible-edits #'error "close org edit invisiable") 
  (org-todo-keywords '((sequence "TODO" "WORKING" "|" "DONE(d!)")) "set todo keywords")
  (org-default-notes-file (concat org-directory "/notes.org") "set org capture files")
  :bind (("C-c l" . org-store-link)
	 ("C-c a" . org-agenda)
	 ("C-c c" . org-capture))
  )

;; set variables
;; close backup
(setq make-backup-files nil)
;; Isearch convenience, space matches anything (non-greedy)
(setq search-whitespace-regexp ".*?")
;; global enabled mode
;; enable linum mode
(global-linum-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files 'org-directory)
 '(package-selected-packages
   '(doom-modeline doom-themes lsp-ui marginalia projectile vertico yasnippet rust-mode lsp-mode use-package company magit)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
