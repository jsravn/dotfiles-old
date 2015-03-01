;;; personal.el --- James Ravn's personal settings for prelude emacs
;;; Commentary:

;;; Code:
(setq guru-warn-only t)
(projectile-global-mode)
(setq x-select-enable-primary t)
(setq x-select-enable-clipboard t)
(setq ido-use-virtual-buffers t)

(prelude-require-packages '(evil markdown-mode robe enh-ruby-mode))

(evil-mode 1)

;; deal with haskell-mode quirkiness
(add-to-list 'evil-emacs-state-modes 'haskell-interactive-mode)

(prelude-mode 1)

(setq default-frame-alist '((font . "Droid Sans Mono Slashed:size=15")))
(setq prelude-flyspell nil)
(setq browse-url-browser-function 'browse-url-chromium)

;; http://comments.gmane.org/gmane.comp.lang.haskell.cafe/85859
;(defadvice inferior-haskell-load-file (after change-focus-after-load)
;  "Change focus to GHCi window after C-c C-l command"
;  (other-window 1))

;(ad-activate 'inferior-haskell-load-file)

(add-hook 'enh-ruby-mode-hook 'robe-mode)

(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

(setq org-export-backends '(docbook html beamer ascii latex md))

;;; settings.el ends here
