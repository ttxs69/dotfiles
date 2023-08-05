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

;; install projectile
(use-package projectile
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("C-c p" . projectile-command-map)))

;; install magit for git
(use-package magit)

;; install avy for quick jump
(use-package avy
  :bind (("M-g w" . avy-goto-word-1)
	 ("M-g l" . avy-goto-line)))

;; install yasnippet for code snippets
(use-package yasnippet
  :config
  (yas-reload-all)
  :hook ((prog-mode) . yas-minor-mode))

;; install autopep8 for python auto fmt
(use-package py-autopep8
  :hook ((python-mode) . py-autopep8-mode))

;; install rust-mode for rust
(use-package rust-mode
  :config
  (setq indent-tabs-mode nil)
  (setq rust-format-on-save t)
  (prettify-symbols-mode))

;; install lsp-mode for code
;; NOTE: need to install external packages which are the language server
;; `clangd' for c++-mode
;; `python-lsp-server' for python-mode
;; `rust-analyzer' for rust-mode
;; `deno' for js-mode
(use-package lsp-mode
  :init
  ;; add pylsp path to exec-path
  (add-to-list 'exec-path "/opt/homebrew/bin/")
  :hook ((c++-mode python-mode rust-mode js-mode) . lsp-deferred)
  :commands lsp)
;; install lsp-ui for better lsp ui
(use-package lsp-ui
  :commands lsp-ui-mode)

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  :config
  (marginalia-mode))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; install orderless for better fuzz search in minibuffer
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; Enable vertico for minibuffer
(use-package vertico
  :config
  (vertico-mode))

;; Example configuration for Consult
(use-package consult
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings in `search-map'
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         :map isearch-mode-map
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi))            ;; needed by consult-line to detect isearch

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; "C-+"
  (autoload 'projectile-project-root "projectile")
  (setq consult-project-function (lambda (_) (projectile-project-root)))
 )

;; install expand-region
(use-package expand-region
  :bind ("C-^" . er/expand-region))

;; install ace-window
(use-package ace-window
  :bind("M-o" . ace-window))

;; install smartparens
(use-package smartparens
  :diminish smartparens-mode ;; Do not show in modeline
  :config
  (require 'smartparens-config)
  (smartparens-global-mode t) ;; These options can be t or nil.
  (show-smartparens-global-mode t)
  (setq sp-show-pair-from-inside t))

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
;; macos need to install external `mactex' package for export as pdf
(use-package org
  :ensure nil
  :custom
  (org-directory "~/daily/org/")
  (org-catch-invisible-edits #'error "close org edit invisiable") 
  (org-todo-keywords '((sequence "TODO" "WORKING" "|" "DONE(d!)")) "set todo keywords")
  (org-default-notes-file (concat org-directory "/notes.org") "set org capture files")
  (org-agenda-files '("~/daily/org/"))
  :bind (("C-c l" . org-store-link)
	 ("C-c a" . org-agenda)
	 ("C-c c" . org-capture))
  )

;; install org-modern
(use-package org-modern
  :hook((org-mode . org-modern-mode)
	(org-agenda-finalize . org-modern-agenda)))

;; set variables
;; close backup
(setq make-backup-files nil)
;; use space instead of tabs
(setq-default indent-tabs-mode nil)
;; global enabled mode
(global-display-line-numbers-mode)
(delete-selection-mode)

;;setup mu custom functions
(defun my/open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "C-c i") 'my/open-init-file)
;; open recentf mode
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(py-autopep8 ace-window avy org-modern embark-consult projectile smartparens smartparens-config expand-region consult orderless doom-modeline doom-themes lsp-ui marginalia vertico yasnippet rust-mode lsp-mode use-package company magit)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
