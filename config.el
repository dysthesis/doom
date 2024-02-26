(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 12.0 :weight 'medium)
     doom-variable-pitch-font (font-spec :family "SF Pro Display" :size 13.0 :weight 'medium)
     line-spacing 1.11)

(after! org
  (custom-set-faces!
              '(org-level-1 :foreground "#ffffff" :height 1.4 :weight bold)
              '(org-level-2 :foreground "#ffffff" :height 1.2 :weight bold)
              '(org-level-3 :foreground "#ffffff" :height 1.1 :weight bold)
              '(org-level-4 :foreground "#ffffff" :height 1.0 :weight bold)
              '(org-level-5 :foreground "#ffffff" :height 0.9 :weight bold)
              '(org-document-title :height 2.0 :foreground "#ffffff" :weight heavy)
              '(org-time-grid :foreground "#ffffff")))

(after! org
  (custom-set-faces!
    '(org-block :background "#000000")
              '(org-block-begin-line :background "#000000" :foregorund "#eeeeee")
              '(org-block-end-line :background "#000000" :foregorund "#eeeeee")))

(setq doom-theme 'catppuccin)
(load-theme 'catppuccin t t)
(catppuccin-set-color 'base "#000000")
(catppuccin-set-color 'mantle "#0f0f0f")
(catppuccin-set-color 'crust "#1f1f1f")
(catppuccin-set-color 'text "#ffffff")
(catppuccin-reload)

(setq display-line-numbers-type 'relative)

(use-package mixed-pitch
  :hook
  ;; You might want to enable it only in org-mode or both text-mode and org-mode
  ((org-mode) . mixed-pitch-mode)
  :config
  (setq mixed-pitch-fixed-pitch-faces
        (append mixed-pitch-fixed-pitch-faces
                '(org-table
                  org-code
                  org-block
                  org-block-begin-line
                  org-block-end-line
                  org-meta-line
                  org-document-info-keyword
                  org-tag
                  org-time-grid
                  org-todo
                  org-done
                  org-agenda-date
                  org-date
                  org-drawer
                  org-modern-tag
                  org-modern-done
                  org-modern-label
                  org-scheduled
                  org-scheduled-today
                  neo-file-link-face
                  org-scheduled-previously)))
  (add-hook 'mixed-pitch-mode-hook #'solaire-mode-reset))

(defun dysthesis/dashboard-setup ()
  (let* ((banner '("                                   "
	           "                                   "
	           "                                   "
	           "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          "
	           "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       "
	           "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     "
	           "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    "
	           "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   "
	           "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  "
	           "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   "
	           " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  "
	           " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ "
	           "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     "
	           "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     "
	           "                                   "))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat line (make-string (max 0 (- longest-line (length line))) 32)))
               "\n"))
     'face 'doom-dashboard-banner)))

(setq +doom-dashboard-ascii-banner-fn #'dysthesis/dashboard-setup)

(setq org-directory "~/Org/")

(after! org
  (setq org-ellipsis " ↪"))

(setq org-pretty-entities t)

(setq org-archive-location "~/Org/archive.org::* From =%s=")

(defun dysthesis/org-archive-done-tasks ()
  "Archive all done tasks."
  (interactive)
  (org-map-entries 'org-archive-subtree "/DONE" 'file))

(after! org
  (setq org-refile-targets '(("~/Org/GTD/gtd.org" :maxlevel . 2)
                           ("~/Org/GTD/someday.org" :level . 2)
                           ("~/Org/GTD/tickler.org" :maxlevel . 2)
                           ("~/Org/GTD/routine.org" :maxlevel . 2)
                           ("~/Org/GTD/reading.org" :maxlevel . 2))))

(after! org-agenda
  (setq org-agenda-start-day "0d")
  (setq org-agenda-skip-scheduled-if-done t
        org-agenda-skip-deadline-if-done t)
  (setq org-agenda-include-deadlines t)
  (setq org-agenda-block-separator nil))

(after! org
  (setq org-agenda-files (directory-files-recursively "~/Org/GTD/" "\\.org$")))

(after! org
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "WAIT(w)" "PROG(p)" "|" "DONE(d)" "|" "CANCEL(c)"))))

(after! org
  (setq org-agenda-sorting-strategy
        '((urgency-up deadline-up priority-down effort-up))))

(add-to-list 'org-modules 'org-habit t)

(defun dysthesis/mark-inbox-todos ()
  "Mark entries in the agenda whose category is 'inbox' for future bulk action."
  (let ((entries-marked 0)
        (regexp "inbox")  ; Set the search term to 'inbox'
        category-at-point)
    (save-excursion
      (goto-char (point-min))
      (goto-char (next-single-property-change (point) 'org-hd-marker))
      (while (re-search-forward regexp nil t)
        (setq category-at-point (get-text-property (match-beginning 0) 'org-category))
        (if (or (get-char-property (point) 'invisible)
                (not category-at-point))  ; Skip if category is nil
            (beginning-of-line 2)
          (when (string-match-p regexp category-at-point)
            (setq entries-marked (1+ entries-marked))
            (call-interactively 'org-agenda-bulk-mark))))
      (unless entries-marked
        (message "No entry matching 'inbox'.")))))

(defun dysthesis/org-agenda-process-inbox-item ()
  "Process a single item in the org-agenda."
  (org-with-wide-buffer
   (org-agenda-set-tags)
   (org-agenda-priority)

   ;; Get the marker for the current headline
   (let* ((hdmarker (org-get-at-bol 'org-hd-marker))
          (category (completing-read "Category: " '("University" "Home" "Tinkering" "Read"))))
     ;; Switch to the buffer of the actual Org file
     (with-current-buffer (marker-buffer hdmarker)
       (goto-char (marker-position hdmarker))
       ;; Set the category property
       (org-set-property "CATEGORY" category))

   (call-interactively 'dysthesis/my-org-agenda-set-effort)
   (org-agenda-refile nil nil t))))

(defvar dysthesis/org-current-effort "1:00"
  "Current effort for agenda items.")
(defun dysthesis/my-org-agenda-set-effort (effort)
  "Set the effort property for the current headline."
  (interactive
   (list (read-string (format "EFFORT [%s]: " dysthesis/org-current-effort) nil nil dysthesis/org-current-effort)))
  (setq dysthesis/org-current-effort effort)
  (org-agenda-check-no-diary)
  (let* ((hdmarker (or (org-get-at-bol 'org-hd-marker)
                       (org-agenda-error)))
         (buffer (marker-buffer hdmarker))
         (pos (marker-position hdmarker))
         (inhibit-read-only t)
         newhead)
    (org-with-remote-undo buffer
      (with-current-buffer buffer
        (widen)
        (goto-char pos)
        (org-show-context 'agenda)
        (funcall-interactively 'org-set-effort nil dysthesis/org-current-effort)
        (end-of-line 1)
        (setq newhead (org-get-heading)))
      (org-agenda-change-all-lines newhead hdmarker))))

(defun dysthesis/bulk-process-entries ()
  (let ())
  (if (not (null org-agenda-bulk-marked-entries))
      (let ((entries (reverse org-agenda-bulk-marked-entries))
            (processed 0)
            (skipped 0))
        (dolist (e entries)
          (let ((pos (text-property-any (point-min) (point-max) 'org-hd-marker e)))
            (if (not pos)
                (progn (message "Skipping removed entry at %s" e)
                       (cl-incf skipped))
              (goto-char pos)
              (let (org-loop-over-headlines-in-active-region) (funcall 'dysthesis/org-agenda-process-inbox-item))
              ;; `post-command-hook' is not run yet.  We make sure any
              ;; pending log note is processed.
              (when (or (memq 'org-add-log-note (default-value 'post-command-hook))
                        (memq 'org-add-log-note post-command-hook))
                (org-add-log-note))
              (cl-incf processed))))
        (org-agenda-redo)
        (unless org-agenda-persistent-marks (org-agenda-bulk-unmark-all))
        (message "Acted on %d entries%s%s"
                 processed
                 (if (= skipped 0)
                     ""
                   (format ", skipped %d (disappeared before their turn)"
                           skipped))
                 (if (not org-agenda-persistent-marks) "" " (kept marked)")))))

(defun dysthesis/org-process-inbox ()
  "Called in org-agenda-mode, processes all inbox items."
  (interactive)
  (dysthesis/mark-inbox-todos)
  (dysthesis/bulk-process-entries))

(setq org-log-done 'time
      org-log-into-drawer t
      org-log-state-notes-insert-after-drawers nil)
(defun log-todo-next-creation-date (&rest ignore)
  "Log NEXT creation time in the property drawer under the key 'ACTIVATED'"
  (when (and (string= (org-get-todo-state) "NEXT")
             (not (org-entry-get nil "ACTIVATED")))
    (org-entry-put nil "ACTIVATED" (format-time-string "[%Y-%m-%d]"))))
(add-hook 'org-after-todo-state-change-hook #'log-todo-next-creation-date)

(defun dysthesis/org-inbox-capture ()
  (interactive)
  "Capture a task in agenda mode."
  (org-capture nil "i"))
(defun dysthesis/org-capture-todo ()
  (interactive)
  (org-capture nil "tt"))
(defun dysthesis/org-capture-todo-with-deadline ()
  (interactive)
  (org-capture nil "td"))
(defun dysthesis/org-capture-todo-with-schedule ()
  (interactive)
  (org-capture nil "ts"))

(map! :map org-agenda-mode-map
      "i" #'org-agenda-clock-in
      "r" #'dysthesis/org-process-inbox
      "R" #'org-agenda-refile)


(bind-key "C-c t" #'dysthesis/org-capture-todo)
(bind-key "C-c d" #'dysthesis/org-capture-todo-with-deadline)
(bind-key "C-c s" #'dysthesis/org-capture-todo-with-schedule)

(defface busy-1  '((t :foreground "black" :background "#eceff1")) "")
(defface busy-2  '((t :foreground "black" :background "#cfd8dc")) "")
(defface busy-3  '((t :foreground "black" :background "#b0bec5")) "")
(defface busy-4  '((t :foreground "black" :background "#90a4ae")) "")
(defface busy-5  '((t :foreground "white" :background "#78909c")) "")
(defface busy-6  '((t :foreground "white" :background "#607d8b")) "")
(defface busy-7  '((t :foreground "white" :background "#546e7a")) "")
(defface busy-8  '((t :foreground "white" :background "#455a64")) "")
(defface busy-9  '((t :foreground "white" :background "#37474f")) "")
(defface busy-10 '((t :foreground "white" :background "#263238")) "")
(defadvice calendar-generate-month
    (after highlight-weekend-days (month year indent) activate)
  "Highlight weekend days"
  (dotimes (i 31)
    (let* ((org-files (directory-files-recursively "~/Org/GTD" "\\.org$"))
           (date (list month (1+ i) year))
           (count 0))
      (dolist (file org-files)
        (setq count (+ count (length (org-agenda-get-day-entries file date)))))
      (cond ((= count 0) ())
            ((= count 1) (calendar-mark-visible-date date 'busy-1))
            ((= count 2) (calendar-mark-visible-date date 'busy-2))
            ((= count 3) (calendar-mark-visible-date date 'busy-3))
            ((= count 4) (calendar-mark-visible-date date 'busy-4))
            ((= count 5) (calendar-mark-visible-date date 'busy-5))
            ((= count 6) (calendar-mark-visible-date date 'busy-6))
            ((= count 7) (calendar-mark-visible-date date 'busy-7))
            ((= count 8) (calendar-mark-visible-date date 'busy-8))
            ((= count 9) (calendar-mark-visible-date date 'busy-9))
            (t  (calendar-mark-visible-date date 'busy-10)))
      )))

(after! org-agenda
  (setq org-super-agenda-keep-order t))

(after! org-agenda
  (let ((inhibit-message t))
    (org-super-agenda-mode)))

(setq org-agenda-custom-commands
      '(("o" "Overview"
         ((agenda "" ((org-agenda-span 'day)
                      (org-super-agenda-groups
                       '((:name "Today"
                          :time-grid t
                          :deadline today
                          :scheduled today
                          :order 0)
                         (:habit t
                          :order 1)
                         (:name "Overdue"
                          :deadline past
                          :scheduled past
                          :order 2)
                         (:name "Upcoming"
                          :time-grid t
                          :scheduled future
                          :deadline future
                          :order 3)))))
          (alltodo "" ((org-agenda-overriding-header "")
                       (org-super-agenda-groups
                        '((:name "Ongoing"
                           :todo "PROG"
                           :order 0)
                          (:name "Up next"
                           :todo "NEXT"
                           :order 1)
                          (:name "Waiting"
                           :todo "WAIT"
                           :order 2)
                          (:name "Important"
                           :priority "A"
                           :order 3)
                          (:name "Inbox"
                           :file-path "inbox"
                           :order 4)
                          (:name "University"
                           :category "University"
                           :tag ("university"
                                 "uni"
                                 "assignment"
                                 "exam")
                           :order 5)
                          (:name "Tinkering"
                           :category "Tinkering"
                           :tag ("nix"
                                 "nixos"
                                 "gentoo"
                                 "emacs"
                                 "tinker")
                           :order 6)
                          (:name "Reading list"
                           :category "Read"
                           :tag "read"
                           :order 6)))))))))

(defun dysthesis/agenda ()
  (interactive)
  (org-agenda nil "o"))

(use-package! org-agenda
  :init
  (map! "C-c a" #'dysthesis/agenda))

(use-package! doct
  :commands doct)

(after! org
  (setq org-capture-templates
        (doct '((" Todo"
                 :keys "t"
                 :prepend t
                 :file "GTD/inbox.org"
                 :headline "Tasks"
                 :type entry
                 :template ("* TODO %? %{extra}")
                 :children ((" General"
                             :keys "t"
                             :extra "")
                            ("󰈸 With deadline"
                             :keys "d"
                             :extra "\nDEADLINE: %^{Deadline:}t")
                            ("󰥔 With schedule"
                             :keys "s"
                             :extra "\nSCHEDULED: %^{Start time:}t")))
                ("Bookmark"
                 :keys "b"
                 :prepend t
                 :file "bookmarks.org"
                 :type entry
                 :template "* TODO [[%:link][%:description]] :bookmark:\n\n"
                 :immediate-finish t)))))

(package-initialize)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(dolist (face '(window-divider
                window-divider-first-pixel
                window-divider-last-pixel))
  (face-spec-reset-face face)
  (set-face-foreground face (face-attribute 'default :background)))
(set-face-background 'fringe (face-attribute 'default :background))

(setq org-hide-emphasis-markers t)

(setq  org-modern-list
       '((42 . "•")
         (43 . "◈")
         (45 . "➤")))

(setq org-modern-block-name
      '((t . t)
        ("src" "»" "«")
        ("example" "»–" "–«")
        ("quote" "" "")
        ("export" "⏩" "⏪")))

(setq org-modern-block-fringe 6)

(use-package org-modern-indent
  :config ; add late to hook
  (add-hook 'org-mode-hook #'org-modern-indent-mode 90))

(setq org-modern-keyword
 '((t . t)
   ("title" . "𝙏 ")
   ("filetags" . "󰓹 ")
   ("auto_tangle" . "󱋿 ")
   ("subtitle" . "𝙩 ")
   ("author" . "𝘼 ")
   ("email" . #(" " 0 1 (display (raise -0.14))))
   ("date" . "𝘿 ")
   ("property" . "☸ ")
   ("options" . "⌥ ")
   ("startup" . "⏻ ")
   ("macro" . "𝓜 ")
   ("bind" . #(" " 0 1 (display (raise -0.1))))
   ("bibliography" . " ")
   ("print_bibliography" . #(" " 0 1 (display (raise -0.1))))
   ("cite_export" . "⮭ ")
   ("print_glossary" . #("ᴬᶻ " 0 1 (display (raise -0.1))))
   ("glossary_sources" . #(" " 0 1 (display (raise -0.14))))
   ("include" . "⇤ ")
   ("setupfile" . "⇚ ")
   ("html_head" . "🅷 ")
   ("html" . "🅗 ")
   ("latex_class" . "🄻 ")
   ("latex_class_options" . #("🄻 " 1 2 (display (raise -0.14))))
   ("latex_header" . "🅻 ")
   ("latex_header_extra" . "🅻⁺ ")
   ("latex" . "🅛 ")
   ("beamer_theme" . "🄱 ")
   ("beamer_color_theme" . #("🄱 " 1 2 (display (raise -0.12))))
   ("beamer_font_theme" . "🄱𝐀 ")
   ("beamer_header" . "🅱 ")
   ("beamer" . "🅑 ")
   ("attr_latex" . "🄛 ")
   ("attr_html" . "🄗 ")
   ("attr_org" . "⒪ ")
   ("call" . #(" " 0 1 (display (raise -0.15))))
   ("name" . "⁍ ")
   ("header" . "› ")
   ("caption" . "☰ ")
   ("results" . "🠶")))

(setq org-agenda-tags-column 0
      org-agenda-block-separator ?─
      org-agenda-time-grid
      '((daily today require-timed)
        (800 1000 1200 1400 1600 1800 2000)
        " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
      org-agenda-current-time-string
      "⭠ now ─────────────────────────────────────────────────")

(setq org-modern-todo-faces
 '(("WAIT"
    :inverse-video t
    :inherit +org-todo-onhold)
   ("NEXT"
    :inverse-video t
    :foreground "#89b4fa")
   ("PROG"
    :inverse-video t
    :foreground "#a6e3a1")
   ("TODO"
    :inverse-video t
    :foreground "#fab387")))

(global-org-modern-mode)

(setq org-roam-directory (file-truename "~/Org/Roam"))

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-dailies-capture-templates
      '(("d" "default" entry "* %<%H:%M> %?"
         :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))
  (org-roam-dailies-directory "Daily/")
  :bind
  (("C-c n l" . org-roam-buffer-toggle)
       ("C-c n f" . org-roam-node-find)
       ("C-c n i" . org-roam-node-insert)
       ("C-c i" . org-roam-node-insert)
       ("C-c n q" . org-roam-node-insert-immediate)
       ("C-c n t" . org-roam-tag-add)
       ("C-c n c" . org-roam-capture)
       ("C-c n a" . org-roam-alias-add)
       :map org-mode-map
       ("C-M-i"    . completion-at-point)
       :map org-roam-dailies-map
       ("y" . org-roam-dailies-capture-yesterday)
       ("t" . org-roam-dailies-capture-tomorrow))
  :bind-keymap
  ("C-c n d" . org-roam-dailies-map)
  :config
  (org-roam-db-autosync-mode)
  (require 'org-roam-dailies)
  (set-popup-rules!
  `((,(regexp-quote org-roam-buffer) ; persistent org-roam buffer
     :side right :width .33 :height .5 :ttl nil :modeline nil :quit nil :slot 1)
    ("^\\*org-roam: " ; node dedicated org-roam buffer
     :side right :width .33 :height .5 :ttl nil :modeline nil :quit nil :slot 2))))
  (setq org-roam-capture-templates
        '(("d" " Default" plain
           "%?"
           :if-new (file+head "${slug}.org"
                              "#+title: ${title}\n#+filetags: :new:\n#+STARTUP: latexpreview")
           :immediate-finish t
           :unnarrowed t)
          ("i" "󰆼 Index note" plain
           "%?"
           :if-new (file+head "${slug}.org"
                              "#+title: ${title}\n#+filetags: :new:index:")
           :immediate-finish t
           :unarrowed t)
          ("e" "󰖟 Elfeed" plain
           "%?"
           :target (file+head "Elfeed/${slug}.org"
                              "#+title: ${title}\n#+filetags: :new:article:rss:\n#+STARTUP: latexpreview"
                              ;;"#+filetags: :article:rss:\n"
                              )
           :unnarrowed t)
          ("l" "󰙨 Literature note" plain
           "%?"
           :target
           (file+head
            "%(expand-file-name (or citar-org-roam-subdir \"\") org-roam-directory)/Literature/${citar-citekey}.org"
            "#+title: ${note-title}.\n#+filetags: :new:\n#+created: %U\n#+last_modified: %U\n#+STARTUP: latexpreview\n\n* Annotations\n:PROPERTIES:\n:Custom_ID: ${citar-citekey}\n:NOTER_DOCUMENT: ${citar-file}\n:NOTER_PAGE: \n:END:\n\n")
           :unnarrowed t)
          ("d" " Idea" plain "%?"
           :if-new
           (file+head "${slug}.org" "#+title: ${title}\n#+filetags: :idea:new:\n#+STARTUP: latexpreview\n")
           :immediate-finish t
           :unnarrowed t))))

(defun org-roam-node-insert-immediate (arg &rest args)
  (interactive "P")
  (let ((args (cons arg args))
        (org-roam-capture-templates (list (append (car org-roam-capture-templates)
                                                  '(:immediate-finish t)))))
    (apply #'org-roam-node-insert args)))

(defadvice! doom-modeline--buffer-file-name-roam-aware-a (orig-fun)
  :around #'doom-modeline-buffer-file-name ; takes no args
  (if (s-contains-p org-roam-directory (or buffer-file-name ""))
      (replace-regexp-in-string
       "\\(?:^\\|.*/\\)\\([0-9]\\{4\\}\\)\\([0-9]\\{2\\}\\)\\([0-9]\\{2\\}\\)[0-9]*-"
       "🢔(\\1-\\2-\\3) "
       (subst-char-in-string ?_ ?  buffer-file-name))
    (funcall orig-fun)))

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
  :after org ;; or :after org
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t
        org-roam-ui-custom-theme
        '((bg-alt . "#0f0f0f")
          (bg . "#000000")
          (fg . "#ffffff")
          (fg-alt . "#cdd6f4")
          (red . "#f38ba8")
          (orange . "#fab387")
          (yellow ."#f9e2af")
          (green . "#a6e3a1")
          (cyan . "#94e2d5")
          (blue . "#89b4fa")
          (violet . "#8be9fd")
          (magenta . "#f5c2e7"))))
