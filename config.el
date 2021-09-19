;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Brian Kelley"
      user-mail-address "brian.kelley@psu.edu")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.add-hook 'emacs-startup-hook 'toggle-frame-maximized)
;; This isn't working
(setq evil-move-cursor-back 0)

(add-hook 'emacs-startup-hook 'toggle-frame-maximized)

(setq doom-font (font-spec :family "Ubuntu Mono" :size 24))



(map! :leader
      :prefix ("r" . "references")
      "d" #'doi-add-bibtex-entry
      "c" #'crossref-add-bibtex-entry
      "b" #'org-ref-find-bad-citations)

(map! :leader
      :prefix ("v" . "view")
      "w" #'orc-wc-display)

(setq projectile-project-search-path '("~/Dropbox/org/"))

(use-package! org-roam
  :custom
  (setq org-roam-directory "~/Dropbox/org/roam/")
  :config)

;(use-package! org-roam-bibtex
 ; :config
  ;(add-hook 'org-mode-hook #'org-roam-bibtex-mode))


(use-package! org-ref
  :config
  (setq org-ref-default-bibliography '("~/Dropbox/org/projects/bibliography/myrefs.bib"))
  (setq org-ref-pdf-directory "~/Dropbox/papers/")
  (setq org-ref-bibliography-notes "~/Dropbox/org/projects/bibliography/notes.org")
  (setq bibtex-completion-bibliography "~/Dropbox/org/projects/bibliography/myrefs.bib")
  (setq bibtex-completion-library-path "~/Dropbox/papers")
  (setq bibtex-completion-pdf-open-function 'org-open-file))

(setq bibtex-completion-bibliography "~/Dropbox/org/projects/bibliography/myrefs.bib"
      bibtex-completion-library-path "~/Dropbox/papers/"
      bibtex-completion-notes-path "~/Dropbox/org/projects/bibtex-notes")

(after! org
  (setq org-agenda-files (list "~/Dropbox/org/agenda.org"))
  (setq org-ellipsis " ▼ ")
  (setq org-log-done 'time)
  ;(setq org-hide-emphasis-markers t)
  (setq org-src-fontify-natively t)
  (setq org-todo-keywords
        '((sequence "TODO:(t)" "OVERDUE:(o)" "WAIT(w)" "HOLD(h)" "|" "DONE(d)" "KILL(k)")
          (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D)")
          (sequence "ZERO:(0)" "ONE:(1)" "TWO:(2)" "THREE:(3)" "FOUR:(4)" "FIVE:(5)" "SIX:(6)" "SEVEN:(7)" "EIGHT:(8)" "MANY:(m)" "|" "INFINITY:(z)")
          (sequence "CONTENT:(c)" "STRUCTURE:(s)" "CLARITY:(C)" "FLOW:(f)" "LANGUAGE:(l)" "1stDRAFT:(r)" "2ndDRAFT:(R)" "POLISHED:(p)")))
  (setq org-todo-keyword-faces
        '(("[-]" . +org-todo-active)
          ("[?]" . +org-todo-onhold)
          ("WAIT" . +org-todo-onhold)
          ("OVERDUE:" . "red1")
          ("HOLD" . +org-todo-onhold)
          ("PROJ" . +org-todo-project)
          ("ZERO:" . "#FF0000")
          ("ONE:" . "#FF1100")
          ("TWO:" . "#FF2100")
          ("THREE:" . "#FF3200")
          ("FOUR:" . "#FF4300")
          ("FIVE:" . "#FF5400")
          ("SIX:" . "#FF6400")
          ("SEVEN:" . "#FF7500")
          ("EIGHT:" . "#FF8600")
          ("MANY:" . "#FF8600")
          ("CONTENT:" . "#FF9700")
          ("STRUCTURE:" . "#FFA700")
          ("CLARITY:" . "#FFB800")
          ("FLOW:" . "#FFC900")
          ("LANGUAGE:" . "#FFDA00")
          ("1stDRAFT:" . "#FFEA00")
          ("2ndDRAFT:" . "#FFFB00")
          ("POLISHED:" . "green"))))



(use-package! citeproc-org
  :after org
  :config
  (citeproc-org-setup))

(use-package! beacon
  :config
  (setq beacon-color "orange"))

(use-package! wc-mode
  :hook
  (org-mode . wc-mode))

(beacon-mode 1)
(abbrev-mode 1)

(setq doom-modeline-enable-word-count t)

(setq-default line-spacing 0.15)

(add-hook 'evil-insert-state-exit-hook 'save-buffer)

;; Rebind C-v to evil-paste-after to make Dragon Naturally Speaking paste correctly.

;; First, unbind C-v from the defaul key map.
(define-key evil-motion-state-map (kbd "C-v") nil)

;; Bind C-v to evil-paste-after.
(global-set-key (kbd "C-v") #'evil-paste-after)

;; First, unbind C-v from the defaul key map.
(define-key evil-insert-state-map (kbd "C-v") nil)
(define-key evil-insert-state-map (kbd "C-v") 'evil-paste-after)
