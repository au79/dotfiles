(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)


(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
  ;; and `package-pinned-packages`. Most users will not need or want to do this.
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  )

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(case-fold-search nil)
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(custom-enabled-themes (quote (tango-dark)))
 '(custom-safe-themes
   (quote
    ("b89ae2d35d2e18e4286c8be8aaecb41022c1a306070f64a66fd114310ade88aa" "4cf9ed30ea575fb0ca3cff6ef34b1b87192965245776afa9e9e20c17d115f3fb" default)))
 '(indicate-buffer-boundaries (quote left))
 '(indicate-empty-lines t)
 '(js-indent-level 2)
 '(load-home-init-file t t)
 '(mac-command-modifier (quote super))
 '(mac-option-modifier (quote (:ordinary meta :function meta :mouse meta)))
 '(markdown-command "marked-gfm")
 '(markdown-command-needs-filename t)
 '(package-selected-packages
   (quote
    (typescript-mode rjsx-mode w3m dockerfile-mode go-mode web-server websocket markdown-preview-mode terraform-mode w32-browser groovy-mode w3 coffee-mode)))
 '(perl-continued-brace-offset -2)
 '(perl-continued-statement-offset 2)
 '(perl-indent-level 2)
 '(perl-label-offset -1)
 '(save-place t nil (saveplace))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(transient-mark-mode t)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 '(user-mail-address "cgoldman@oolong.com"))

(setq smerge-command-prefix "\C-cv")

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.

 '(default ((t (:inherit nil :stipple nil :background "#2e3436" :foreground "#eeeeec" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 100 :width normal :foundry "nil" :family "M+ 2m")))))


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

(add-to-list 'auto-mode-alist '("\\.xslt\\'" . xml-mode))

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

(autoload 'markdown-preview-mode "markdown-preview-mode"
   "Minor mode for previewing Markdown files" t)
(require 'markdown-preview-mode)
(setq markdown-preview-stylesheets (list "http://au79.github.io/markdown-dark-mode.css"))



(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

(require 'rjsx-mode)
(add-to-list 'auto-mode-alist '("components\\/.*\\.js\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("pages\\/.*\\.js\\'" . rjsx-mode))
(setq js2-strict-missing-semi-warning nil)
