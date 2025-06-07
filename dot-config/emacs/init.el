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

;; elfeed
(use-package elfeed
  :ensure t
  :init
  (setq elfeed-feeds '("https://lobste.rs/rss"
		       "https://nullprogram.com/feed/"
		       "https://planet.emacslife.com/atom.xml"))
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
  (c++-mode . eglot-ensure)
  (c-mode . eglot-ensure)
  (python-mode . eglot-ensure))

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
  (setq org-agenda-files (directory-files-recursively "~/org/" "\\.org$")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(elfeed-feeds '("https://lobste.rs/rss"))
 '(package-selected-packages
   '(ace-window bazel company elfeed embark expand-region kkp magit
                move-text multiple-cursors orderless org-modern
                yasnippet yasnippet-snippets)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
