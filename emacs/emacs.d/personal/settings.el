;;; personal.el --- James Ravn's personal settings for prelude emacs
;;; Commentary:

;;; Code:
(setq guru-warn-only t)
(projectile-global-mode)
(setq x-select-enable-primary t)
(setq x-select-enable-clipboard t)
(setq ido-use-virtual-buffers t)
(prelude-require-packages '(evil markdown-mode robe enh-ruby-mode rust-mode ghc company-ghc))
(evil-mode 1)
(add-hook 'after-init-hook 'global-company-mode)
(setq visible-bell 1)
(global-linum-mode 1)
(setq browse-url-browser-function 'browse-url-chromium)
(setq magit-last-seen-setup-instructions "1.4.0")

;; evil mode tweaks per major mode
(evil-set-initial-state 'haskell-interactive-mode 'emacs)
(evil-set-initial-state 'git-commit-mode 'insert)
(evil-set-initial-state 'neotree-mode 'emacs)
(evil-set-initial-state 'shell-mode 'emacs)

;; prelude tweaks
(prelude-mode 1)
(setq prelude-whitespace nil)
(setq prelude-flyspell nil)

;; ruby
(add-hook 'enh-ruby-mode-hook 'robe-mode)

;; haskell
;; see https://github.com/serras/emacs-haskell-tutorial/blob/master/tutorial.md
(let ((my-stackage-path (expand-file-name "~/.local/bin")))
  (setenv "PATH" (concat my-stackage-path path-separator (getenv "PATH")))
  (add-to-list 'exec-path my-stackage-path))
(custom-set-variables
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-tags-on-save t)
 '(haskell-process-type 'stack-ghci))
(eval-after-load 'haskell-mode '(progn
  (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
  (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
  (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
  (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
  (define-key haskell-mode-map (kbd "C-c C-o") 'haskell-compile)
  (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)))
(eval-after-load 'haskell-cabal '(progn
  (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
  (define-key haskell-cabal-mode-map (kbd "C-c C-o") 'haskell-compile)
  (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)))
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))
(add-to-list 'company-backends 'company-ghc)
(custom-set-variables '(company-ghc-show-info t))
(eval-after-load 'haskell-mode
  '(define-key haskell-mode-map [f8] 'haskell-navigate-imports))

;; org
(setq org-export-backends '(docbook html beamer ascii latex md))

;; go-lang
(add-hook 'go-mode-hook
  (lambda ()
    (setq tab-width 8)
    (setq indent-tabs-mode 1)))

;; auctex
(setq TeX-auto-save t)
(setq TeX-parse-self t)

;;; settings.el ends here
