(define-key global-map [(f1)] 'delete-other-windows)
(define-key global-map [(f2)] 'menu-bar-mode)
(define-key global-map [(f5)] 'buffer-menu)

(define-key global-map [(meta g)] 'goto-line)

;; Set whitespace column
(setq whitespace-line-column 80)

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
