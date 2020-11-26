;;; org-config.el -*- lexical-binding: t; -*-

;;; Configuration for Org mode

(map! "C-c a" #'org-agenda
      "C-c b" #'org-switchb
      "C-c c" #'org-capture
      "C-c l" #'org-store-link
      "S-<f11>" #'org-clock-goto
      "C-<f11>" #'my-org-clock-in
      "C-S-<f11>" #'my-org-goto-heading
      :mode org-mode
      "C-c C-x C-i" #'org-clock-in
      "C-c C-x <C-i>" #'org-clock-in
      "C-c C-x i" #'org-clock-in
      "C-c C-x C-o" #'org-clock-out
      "C-c C-x o" #'org-clock-in)

(defun my-org-clock-in ()
  "Select a recently clock-in task to clock into.  See `org-clock-in'."
  (interactive) (org-clock-in '(4)))

(defun my-org-goto-heading ()
  "Run C-u org-refile to list all headings."
  (interactive)
  ;; org-file doesn't work unless it's run from within an Org buffer, so find
  ;; an arbitrary one.
  (with-current-buffer
    (save-excursion
      (catch 'aaa
        (dolist (buffer (buffer-list))
          (with-current-buffer buffer
            (when (derived-mode-p 'org-mode)
              (throw 'aaa buffer))))))
    (org-refile '(4))))


(defun org-roam-create-note-from-headline ()
  "Create an Org-roam note from the current headline and jump to it.
Normally, insert the headline’s title using the ’#title:’ file-level property
and delete the Org-mode headline. However, if the current headline has a
Org-mode properties drawer already, keep the headline and don’t insert
‘#+title:'. Org-roam can extract the title from both kinds of notes, but using
‘#+title:’ is a bit cleaner for a short note, which Org-roam encourages."
  (interactive)
  (let ((title (nth 4 (org-heading-components)))
        (has-properties (org-get-property-block)))
    (org-cut-subtree)
    (org-roam-find-file title nil nil 'no-confirm)
    (org-paste-subtree)
    (unless has-properties
      (kill-line)
      (while (outline-next-heading)
        (org-promote)))
    (goto-char (point-min))
    (when has-properties
      (kill-line)
      (kill-line))))
