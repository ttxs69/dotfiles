(setq package-archives '(("gnu"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
                         ("melpa"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize) ;; You might already have this line

(defun my/open-init ()
  "open init.el"
  (interactive)
  (find-file "~/.emacs.d/init.el")
)

(defun my/config-var ()
  "my config"
  ;; close backup
  (setq make-backup-files nil)
  )

(defun my/config-key ()
  "setup key maps"
  (global-set-key (kbd "C-c i") 'my/open-init ))

(defun my/setup ()
  "init"
  (my/config-var)
  (my/config-key)
  ;; set up minibuffer
  (fido-vertical-mode t)
)

(my/setup)

;; install company for auto completion
(use-package company
  :config
  (global-company-mode t)
  :custom
  (company-idle-delay 0.0 "Provide instant autocompletion."))

(use-package eglot
  :hook
  (prog-mode . eglot-ensure))

(use-package eldoc
  :hook
  (prog-mode . global-eldoc-mode))
  
(use-package emacs
  :init
  (load-theme 'tango-dark))

(use-package org
  :init
  (global-org-modern-mode t))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(magit org-modern use-package company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
