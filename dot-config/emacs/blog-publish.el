;; -*- lexical-binding: t; -*-
(require 'org)
(org-babel-do-load-languages
   'org-babel-load-languages
   '((shell . t)
     (org . t)
     (emacs-lisp . t)))

(require 'ox-publish)
;; disable postamble's default validate element
(setq org-html-validation-link nil)
(defun my-org-publish-sitemap (title list)
  "Generate site map, as a string.
TITLE is the title of the site map.  LIST is an internal
representation for the files to include, as returned by
`org-list-to-lisp'.  PROJECT is the current project."
  (concat "#+TITLE: " title "\n"
	  ;; import the config file for sitemap
	  "#+SETUPFILE: ../org-templates/level-0.org\n\n"
	  (org-list-to-org list)))

;; for code highlight, make sure `htmlize` is installed
(require 'htmlize)

(setq org-publish-project-alist
      '(
	;; components here
	;; notes
	("org-notes"
	 :base-directory "~/blog/src/"
	 :base-extension "org"
	 :publishing-directory "~/blog/public/"
	 :recursive t
	 :publishing-function org-html-publish-to-html
	 :htmlized-source t
	 :auto-sitemap t
	 ;; use sitemap as index.html
	 :sitemap-title "Home"
	 :sitemap-filename "index.org"
	 :sitemap-function my-org-publish-sitemap
	 )
	;; static
	("org-static"
	 :base-directory "~/blog/src/"
	 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
	 :publishing-directory "~/blog/public/"
	 :recursive t
	 :publishing-function org-publish-attachment
	 )
	;; publish
	("org" :components ("org-notes" "org-static"))
	))
