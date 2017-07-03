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

(setq smerge-command-prefix "\C-cv")

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


;;(require 'java-complete)
;;(add-hook 'java-mode-hook (lambda () (local-set-key (kbd "C-	") 'java-complete)))

(add-to-list 'auto-mode-alist '("\\.aj$" . java-mode))


(setq-default c-basic-offset 2)
(setq-default indent-tabs-mode nil)

(define-key function-key-map "\e[Z" [S-tab])

;;(require 'icicles)
;;(icy-mode 1)
;;(defalias 'list-buffers 'ibuffer)


(global-set-key (kbd "M-j") `delete-indentation)
(global-set-key (kbd "C-M-j") (lambda() (interactive (delete-indentation -1))))

(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
