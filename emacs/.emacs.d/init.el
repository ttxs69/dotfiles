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
  (global-company-mode t))
;; install magit for git
(use-package magit)

(use-package yasnippet
  :config
  (yas-reload-all)
  :hook ((prog-mode) . yas-minor-mode))

(use-package rust-mode
  :config
  (setq indent-tabs-mode nil)
  (setq rust-format-on-save t)
  (prettify-symbols-mode))

;; install lsp-mode for code
(use-package lsp-mode
  :hook ((c++-mode python-mode rust-mode) . lsp-deferred)
  :commands lsp)


;; set up builtin packages config
(use-package org
  :ensure nil
  :config
  (setq org-directory "~/daily/org/")
  ;; close org edit invisiable
  (setq org-catch-invisible-edits #'error)
  ;; set todo keywords
  (setq org-todo-keywords '((sequence "TODO" "WORKING" "|" "DONE(d!)")))
  ;; set org capture fils
  (setq org-default-notes-file (concat org-directory "/notes.org"))
  :bind (("C-c l" . org-store-link)
	 ("C-c a" . org-agenda)
	 ("C-c c" . org-capture))
  )

;; set variables
;; close backup
(setq make-backup-files nil)

;; global enabled mode
;; enable linum mode
(global-linum-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files '("~/daily/org/"))
 '(package-selected-packages
   '(yasnippet rust-mode lsp-python-ms lsp-mode use-package company magit)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
