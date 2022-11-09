(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(direnv-mode)

;; navigation
(evil-mode)


(origami-mode)
(add-hook 'prog-mode-hook #'aggressive-indent-mode)

;; ui enhancment
(vertico-mode)
(marginalia-mode)
(all-the-icons-completion-mode)
;;(add-hook 'marginalia-mode-hook #'all-the-icons-completion-marginalia-setub)
(dirvish-override-dired-mode)
(doom-modeline-mode)
(dashboard-setup-startup-hook)
(add-hook 'prog-mode-hook #'minimap-mode)

(auto-sudoedit-mode)


;; programming stuff
(nix-mode)
(haskell-mode)
(dhall-mode)
(rust-mode)
(add-hook 'prog-mode-hook #'lsp-deferred)
(add-hook 'lsp-after-open-hook #'lsp-origami-try-enable)
