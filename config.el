;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Randy Lien"
      user-mail-address "randylien@gmail.com")

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
;; (setq doom-font (font-spec :family "JetBrains Mono" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 13))
 ;; (setq doom-font (font-spec :family "Overpass Mono" :size 12 :weight 'semi-light)
 ;;     doom-variable-pitch-font (font-spec :family "Overpass Mono" :size 13))
;; (setq doom-font (font-spec :family "DejaVu Sans Mono" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "DejaVu Sans Mono" :size 13))
(setq doom-font (font-spec :family "Fira Code" :size 14)
      doom-big-font (font-spec :family "JetBrains Mono" :size 36)
      doom-variable-pitch-font (font-spec :family "Overpass Mono" :size 14)
      doom-serif-font (font-spec :family "IBM Plex Mono" :weight 'light))


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'jetbrains-darcula)
(setq doom-theme 'doom-solarized-light)

(set-terminal-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

;; maximize emacs when launch
(add-to-list 'initial-frame-alist '(fullscreen . maximized))


;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(after! org
  (load! "org-config.el"))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(use-package! epa-file
  ;; :ensure nil
  :config
  (setq epa-file-encrypt-to '("randylien@gmail.com")
        epa-file-cache-passphrase-for-symmetric-encryption t)
  :custom
  (epa-file-select-keys 'silent))

;; (use-package! org-crypt
;;   :ensure nil  ;; included with org-mode
;;   :after org
;;   :config
;;   (org-crypt-use-before-save-magic)
;;   (setq org-tags-exclude-from-inheritance (quote ("crypt")))
;;   :custom
;;   (org-crypt-key "randylien@gmail.com"))

(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))


(after! org-journal
  ;; :bind
  ;; (map! "C-c n j" #'org-journal-new-entry)
  ;; :custom
  (setq org-journal-file-format "%Y-%m-%d.org"
        org-journal-dir "~/org/roam/journal/"
        org-journal-date-format "%A, %d %B %Y")
  ;; (org-journal-file-format "%Y-%m-%d.org")
  ;; (org-journal-dir "~/org/journal/")
  ;(org-journal-enable-encryption t)
  ;; (org-journal-date-format "%A, %d %B %Y")
  )

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
;; they are implemented.

;; (setq org-roam-directory "~/org/roam/")
;; (setq org-roam-buffer-width 0.3)
;; (setq org-roam-index-file "index.org")
;; (setq org-roam-completion-system 'helm)

;; (setq org-roam-capture-ref-templates
;;       '(("r" "ref" plain (function org-roam-capture--get-point)
;;          "%?"
;;          :file-name "websites/${slug}"
;;          :head "#+TITLE: ${title}
;; #+ROAM_KEY: ${ref}"
;;          :unnarrowed t)))

;; (org-roam-mode +1)

;; (use-package! org-download
  ;; :ensure t
  ;; :after org
  ;; :config
  ;; (
  ;;  (add-hook 'dired-mode-hook 'org-download-enable)
  ;;  (set-default org-download-image-dir "~/org/roam/images/"
                ;; )
   ;; )
  ;; :bind
  ;; (:map org-mode-map
  ;;       (("s-Y" . org-download-screenshot)
  ;;        ("s-y" . org-download-yank)))
  ;; )

;; Auto update LAST_MODIFIED: <> time
(require 'time-stamp)
(add-hook 'write-file-functions 'time-stamp)
(add-hook 'org-roam-mode-hook (lambda ()
                                (set (make-local-variable 'time-stamp-pattern)
                                     "-8/LAST_MODIFIED:[ \t]+\\\\?[\"<]+%:y-%02m-%02d %a %02H:%02M:%02S\\\\?[\">]")))
(add-hook 'org-roam-mode-hook (lambda () (add-hook 'before-save-hook 'time-stamp nil 'local)))

(after! org-roam
  ;; :hook
  ;; (after-init . org-roam-mode)
  ;; :config
  (setq org-roam-directory "~/org/roam/"
        org-roam-buffer-width 0.3
        org-roam-index-file "index.org"
        org-roam-encrypt-files t
        org-roam-link-title-format (concat "%s " (all-the-icons-octicon "link-external" :v-adjust 0))
        org-roam-completion-system 'helm
        org-roam-capture-templates
        '(("d" "default" plain (function org-roam-capture--get-point)
           "%?"
           :file-name "${slug}"
           :head "#+TITLE: ${title}\n#+CREATED: %U\n#+LAST_MODIFIED: <>\n#+ROAM_ALIAS: \n#+ROAM_TAGS: \n\n"
           :unnarrowed t))
        org-roam-capture-ref-templates
        '(("r" "ref" plain (function org-roam-capture--get-point)
           "%?"
           :file-name "websites/${slug}"
           :head "#+TITLE: ${title}\n#+ROAM_KEY: ${ref}\n#+CREATED: %U\n#+LAST_MODIFIED: <>\n#+ROAM_ALIAS: \n#+ROAM_TAGS: \n\n"
           :unnarrowed t)))
  (map! :map org-roam-mode-map
        :g "C-c r i" 'org-roam-insert
        "C-c r f" 'org-roam-find-file
        "C-c r b" 'org-roam-switch-to-buffer
        "C-c r I" 'org-roam-jump-to-index)
  )

;; (use-package org-roam-server
;;   :ensure nil
;;   :load-path "~/org/roam-server")


(setq org-todo-keywords '((sequence "☛ TODO(t)" "|" "✔ DONE(d)")
                          (sequence "⚑ WAITING(w)" "|")
                          (sequence "|" "✘ CANCELED(c)")))

;; beancount
(add-to-list 'auto-mode-alist '("\\.beancount\\'" . org-mode))
; Enable beancount as minor mode
(add-hook 'find-file-hook 'enable-beancount-mode)
(defun enable-beancount-mode ()
  (when (string= (file-name-extension buffer-file-name) "beancount")
    (org-mode)
    (beancount-mode)))

;; projectile
(use-package! projectile
  :defer 2
  ;; :diminish projectile-mode
  :config
  (projectile-global-mode))


;; cider
(use-package! cider
  :custom
  ;; nice pretty printing
  (cider-repl-use-pretty-printing nil)
  ;; nicer font lock in REPL
  (cider-repl-use-clojure-font-lock t)
  ;; result prefix for the REPL
  (cider-repl-result-prefix "; => ")
  ;; never ending REPL history
  (cider-repl-wrap-history t)
  ;; looong history
  (cider-repl-history-size 5000)
  ;; persistent history
  (cider-repl-history-file "~/.emacs.d/cider-history")
  ;; error buffer not popping up
  (cider-show-error-buffer nil)
  ;; go right to the REPL buffer when it's finished connecting
  (cider-repl-pop-to-buffer-on-connect t))

;; clj-refactor
(defun my-clojure-mode-hook ()
    (clj-refactor-mode 1)
    (yas-minor-mode 1) ; for adding require/use/import statements
    ;; This choice of keybinding leaves cider-macroexpand-1 unbound
    (cljr-add-keybindings-with-prefix "C-c C-m"))
(add-hook 'clojure-mode-hook #'my-clojure-mode-hook)
(use-package! clj-refactor)

;; org-mode

(use-package! ox-hugo
  :after ox
)


(setq org-log-done "time"
      org-log-done-with-time 't)

(setq org-hugo-auto-set-lastmod 't
      org-hugo-section "posts"
      org-hugo-suppress-lastmod-period 43200.0
      org-hugo-export-creator-string "Emacs 26.3 (Org mode 9.4 + ox-hugo)"
)

(remove-hook 'text-mode-hook #'auto-fill-mode)
(add-hook 'message-mode-hook #'word-wrap-mode)

(setq randylien/org-agenda-directory "~/org/gtd/")
(setq org-capture-templates
      `(("i" "inbox" entry (file ,(concat randylien/org-agenda-directory "inbox.org"))
         "* TODO %?")
        ("e" "email" entry (file+headline ,(concat randylien/org-agenda-directory "emails.org") "Emails")
         "* TODO [#A] Reply: %a :@home:@school:" :immediate-finish t)
        ("l" "link" entry (file ,(concat randylien/org-agenda-directory "inbox.org"))
         "* TODO %(org-cliplink-capture)" :immediate-finish t)
        ("c" "org-protocol-capture" entry (file ,(concat randylien/org-agenda-directory "inbox.org"))
         "* TODO [[%:link][%:description]]\n\n %i" :immediate-finish t)))

;; nov.el
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))


;; clojure essential ref
(use-package clojure-essential-ref-nov
  :init
  (setq clojure-essential-ref-nov-epub-path "~/Books/Clojure_The_Essential_Reference_v30_MEAP.epub")
  ;; :bind
  ;; (:map cider-mode-map
  ;;  ("C-h F" . clojure-essential-ref)
  ;;  :map cider-repl-mode-map
  ;;  ("C-h F" . clojure-essential-ref))
  )

;; company
(use-package! company
  ;; :ensure t
  :config
  (global-company-mode t)
  (setq company-idle-delay 0.3)
  (setq company-minimum-prefix-length 3)
  (setq company-backends
        '((company-files
           company-keywords
           company-capf
           company-yasnippet
           )
          (company-abbrev company-dabbrev))))

(use-package! yasnippet
  ;; :ensure t
  :config
  (yas-global-mode))
  ;; (use-package! yasnippet-snippets :ensure t))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cider-repl-history-file "~/.emacs.d/cider-history")
 '(cider-repl-history-size 5000)
 '(cider-repl-pop-to-buffer-on-connect t)
 '(cider-repl-result-prefix "; => ")
 '(cider-repl-use-clojure-font-lock t)
 '(cider-repl-use-pretty-printing nil)
 '(cider-repl-wrap-history t)
 '(cider-show-error-buffer nil)
 '(epa-file-select-keys (quote silent))
 ;; '(org-journal-date-format "%A, %d %B %Y")
 ;; '(org-journal-dir "~/org/journal/")
 ;; '(org-journal-file-format "%Y-%m-%d.org")
 '(package-selected-packages
   (quote
    (yasnippet-snippets yasnippet company org-download)))
 '(safe-local-variable-values
   (quote
    ((cider-ns-refresh-after-fn . "clj-and-cljs-app.main/start")
     (cider-ns-refresh-before-fn . "clj-and-cljs-app.main/stop")))))
;; (custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;; '(default ((t (:background "#21242b")))))

(map! :leader
      (:prefix-map ("d" . "dictionary")
                   (:prefix ("s" . "search")
                            :desc "from input" "i" #'osx-dictionary-search-input
                            :desc "from cursor" "c" #'osx-dictionary-search-word-at-point)))

(map! :leader
      (:prefix-map ("S" . "smartparens")
       (:prefix ("s" . "slurp")
        :desc "forward" "f" #'sp-forward-slurp-sexp
        :desc "backward" "b" #'sp-backward-slurp-sexp)))

;; (use-package! rime
;;   :custom
;;   (default-input-method "rime")
;;   (rime-user-data-dir "~/.emacs.d/rime")
;;   (rime-librime-root "~/.emacs.d/librime/dist")
;;   )

(use-package! deft
  :after org
  :bind ("C-c n d" . deft)
  :custom
  (deft-recursive t)
  (deft-use-filter-string-for-filename t)
  (deft-default-extension "org.gpg")
  (deft-directory "~/org/roam/"))
