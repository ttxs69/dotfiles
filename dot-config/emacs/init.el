;; -*- lexical-binding: t; -*-
(require 'package)
(setq package-enable-at-startup nil)

(setq package-archives '(("gnu"    . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("nongnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
                         ("melpa"  . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize) ;; You might already have this line

; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
 (unless (package-installed-p 'use-package)
   (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(defun my/open-init ()
  "open init.el"
  (interactive)
  (find-file "~/.config/emacs/init.el")
  )

;; ox-hugo
(use-package ox-hugo
  :ensure t   ;Auto-install the package from Melpa
  :pin melpa  ;`package-archives' should already have ("melpa" . "https://melpa.org/packages/")
  :after ox)

;; benchmark for startup time
(use-package benchmark-init
  :ensure t
  :config
  ;; To disable collection of benchmark data after init is done.
  (add-hook 'after-init-hook 'benchmark-init/deactivate))

(use-package goto-chg
  :ensure t)


(use-package evil-leader
  :ensure t
  :config
  (evil-leader/set-leader "<SPC>")
  (global-evil-leader-mode t)
  (evil-leader/set-key
  "e" 'find-file
  "b" 'switch-to-buffer
  "k" 'kill-buffer)
  )

;; evil mode
(use-package evil
  :ensure t
  :after evil-leader
  :config
  (evil-mode t))

(use-package evil-org
  :ensure t
  :after (evil org)
  :hook (org-mode . evil-org-mode)
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

;; undo-tree
(use-package undo-tree
  :ensure t
  :config
  (setq undo-tree-auto-save-history nil)
  (global-undo-tree-mode))

;; fish mode
(use-package fish-mode
  :ensure t)

;; treesit
;; you need to download treesit binary from https://github.com/emacs-tree-sitter/tree-sitter-langs
;; and unzip them to ~/.config/emacs/tree-sitter directory
;; and rename them to libtree-sitter-<LANG>.dylib
(use-package treesit-auto
  :ensure t
  :config
  (setq treesit-auto-langs '(python rust go))
  (global-treesit-auto-mode))

;; Example configuration for Consult
(use-package consult
  :ensure t
  ;; Replace bindings. Lazily loaded by `use-package'.
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x t b" . consult-buffer-other-tab)    ;; orig. switch-to-buffer-other-tab
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
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
         ("M-s d" . consult-find)                  ;; Alternative: consult-fd
         ("M-s c" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Tweak the register preview for `consult-register-load',
  ;; `consult-register-store' and the built-in commands.  This improves the
  ;; register formatting, adds thin separator lines, register sorting and hides
  ;; the window mode line.
  (advice-add #'register-preview :override #'consult-register-window)
  (setq register-preview-delay 0.5)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key "M-.")
  ;; (setq consult-preview-key '("S-<down>" "S-<up>"))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep consult-man
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; "C-+"

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (keymap-set consult-narrow-map (concat consult-narrow-key " ?") #'consult-narrow-help)
)

(use-package embark
  :ensure t

  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  ;; Show the Embark target at point via Eldoc. You may adjust the
  ;; Eldoc strategy, if you want to see the documentation from
  ;; multiple providers. Beware that using this can be a little
  ;; jarring since the message shown in the minibuffer can be more
  ;; than one line, causing the modeline to move up and down:

  ;; (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

  ;; Add Embark to the mouse context menu. Also enable `context-menu-mode'.
  ;; (context-menu-mode 1)
  ;; (add-hook 'context-menu-functions #'embark-context-menu 100)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; install htmlize for code highlight
(use-package htmlize
  :ensure t)

;; load blog-publish.el
;; (load-file "~/.config/emacs/blog-publish.el")

;; elfeed
(use-package elfeed
  :ensure t
  :init
  (setq elfeed-feeds '("https://lobste.rs/rss"
		       "https://nullprogram.com/feed/"
		       "https://planet.emacslife.com/atom.xml"
                       "https://opensource.com/feed"))
  :bind
  ("C-x w" . elfeed))

;; yasnippet
(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode))

;; yasnippet-snippets
(use-package yasnippet-snippets
  :ensure t)

;; org-modern
(use-package org-modern
  :ensure t
  :config
  (global-org-modern-mode))

;; marginalia, for more context in minibuffer
(use-package marginalia
  :ensure t
  :config
  (marginalia-mode))

;; vertico
(use-package vertico
  :ensure t
  :config
  (vertico-mode))

;; orderless
(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic))
)

;; ace-window
(use-package ace-window
  :ensure t
  :bind
  ("M-o" . ace-window))

;; which key
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; move text
(use-package move-text
  :ensure t
  :config
  (move-text-default-bindings))

;; multi cursor
(use-package multiple-cursors
  :ensure t
  :bind
  ("s->" . mc/mark-next-like-this)
  ("s-<" . mc/mark-previous-like-this)
  ("s-." . mc/mark-all-like-this))

;; config kkp for kitty keyboard protocol
(use-package kkp
  :ensure t
  :config
  (global-kkp-mode t))

;; install company for auto completion
(use-package company
  :ensure t
  :config
  (global-company-mode t)
  :custom
  (company-idle-delay 0.0 "Provide instant autocompletion."))

(use-package eglot
  :hook
  (c++-ts-mode . eglot-ensure)
  (c-ts-mode . eglot-ensure)
  (python-ts-mode . eglot-ensure))

;; set up expand-region
(use-package expand-region
  :ensure t
  :bind
  ("C-=" . er/expand-region))


(use-package eldoc
  :hook
  (prog-mode . global-eldoc-mode))

(use-package emacs
  :init
  (load-theme 'modus-vivendi)
  :config
  ;; set fond size
  (global-hl-line-mode t)
  (set-face-attribute 'default nil :height 160)
  (setq display-line-numbers-type 'relative)
  (global-display-line-numbers-mode)
  ;;; close backup
  (setq make-backup-files nil)
  ;;; Don't display the start screen
  (setq inhibit-startup-screen t)
  ;;; Disable the toolbar
  (tool-bar-mode -1)
  ;; disable menu bar
  (menu-bar-mode -1)
  ;; setup key maps
  (global-set-key (kbd "C-c i") 'my/open-init)
  ;; for easy copy at dired
  (setq dired-dwim-target t)
  ;; set up duplicate line final position
  (setq duplicate-line-final-position 1)
  ;; set use space not tab
  (setq indent-tabs-mode nil)
  :custom
  ;; Support opening new minibuffers from inside existing minibuffers.
  (enable-recursive-minibuffers t)
  ;; Hide commands in M-x which do not work in the current mode.  Vertico
  ;; commands are hidden in normal buffers. This setting is useful beyond
  ;; Vertico.
  (read-extended-command-predicate #'command-completion-default-include-p)
  ;; Do not allow the cursor in the minibuffer prompt
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt))
  :bind
  ("C-," . duplicate-line)
  )

(use-package org
  :ensure t
  :config
  (setq org-log-done 'time)
  ;; enable org-tempo
  (add-to-list 'org-modules 'org-tempo t)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((shell . t)
     (org . t)
     (emacs-lisp . t)))
  (setq org-agenda-files (directory-files-recursively "~/org/" "\\.org$"))
  (setq org-refile-targets '((org-agenda-files :maxlevel . 1)))
  :bind
  ("C-c l" . org-store-link)
  ("C-c a" . org-agenda)
  ("C-c c" . org-capture)
  )


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(elfeed-feeds '("https://lobste.rs/rss") t)
 '(package-selected-packages
   '(ace-window bazel benchmark-init company consult elfeed embark
		embark-consult evil evil-org expand-region fish-mode
		goto-chg htmlize kkp magit marginalia move-text
		multiple-cursors orderless org-modern ox-hugo
		treesit-auto undo-tree vertico yasnippet
		yasnippet-snippets)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
