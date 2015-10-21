;;; personal.el --- James Ravn's personal settings for prelude emacs
;;; Commentary:

;;; Code:
(setq guru-warn-only t)
(projectile-global-mode)
(setq x-select-enable-primary t)
(setq x-select-enable-clipboard t)
(setq ido-use-virtual-buffers t)

(prelude-require-packages '(evil markdown-mode robe enh-ruby-mode neotree rust-mode))

(evil-mode 1)

;; evil mode tweaks per major mode
(evil-set-initial-state 'haskell-interactive-mode 'emacs)
(evil-set-initial-state 'git-commit-mode 'insert)
(evil-set-initial-state 'neotree-mode 'emacs)
(evil-set-initial-state 'shell-mode 'emacs)

(prelude-mode 1)

(setq default-frame-alist '((font . "Droid Sans Mono Slashed:size=15")))
(setq prelude-flyspell nil)
(setq browse-url-browser-function 'browse-url-chromium)
(setq magit-last-seen-setup-instructions "1.4.0")
;; http://comments.gmane.org/gmane.comp.lang.haskell.cafe/85859
;(defadvice inferior-haskell-load-file (after change-focus-after-load)
;  "Change focus to GHCi window after C-c C-l command"
;  (other-window 1))

;(ad-activate 'inferior-haskell-load-file)

(add-hook 'enh-ruby-mode-hook 'robe-mode)

(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

(setq org-export-backends '(docbook html beamer ascii latex md))

;; neotree
(global-set-key [f8] 'neotree-toggle)
(setq projectile-switch-project-action 'neotree-projectile-action)

;; linum
(global-linum-mode 1)

;; go-lang
(add-hook 'go-mode-hook
  (lambda ()
    (setq tab-width 8)
    (setq indent-tabs-mode 1)))

;; whitespace config
(setq prelude-whitespace nil)

;;; settings.el ends here
