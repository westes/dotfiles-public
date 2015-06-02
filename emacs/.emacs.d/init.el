(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(package-initialize)

(add-to-list 'load-path "~/share/emacs/")

(require `unfill)

(require `puppet-ext)
(add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))

(condition-case err
(progn
(autoload 'speechd-speak "speechd-speak" nil t)
(speechd-speak)
(speechd-speak-set-language "en-US")
(speechd-set-rate 100 t)
(speechd-set-punctuation-mode `all t)
(speechd-set-volume 60 t)
)
(error
   (message "Cannot load speechd-el %s" (cdr err))))

(condition-case err
    (progn
      (autoload 'uniquify "uniquify" nil t)
      )
  (error
     (message "Cannot load uniquify %s" (cdr err))))

(add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m) 

(electric-indent-mode)
(ffap-bindings)

(set-fill-column 72)

; auctex customization
(setq TeX-auto-save t)
     (setq TeX-parse-self t)
     (setq-default TeX-master nil)

; org mode key bindings
     (global-set-key "\C-cl" 'org-store-link)
     (global-set-key "\C-cc" 'org-capture)
     (global-set-key "\C-ca" 'org-agenda)
     (global-set-key "\C-cb" 'org-iswitchb)

(server-start)
