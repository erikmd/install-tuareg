;;; init.el --- Emacs conf file for Windows -*- coding: utf-8 -*-

;; Configuration de Tuareg

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (company tuareg))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
)

(add-hook 'tuareg-mode-hook (lambda () (company-mode)
  (local-set-key (kbd "<S-return>") #'electric-indent-just-newline)
  (local-set-key (kbd "<C-return>") #'company-complete)))

;; Configuration globale

(setq column-number-mode t)
(setq line-number-mode t)

;; Marquage des parenthèses

(load-library "paren")
(show-paren-mode 1)

;; Raccourcis C-c/C-x/C-v/C-z standards
(cua-mode 1)

;; Configuration de Merlin
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COMPLÉTER LES CHEMINS CI-DESSOUS SIGNALÉS PAR des "?"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq
 path-opam "???/opam.exe" ; par ex. "C:/OCaml64/usr/local/bin/opam.exe"
 path-share "???/share" ; par ex. "C:/Users/Erik/.opam/4.05.0+mingw64c/share"
 path-ocaml "???/ocaml.exe" ; par ex. "C:/Users/Erik/.opam/4.05.0+mingw64c/bin/ocaml.exe"
 path-merlin "???/ocamlmerlin.exe" ; par ex. "C:/Users/Erik/.opam/4.05.0+mingw64c/bin/ocamlmerlin.exe"
 )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if (or (not (file-executable-p path-opam))
	(not (file-directory-p path-share))
	(not (file-executable-p path-ocaml))
	(not (file-executable-p path-merlin)))
    (error "Les chemins d'OPAM, OCaml ou Merlin ne sont pas valides. Veuillez compléter les chemins correspondants dans le fichier \"~/.emacs\"")
  (progn
    (setq tuareg-interactive-program (concat path-opam " config exec -- " path-ocaml))
    (setq tuareg-opam path-opam)
    ;;;  (setq tuareg-opam-insinuate t) ; disabled - would overwrite merlin-command

    ;; Add opam emacs directory to the load-path
    ;;;  (setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
    (setq opam-share path-share)
    (add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))
    ;; Load merlin-mode
    (require 'merlin)
    ;; Start merlin on ocaml files
    (add-hook 'tuareg-mode-hook 'merlin-mode t)
    (add-hook 'caml-mode-hook 'merlin-mode t)
    ;; Enable auto-complete
    (setq merlin-use-auto-complete-mode 'easy)
    ;; Use opam switch to lookup ocamlmerlin binary
    ;;;  (setq merlin-command 'opam)
    (setq merlin-command path-merlin)
    ))
