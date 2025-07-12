;;; $DOOMDIR/config.el --- setup emacs -*- lexical-binding: t; no-byte-compile: t; coding: utf-8-unix;  -*-

;; Author: jvh
;; Email: jan.vanhest@gmail.com

;;; Commentary:

;; This is the config file for `Doom Emacs' on Emacs 30.5.

;;; Code:

(setq user-full-name "Jan van Hest"
      user-mail-address "jan.vanhest@gmail.com")

(defvar var-dir (expand-file-name "var" user-emacs-directory))
(defvar lisp-source-dir (expand-file-name "site-lisp/" user-emacs-directory))
(add-to-list 'load-path lisp-source-dir t)

(defvar my/frame-transparency 90 "Frame transparency.")
(defvar my/display-line-numbers-enable
  '(prog-mode-hook conf-mode-hook) "Modes with line-numbers.")

(defvar my/fill-width 110 "The default width at which to wrap text.")
(defvar my/tab-width 2 "Default width for indentation, in spaces.")
(defvar my-leader-key "SPC" "Default leader key.")
(defvar my-leader-secondary-key "C-SPC" "Secondary leader key.")
(defvar my-major-leader-key "," "Default major mode leader key.")
(defvar my-major-leader-secondary-key "M-," "Secondary major mode leader key.")

(defvar my/org-dir-local "~/org-files" "Base directory for org related file.")
(defvar my/org-dir-sync "~/Dropbox/org" "Base dir for syncing to android app.")

(defvar my/agenda-projects (expand-file-name "projects.org" my/org-dir-local)
  "Inbox file project related tasks.")
(defvar my/agenda-notes (expand-file-name "notes.org" my/org-dir-local)
  "Notes file.")
(defvar my/agenda-archive (expand-file-name "archive.org" my/org-dir-local)
  "Archive file for DONE TODOs.")
(defvar my/agenda-index (expand-file-name "index.org" my/org-dir-local)
  "Inbox file for todo's.")
(defvar my/agenda-inbox (expand-file-name "inbox.org" my/org-dir-local)
  "Personal tasks, reminders and so on.")

(defvar my/capture-bookmarks (expand-file-name "bookmarks.org" my/org-dir-local)
  "Captured weblinks.")

(set-face-attribute 'default nil
                    :family "JetBrainsMono Nerd Font"
                    :height 140
                    :weight 'semi-light)

(set-face-attribute 'fixed-pitch nil
                    :family "JetBrainsMono Nerd Font"
                    :height 140
                    :weight 'semi-light)

(set-face-attribute 'variable-pitch nil
                    :family "Cantarell"
                    :height 165
                    :weight 'regular)

(set-face-attribute 'mode-line nil
                    :family "SpaceMono Nerd Font"
                    :height 140
                    :weight 'semi-light)

(setq custom-safe-themes t)

(setq doom-theme nil)

(require-theme 'modus-themes)
(setq modus-themes-custom-auto-reload nil
      modus-themes-to-toggle '(modus-vivendi-deuteranopia
                               modus-operandi-deuteranopia)
      modus-themes-mixed-fonts t
      modus-themes-variable-pitch-ui t
      modus-themes-italic-constructs t
      modus-themes-bold-constructs t
      modus-themes-completions
      '((matches . (extrabold intense))
	(selection . (extrabold intense))
	(popup . (extrabold intense)))
      modus-themes-prompts '(extrabold)
      modus-themes-headings
      '((agenda-structure . (fixed-pitch light 2.2))
	(agenda-date . (fixed-pitch regular 1.3))
	(t . (regular 1.15)))
      modus-themes-fringes 'subtle
      modus-themes-tabs-accented t
      modus-themes-paren-match '(bold intense)
      modus-themes-org-blocks 'tinted-background
      modus-themes-scale-headings t
      modus-themes-region '(bg-only))

(setq modus-themes-common-palette-overrides
      '((bg-mode-line-active bg-lavender)
	(bg-mode-line-inactive bg-dim)
	(border-mode-line-inactive bg-inactive)
	(fringe subtle)
	(bg-completion gray)
	(bg-paren-match bg-yellow-intense)))

(setq modus-themes-headings
      '((1 . (extrabold 1.35))
        (2 . (bold 1.28))
        (3 . (bold 1.22))
        (4 . (bold 1.17))
        (5 . (bold 1.14))
        (t . (semibold 1.1))))

(load-theme (car modus-themes-to-toggle) t)

(define-key global-map (kbd "<f5>") #'modus-themes-toggle)

(setq initial-scratch-message "")
(customize-set-variable 'initial-major-mode 'emacs-lisp-mode)  ;; for fast loading

;; dired
(add-hook! 'dired-mode-hook #'all-the-icons-dired-mode)

;; line-numbers
(global-display-line-numbers-mode)           ; No line numbers unless ...
(setq-default display-line-numbers-type 'relative
              display-line-numbers-width 3      ; Enough space for big files
              display-line-numbers-widen t)     ; Enable dynamic sizing
;; (dolist (mode my/display-line-numbers-enable)
;;   (add-hook mode  (lambda () (display-line-numbers-mode -1)))

(setq help-window-select t)    ; Focus new help windows when opened

(global-prettify-symbols-mode t)   ;; Enables use of ligatures in Emacs

(setq scroll-margin 0
      fast-but-imprecise-scrolling t   ; Make scrolling less stuttered
      scroll-conservatively 101        ; > 100
      scroll-preserve-screen-position t
      auto-window-vscroll nil)

;; Make shebang (#!) file executable when saved
(add-hook!
  ('after-save . #'executable-make-buffer-file-executable-if-script-p))

(setq-default
 indent-tabs-mode nil
 tab-width my/tab-width
 fill-column my/fill-width                      ; Wrap lines after this point
 word-wrap t
 require-final-newline t
 sentence-end-double-space nil)

(setq large-file-warning-threshold 100000000
      global-auto-revert-non-file-buffers t
      kill-do-not-save-duplicates t)  ; kill-ring

(set-default-coding-systems 'utf-8)
(global-superword-mode 1)             ; e.g. this-is-a-symbol is one word
(global-auto-revert-mode 1)           ; Revert buffers when file has changed
(global-so-long-mode 1)               ; Support for files with long lines

(map! :m "C-h" #'evil-window-left
      :m "C-j" #'evil-window-down
      :m "C-k" #'evil-window-up
      :m "C-l" #'evil-window-right)

(after! doom-modeline
  (setq doom-modeline-height 30
        doom-modeline-bar-width 6
        doom-modeline-buffer-encoding t
        doom-modeline-lsp t
        doom-modeline-icon nil
        doom-modeline-minor-modes nil
        doom-modeline-buffer-file-name-style 'relative-to-project))

(after! beancount
  (setq +beancount-files '("/home/jvh/BeanCount/main-accounts.bean")))

(after! org
  (add-hook! 'org-mode-hook #'org-appear-mode)
  (add-hook! 'org-mode-hook #'org-bullets-mode)
  (add-hook! 'org-mode-hook #'(lambda () (display-line-numbers-mode -1)))

  (setq org-directory "~/org-files/"
        org-tags-column 0
        org-pretty-entities t
        org-default-notes-file (expand-file-name "notes.org" org-directory)
        org-ellipsis " 󱞣 "
        org-catch-invisible-edits 'smart
        org-log-done 'time
        org-hide-emphasis-markers t
        org-support-shift-select t
        org-src-preserve-indentation nil
        org-src-tab-acts-natively t
        org-edit-src-content-indentation 0)

  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "IDEA(i)" "|" "DONE(d)")))
  (setq org-todo-keyword-faces
        '(("TODO" . 'all-the-icons-red)
          ("NEXT" . 'all-the-icons-blue)
          ("IDEA" . 'all-the-icons-green)
          ("DONE" . 'all-the-icons-orange))))

(after! org
  (setq org-agenda-files '("~/org-files/todo.org" "~/org-files/agenda.org")
        org-agenda-block-separator 8411)

  (custom-set-faces!
    '(org-agenda-calendar-event :inherit variable-pitch)
    '(org-agenda-calendar-sexp :inherit variable-pitch)
    '(org-agenda-filter-category :inherit variable-pitch)
    '(org-agenda-filter-tags :inherit variable-pitch)
    '(org-agenda-date :inherit variable-pitch :weight bold :height 1.09)
    '(org-agenda-date-weekend :inherit variable-pitch :weight bold :height 1.06)
    '(org-agenda-done :inherit variable-pitch :weight bold)
    '(org-agenda-date-today :inherit variable-pitch :weight bold :slant italic :height 1.12)
    '(org-agenda-date-weekend-today :inherit variable-pitch :weight bold :height 1.09)
    '(org-agenda-dimmed-todo-face :inherit variable-pitch :weight bold)
    '(org-agenda-current-time :inherit variable-pitch :weight bold)
    '(org-agenda-clocking :inherit variable-pitch :weight bold))

  (add-hook! 'org-agenda-mode-hook 'mixed-pitch-mode)

  (add-hook! 'org-agenda-mode-hook (hide-mode-line-mode 1))

  (setq org-priority-faces
        '((?A :foreground "#ff6c6b" :weight bold)
          (?B :foreground "#98be65" :weight bold)
          (?C :foreground "#c678dd" :weight bold))))

(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t))

(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

(map! :leader
      (:prefix("r" . "registers")
       :desc "Copy to register" "c" #'copy-to-register
       :desc "Frameset to register" "f" #'frameset-to-register
       :desc "Insert contents of register" "i" #'insert-register
       :desc "Jump to register" "j" #'jump-to-register
       :desc "List registers" "l" #'list-registers
       :desc "Number to register" "n" #'number-to-register
       :desc "Interactively choose a register" "r" #'counsel-register
       :desc "View a register" "v" #'view-register
       :desc "Window configuration to register" "w" #'window-configuration-to-register
       :desc "Increment register" "+" #'increment-register
       :desc "Point to register" "SPC" #'point-to-register))

(setq shell-file-name "/bin/bash"
      vterm-max-scrollback 5000)

(map! :leader
      :desc "Vterm popup toggle"     "v t" #'+vterm/toggle)

(provide 'config)
;;; config.el ends here
