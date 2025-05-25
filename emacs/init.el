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
  (load-theme 'tango-dark)
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
  ;; auto close bracket insertion
  (electric-pair-mode t)
  ;; set up minibuffer
  (fido-vertical-mode t)
  ;; setup key maps
  (global-set-key (kbd "C-c i") 'my/open-init)
  (setq dired-dwim-target t)
  (setq duplicate-line-final-position 1)
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
 '(package-selected-packages
   '(company expand-region kkp magit multiple-cursors)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
