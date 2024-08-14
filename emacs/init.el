; list the packages you want
(setq package-list '(company magit))

(setq package-archives '(("gnu"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
                         ("melpa"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize) ;; You might already have this line

; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(defun my/open-init ()
  "open init.el"
  (interactive)
  (find-file "~/.config/emacs/init.el")
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
  (load-theme 'tango-dark)
  :config
  (global-display-line-numbers-mode))
