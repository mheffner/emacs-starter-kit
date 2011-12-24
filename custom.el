
;; Load a custom configuration directory
(setq custom-load-dir (concat dotfiles-dir "custom.d"))
(add-to-list 'load-path custom-load-dir)

(if (file-exists-p custom-load-dir)
    (mapc #'load (directory-files custom-load-dir nil ".*el$"))
  )

(define-key global-map [(f1)] 'delete-other-windows)
(define-key global-map [(f2)] 'menu-bar-mode)
(define-key global-map [(f5)] 'buffer-menu)

(define-key global-map [(meta g)] 'goto-line)

(define-key global-map [(meta q)] 'fill-paragraph)

(define-key global-map (kbd "C-x j") 'join-line)
(define-key global-map (kbd "C-x m") 'magit-status)

(define-key global-map (kbd "C-x p") 'find-file-in-project)

(define-key global-map (kbd "<next>") 'scroll-up)
(define-key global-map (kbd "<prior>") 'scroll-down)

;; Set whitespace column
(setq-default whitespace-line-column 80)

;; Require final newline
(setq-default require-final-newline "ask")

;; Track EOF
(setq-default track-eol t)

;; Kill whole line
(setq-default kill-whole-line t)

;; scroll bar on right please
(set-scroll-bar-mode 'right)

;; Set level for font decoration
(setq font-lock-maximum-decoration
      '((c-mode . 2) (c++-mode . 2)))

;; Set cursor style dynamically
(require 'cursor-chg)
(toggle-cursor-type-when-idle 1) ; change cursor when idle
; Turn on change for overwrite, read-only, and input mode
(change-cursor-mode 1)

;; xcscope
(require 'xcscope)

;;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph
(defun unfill-paragraph ()
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

;;
;; findr
;; http://www.emacswiki.org/emacs/FindrPackage
;;
(require 'findr)
(autoload 'findr "findr" "Find file name." t)
(define-key global-map [(meta control S)] 'findr)
(autoload 'findr-search "findr" "Find text in files." t)
(define-key global-map [(meta control s)] 'findr-search)
(autoload 'findr-query-replace "findr" "Replace text in files." t)
(define-key global-map [(meta control r)] 'findr-query-replace)

;; My C-style
(defconst my-c-style
  '((c-tab-always-indent . nil)
    (c-basic-offset . 8)
    (c-offsets-alist . ((arglist-cont . *)
                        (arglist-cont-nonempty . *)))))

(c-add-style "mybsd" my-c-style)

;; Mode hook to set indent-tab-mode
(defun load-c-settings ()
  "Load custom C mode settings"
  (c-set-style "mybsd")
  (setq indent-tabs-mode t)
  (setq column-number-mode t)
  (message "Loaded custom C settings")
  )

(add-hook 'c-mode-hook
          'load-c-settings
          )
(add-hook 'c++-mode-hook
          'load-c-settings
          )

;; Jave style
(defun load-java-settings()
  "Load custom java mode settings"
  (c-set-style "mybsd")
  (setq indent-tabs-mode t)
  (message "Loaded custom Java settings")
  )

(add-hook 'java-mode-hook
          'load-java-settings
          )

;; paredit mode is annoying as hell, disable in JS
(remove-hook 'espresso-mode-hook 'esk-paredit-nonlisp)

;; also disable in all lisp modes
(dolist (x '(scheme emacs-lisp lisp clojure))
  (remove-hook
   (intern (concat (symbol-name x) "-mode-hook")) 'turn-on-paredit))

;; ws-trim
(require 'ws-trim)

(add-hook 'c-mode-hook 'turn-on-ws-trim)
(add-hook 'c++-mode-hook 'turn-on-ws-trim)
(add-hook 'sh-mode-hook 'turn-on-ws-trim)
(add-hook 'shell-script-mode-hook 'turn-on-ws-trim)
(add-hook 'ruby-mode-hook 'turn-on-ws-trim)

;;
;; coffee-mode
;;
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

(defun coffee-custom ()
  "coffee-mode-hook"
 (set (make-local-variable 'tab-width) 2))

(add-hook 'coffee-mode-hook
  '(lambda() (coffee-custom)))

;;
;; whitespace (display)
;;
(require 'whitespace)
;;(autoload 'whitespace-mode "whitespace" "Toggle whitespace visualization." t)

;; Show trailing whitespace
(setq-default show-trailing-whitespace t)

;;(setq whitespace-style
;;      '(trailing lines-tail indentation space-after-tab
;;                 space-before-tab))

;;
;; Shell Script settings
;;

(defun my-setup-sh-mode ()
  "My own personal preferences for `sh-mode'.

This is a custom function that sets up the parameters I usually
prefer for `sh-mode'.  It is automatically added to
`sh-mode-hook', but is can also be called interactively."
  (interactive)
  (setq sh-basic-offset 8
        sh-indentation 8
        
        ;; Tweak the indentation level of case-related syntax elements, to avoid
        ;; excessive indentation because of the larger than default value of
        ;; `sh-basic-offset' and other indentation options.
        sh-indent-for-case-label 0
        sh-indent-for-case-alt '+
        sh-indent-for-continuation '*
        sh-indent-comment t

        indent-tabs-mode t
        column-number-mode t
        )
  (message "Loaded custom shell-script settings")
  )
(add-hook 'sh-mode-hook 'my-setup-sh-mode)
(add-hook 'shell-script-mode-hook 'my-setup-sh-mode)


;;
;; Python mode
;;
(setq py-indent-offset tab-width)
(setq python-mode-hook
      '(lambda ()
         "python mode hook override"
         (setq tab-width 8)
         (setq py-indent-offset tab-width)
         )
      )

;;
;; Thrift mode
;;
(setq auto-mode-alist (cons '("\\.thrift$" . thrift-mode) auto-mode-alist))
(autoload 'thift-mode "thrift" "Thrift editing mode." t)

;; HAML mode
(require 'haml-mode)

;; SASS mode
(require 'sass-mode)

;;
;; Ruby mode
;;
;; (setq ruby-indent-level tab-width)
;; (setq ruby-indent-tabs-mode t)

;; Fixes exception first time ruby file is opened
(require 'tramp-cmds)

(defun rails-load-config ()
  (setq ruby-indent-level 2)
  (setq ruby-indent-tabs-mode nil))

(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
          '(lambda ()
             (inf-ruby-keys)
	     (if (or (string-match "/app/" buffer-file-name)
		     (string-match "/db/migrate/" buffer-file-name)
		     (string-match "/spec/" buffer-file-name)
                     (string-match "/config/*environment*" buffer-file-name))
		 (rails-load-config))
	     ))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#ece9e9" :foreground "#000000" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 107 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(c-default-style (quote ((c-mode . "bsd") (java-mode . "java") (awk-mode . "awk") (other . "gnu"))))
 )
