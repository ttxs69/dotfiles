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
;; install company for auto completion
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
  :bind (("M-g" . avy-goto-line)))

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
  :config
  (setq lsp-clients-clangd-args '(
                                  ;; If set to true, code completion will include index symbols that are not defined in the scopes
                                  ;; (e.g. namespaces) visible from the code completion point. Such completions can insert scope qualifiers
                                  "--all-scopes-completion"
                                  ;; Index project code in the background and persist index on disk.
                                  "--background-index"
                                  ;; Enable clang-tidy diagnostics
                                  "--clang-tidy"
                                  ;; Whether the clang-parser is used for code-completion
                                  ;;   Use text-based completion if the parser is not ready (auto)
                                  "--completion-parse=auto"
                                  ;; Granularity of code completion suggestions
                                  ;;   One completion item for each semantically distinct completion, with full type information (detailed)
                                  "--completion-style=detailed"
                                  ;; clang-format style to apply by default when no .clang-format file is found
                                  "--fallback-style=LLVM"
                                  ;; When disabled, completions contain only parentheses for function calls.
                                  ;; When enabled, completions also contain placeholders for method parameters
                                  "--function-arg-placeholders"
                                  ;; Add #include directives when accepting code completions
                                  ;;   Include what you use. Insert the owning header for top-level symbols, unless the
                                  ;;   header is already directly included or the symbol is forward-declared
                                  "--header-insertion=iwyu"
                                  ;; Prepend a circular dot or space before the completion label, depending on whether an include line will be inserted or not
                                  "--header-insertion-decorators"
                                  ;; Enable index-based features. By default, clangd maintains an index built from symbols in opened files.
                                  ;; Global index support needs to enabled separatedly
                                  "--index"
                                  ;; Attempts to fix diagnostic errors caused by missing includes using index
                                  "--suggest-missing-includes"
                                  ;; Number of async workers used by clangd. Background index also uses this many workers.
                                  "-j=4"
                                  ))
  :hook (((c++-mode python-mode rust-mode js-mode) . lsp-deferred)
         ((before-save) . lsp-format-buffer))
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

;; install ace-window
(use-package ace-window
  :bind("C-c o" . ace-window))

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
   '(company-lsp py-autopep8 ace-window avy org-modern embark-consult projectile smartparens smartparens-config expand-region orderless doom-modeline doom-themes lsp-ui marginalia vertico yasnippet rust-mode lsp-mode use-package company magit)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
