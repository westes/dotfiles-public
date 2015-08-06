(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(package-initialize)

(add-to-list 'load-path "~/share/emacs/")

(condition-case err
(progn
(autoload 'speechd-speak "speechd-speak" nil t)
(speechd-speak)
(speechd-speak-set-language "en-US")
(speechd-set-rate 100 t)
(speechd-set-punctuation-mode `all t)
(speechd-set-volume 25 t)
)
(error
   (message "Cannot load speechd-el %s" (cdr err))))(require `unfill)

(require `puppet-ext)
(add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))

(add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m) 

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

; cycle-spacing introduced in emacs 24.4.
(global-set-key "\M-SPC" 'cycle-spacing)

                                        ; the new indentation engine for shell mode plays havok with speechd-el
(setq sh-use-smie nil)

                                        ; turn off character composition
(global-auto-composition-mode -1)

 (add-to-list 'auto-mode-alist '("\\.ledger$" . ledger-mode))

;; Mutt support.
(setq auto-mode-alist (append '(("/tmp/mutt.*" . mail-mode)) auto-mode-alist))

(server-start)
