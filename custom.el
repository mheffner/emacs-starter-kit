
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
  (message "Loaded custom C settings")
  )

(add-hook 'c-mode-hook
          'load-c-settings
          )
(add-hook 'c++-mode-hook
          'load-c-settings
          )

;; ws-trim
(require 'ws-trim)

(add-hook 'c-mode-hook 'turn-on-ws-trim)
(add-hook 'c++-mode-hook 'turn-on-ws-trim)
(add-hook 'shell-script-mode 'turn-on-ws-trim)

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
