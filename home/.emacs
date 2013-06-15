(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(case-fold-search nil)
 '(column-number-mode t)
 '(confluence-default-space-alist (list (cons confluence-url "~cgoldman")))
 '(confluence-url "https://confluence.dhapdigital.com/rpc/xmlrpc")
 '(current-language-environment "UTF-8")
 '(indicate-buffer-boundaries (quote left))
 '(indicate-empty-lines t)
 '(load-home-init-file t t)
 '(perl-continued-brace-offset -2)
 '(perl-continued-statement-offset 2)
 '(perl-indent-level 2)
 '(perl-label-offset -1)
 '(save-place t nil (saveplace))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(transient-mark-mode t)
 '(uniquify-buffer-name-style (quote forward))
 '(user-mail-address "cgoldman@dhapdigital.com"))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(put 'upcase-region 'disabled nil)

(put 'downcase-region 'disabled nil)

(setenv "LD_LIBRARY_PATH" "/usr/lib/oracle/11.2/client64/lib")

(server-start)

;; A helper function from: http://mihai.bazon.net/projects/emacs-javascript-mode/javascript.el
;; Originally named js-lineup-arglist, renamed to as-lineup-arglist
(defun as-lineup-arglist (langelem)
  ;; the "DWIM" in c-mode doesn't Do What I Mean in JS.
  ;; see doc of c-lineup-arglist for why I redefined this
  (save-excursion
    (let ((indent-pos (point)))
      ;; Normal case.  Indent to the token after the arglist open paren.
      (goto-char (c-langelem-2nd-pos c-syntactic-element))
      (if (and c-special-brace-lists
               (c-looking-at-special-brace-list))
          ;; Skip a special brace list opener like "({".
          (progn (c-forward-token-2)
                 (forward-char))
        (forward-char))
      (let ((arglist-content-start (point)))
        (c-forward-syntactic-ws)
        (when (< (point) indent-pos)
          (goto-char arglist-content-start)
          (skip-chars-forward " \t"))
        (vector (current-column))))))

;; Org mode stuff
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)


;; ActionScript mode stuff 

;; Load & associate the the mode with .as files
(require 'ecmascript-mode)
(add-to-list 'auto-mode-alist '("\\.as$" . ecmascript-mode))

(add-to-list 'auto-mode-alist '("\\.php[34]?\\'\\|\\.phtml\\'" . php-mode))

;; My customizations to the mode.
(defun my-ecmascript-mode-hook ()
  (setq c-basic-offset 2) ; I like 2 spaces instead of 4 or 8
  ;;
  ;; This is the indentation magic from:
  ;; http://mihai.bazon.net/projects/emacs-javascript-mode/javascript.el
  ;;
  (c-set-offset 'arglist-close '(c-lineup-close-paren))
  (c-set-offset 'arglist-cont 0)
  (c-set-offset 'arglist-cont-nonempty '(as-lineup-arglist))
  (c-set-offset 'arglist-intro '+))
;; Associate my customization function with the mode's hook
(add-hook 'ecmascript-mode-hook 'my-ecmascript-mode-hook)

;;(require 'java-complete)
;;(add-hook 'java-mode-hook (lambda () (local-set-key (kbd "C-	") 'java-complete)))

(add-to-list 'auto-mode-alist '("\\.aj$" . java-mode))


(setq-default c-basic-offset 2)
(setq-default indent-tabs-mode nil)

(define-key function-key-map "\e[Z" [S-tab])

(require 'icicles)
;;(icy-mode 1)

(defalias 'list-buffers 'ibuffer)

;; Confluence-mode configuration

;; assuming confluence.el and xml-rpc.el are in your load path
(require 'confluence)

;; note, all customization must be in *one* custom-set-variables block



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

;; set up confluence mode
(add-hook 'confluence-mode-hook
          '(lambda ()
             (local-set-key "\C-xw" confluence-prefix-map)))

;; set up processing-mode
;;(add-to-list 'load-path "/usr/local/yasnippet/")
;;(require 'yasnippet)
;;(yas-global-mode 1)
(add-to-list 'load-path "/usr/local/processing-mode/")
(autoload 'processing-mode "processing-mode" "Processing mode" t)
(add-to-list 'auto-mode-alist '("\\.pde$" . processing-mode))
(setq processing-location "/usr/local/processing-2.0b7/")

(global-set-key (kbd "M-j") `delete-indentation)
(global-set-key (kbd "C-M-j") (lambda() (interactive (delete-indentation -1))))
