
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

(global-set-key "\C-c\C-s" 'magit-status)
(global-set-key (kbd "C-x p") 'find-file-in-project)

;; Auto newline
(setq c-auto-newline 1)

;; Set whitespace column
(setq-default whitespace-line-column 80)

;; Require final newline
(setq-default require-final-newline "ask")

;; Track EOF
(setq-default track-eol t)

;; scroll bar on right please
(set-scroll-bar-mode 'right)

;; Set level for font decoration
(setq font-lock-maximum-decoration
      '((c-mode . 2) (c++-mode . 2)))

;; Mode hook to set indent-tab-mode
(defun load-c-settings ()
  "Load custom C mode settings"
  (c-set-style "bsd")
  (setq tab-always-indents t)
  (setq indent-tabs-mode t)
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
(setq ruby-indent-level tab-width)
(setq ruby-indent-tabs-mode t)

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
	     (if (string-match "/app/" buffer-file-name)
		 (rails-load-config))
	     ))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#ece9e9" :foreground "#000000" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 107 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))
