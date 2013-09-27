(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
(package-initialize)
(add-to-list 'load-path "~/share/emacs/")
(require `puppet-ext)
(add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))

(condition-case err
(progn
(autoload 'speechd-speak "speechd-speak" nil t)
(speechd-speak)
(speechd-speak-set-language "en-US")
(speechd-set-rate 100 t)
(speechd-set-punctuation-mode `all t)
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


;; assuming confluence.el and xml-rpc.el are in your load path
;(require 'confluence)

;; note, all customization must be in *one* custom-set-variables block
;(custom-set-variables
 ;; ... other custimization

 ;; confluence customization
; '(confluence-url "http://intranet/confluence/rpc/xmlrpc")
; '(confluence-default-space-alist (list (cons confluence-url "your-default-space-name"))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; confluence editing support (with longlines mode)

(autoload 'confluence-get-page "confluence" nil t)

(eval-after-load "confluence"
  '(progn
     (require 'longlines)
     (progn
       (add-hook 'confluence-mode-hook 'longlines-mode)
       (add-hook 'confluence-before-save-hook 'longlines-before-revert-hook)
       (add-hook 'confluence-before-revert-hook 'longlines-before-revert-hook)
       (add-hook 'confluence-mode-hook '(lambda () (local-set-key "\C-j" 'confluence-newline-and-indent))))))

;; LongLines mode: http://www.emacswiki.org/emacs-en/LongLines
(autoload 'longlines-mode "longlines" "LongLines Mode." t)

(eval-after-load "longlines"
  '(progn
     (defvar longlines-mode-was-active nil)
     (make-variable-buffer-local 'longlines-mode-was-active)

     (defun longlines-suspend ()
       (if longlines-mode
           (progn
             (setq longlines-mode-was-active t)
             (longlines-mode 0))))

     (defun longlines-restore ()
       (if longlines-mode-was-active
           (progn
             (setq longlines-mode-was-active nil)
             (longlines-mode 1))))

     ;; longlines doesn't play well with ediff, so suspend it during diffs
     (defadvice ediff-make-temp-file (before make-temp-file-suspend-ll
                                             activate compile preactivate)
       "Suspend longlines when running ediff."
       (with-current-buffer (ad-get-arg 0)
         (longlines-suspend)))

    
     (add-hook 'ediff-cleanup-hook 
               '(lambda ()
                  (dolist (tmp-buf (list ediff-buffer-A
                                         ediff-buffer-B
                                         ediff-buffer-C))
                    (if (buffer-live-p tmp-buf)
                        (with-current-buffer tmp-buf
                          (longlines-restore))))))))

;; keybindings (change to suit)

;; open confluence page
(global-set-key "\C-xwf" 'confluence-get-page)

;; setup confluence mode
(add-hook 'confluence-mode-hook
          '(lambda ()
             (local-set-key "\C-xw" confluence-prefix-map)))

(setq confluence-url "http://intranet.cmgdigital.com/rpc/xmlrpc")

(setq twittering-use-master-password t)

(server-start)
