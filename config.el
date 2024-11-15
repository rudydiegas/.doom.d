(setq org-directory "~/org/")



;; visuals
(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Fira Code" :size 13))

(setq doom-theme 'moe-dark)
(custom-set-faces!
  `(font-lock-comment-face :foreground "#496b52"))

(setq display-line-numbers-type 'relative)

(setq show-paren-style 'expression)
(setq +doom-dashboard-ascii-banner-fn #'draw-laptop-girl-banner)
(blink-cursor-mode)



;; keybindings
(map! :n "TAB" #'+fold/toggle)
(map! :leader
      :desc "Toggle theme brightness"
      "z" #'toggle-theme)
(map! :leader
      :desc "Open a new vterm"
      "m" #'multi-vterm)



;; verilog setup
(use-package verilog-mode
  :config
  ;; "I prefer 2 space tabs, so all the defaults have to go."
  (setq verilog-indent-level              2
        verilog-indent-level-module       2
        verilog-indent-level-declaration  2
        verilog-indent-level-behavioral   2
        verilog-indent-level-directive    2
        verilog-indent-begin-after-if     2
        verilog-case-indent               2
        verilog-indent-declaration-macros 2

        ;; "This is 0 to prevent automatic indentation after declaring `default_nettype none"
        verilog-cexp-indent              2
        verilog-minimum-comment-distance 10
        verilog-auto-lineup              '(all)

        verilog-ext-formatter-column-limit 80
        verilog-ext-formatter-over-column-limit-penalty 80
        verilog-ext-formatter-line-break-penalty 1000)
  (add-hook 'verilog-mode-hook #'rainbow-delimiters-mode))


;; (add-hook 'verilog-mode-hook #'lsp-mode)

(use-package verilog-ext
  :hook ('verilog-mode-hook . 'verilog-ext-mode)
  :config
  (setq verilog-ext-feature-list
     '(font-lock
       xref
       capf
       hierarchy
       lsp
       flycheck
       beautify
       navigation
       template
       formatter
       compilation
       imenu
       which-func
       hideshow
       typedefs
       time-stamp
       block-end-comments
       ports))
  (setq verilog-ext-lsp-mode-default-server 've-veridian)
  (setq verilog-ext-flycheck-linter 'verilog-slang)
  (setq verilog-ext-flycheck-use-open-buffers t)
  (verilog-ext-mode-setup)
  (verilog-ext-lsp-set-server 've-veridian))



;; theme toggling between moe light and dark
(defun toggle-theme ()
  (interactive)
  (if (eq doom-theme 'moe-dark)
    (progn
      (load-theme 'moe-light)
      (custom-set-faces!
        `(font-lock-comment-face :foreground "#c685cf")
        `(font-lock-comment-delimiter-face :foreground "#d4a2db")
        `(default :background "#ffffd7"))
      (setq +doom-dashboard-ascii-banner-fn #'draw-kiki-cat-banner))
    (progn
      (load-theme 'moe-dark)
      (custom-set-faces!
        `(font-lock-comment-face :foreground "#496b52")
        `(font-lock-comment-delimiter-face :foreground "#62906e")
        `(default :background "#303030"))
      (setq +doom-dashboard-ascii-banner-fn #'draw-laptop-girl-banner)))
  (+doom-dashboard-reload-maybe-h))



;; custom banners
(defun draw-kiki-cat-banner ()
  (let* ((banner
          '("⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⢀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⢀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⠟⠉⠀⠀⠀⠙⢿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠙⢻⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⣠⣄⠀⢻⣿⣿⣿⣿⣿⡿⠀⣠⣄⠀⠀⠀⢻⣿⣿⣏⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⣾⣿⣿⣿⣿⠀⠀⠀⠀⠰⣿⣿⠀⢸⣿⣿⣿⣿⣿⡇⠀⣿⣿⡇⠀⠀⢸⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠙⠃⠀⣼⣿⣿⣿⣿⣿⣇⠀⠙⠛⠁⠀⠀⣼⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣷⣤⣄⣀⣠⣤⣾⣿⣿⣿⣿⣽⣿⣿⣦⣄⣀⣀⣤⣾⣿⣿⣿⣿⠃⠀⠀⢀⣀⠀⠀"
            "⠰⡶⠶⠶⠶⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠛⠉⠉⠙⠛⠋⠀"
            "⠀⠀⢀⣀⣠⣤⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠷⠶⠶⠶⢤⣤⣀⠀"
            "⠀⠛⠋⠉⠁⠀⣀⣴⡿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣤⣀⡀⠀⠀⠀⠀⠘⠃"
            "⠀⠀⢀⣤⡶⠟⠉⠁⠀⠀⠉⠛⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⠉⠀⠀⠀⠉⠙⠳⠶⣄⡀⠀⠀"
            "⠀⠀⠙⠁⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠁⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿ E M A C S ⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat
                 line (make-string (max 0 (- longest-line (length line)))
                                   32)))
               "\n"))
     'face 'doom-dashboard-banner)))

(defun draw-laptop-girl-banner ()
  (let* ((banner
          '("⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣤⣤⣤⣤⣄⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⠶⣻⠝⠋⠠⠔⠛⠁⡀⠀⠈⢉⡙⠓⠶⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠞⢋⣴⡮⠓⠋⠀⠀⢄⠀⠀⠉⠢⣄⠀⠈⠁⠀⡀⠙⢶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠞⢁⣔⠟⠁⠀⠀⠀⠀⠀⠈⡆⠀⠀⠀⠈⢦⡀⠀⠀⠘⢯⢢⠙⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡼⠃⠀⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠸⠀⠀⠀⠀⠀⢳⣦⡀⠀⠀⢯⠀⠈⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⠆⡄⢠⢧⠀⣸⠀⠀⠀⠀⠀⠀⠀⢰⠀⣄⠀⠀⠀⠀⢳⡈⢶⡦⣿⣷⣿⢉⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣯⣿⣁⡟⠈⠣⡇⠀⠀⢸⠀⠀⠀⠀⢸⡄⠘⡄⠀⠀⠀⠈⢿⢾⣿⣾⢾⠙⠻⣾⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⡿⣮⠇⢙⠷⢄⣸⡗⡆⠀⢘⠀⠀⠀⠀⢸⠧⠀⢣⠀⠀⠀⡀⡸⣿⣿⠘⡎⢆⠈⢳⣽⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⢠⡟⢻⢷⣄⠀⠀⠀⠀⠀⠀⣾⣳⡿⡸⢀⣿⠀⠀⢸⠙⠁⠀⠼⠀⠀⠀⠀⢸⣇⠠⡼⡤⠴⢋⣽⣱⢿⣧⠀⢳⠈⢧⠀⢻⣿⣧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⢀⡿⣠⡣⠃⣿⠃⠀⠀⠀⠀⣸⣳⣿⠇⣇⢸⣿⢸⣠⠼⠀⠀⠀⡇⠀⡀⠉⠒⣾⢾⣆⢟⣳⡶⠓⠶⠿⢼⣿⣇⠈⡇⠘⢆⠈⢿⡘⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠈⢷⣍⣤⡶⣿⡄⠀⠀⠀⢠⣿⠃⣿⠀⡏⢸⣿⣿⠀⢸⠀⠀⢠⡗⢀⠇⠀⢠⡟⠀⠻⣾⣿⠀⠀⠀⠀⡏⣿⣿⡀⢹⡀⠈⢦⠈⢷⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢁⣤⣄⠁⠀⠀⠀⣼⡏⢰⣟⠀⣇⠘⣿⣿⣾⣾⣆⢀⣾⠃⣼⢠⣶⣿⣭⣷⣶⣾⣿⣤⠀⠀⠀⡇⡯⣍⣧⠀⣷⠄⠈⢳⡀⢻⡁⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠺⣿⡿⠀⠀⠀⠀⡿⢀⣾⣧⠀⡗⡄⢿⣿⡙⣽⣿⣟⠛⠚⠛⠙⠉⢹⣿⣿⣦⠀⢸⡿⠀⠀⠀⢰⡯⣌⢻⡀⢸⢠⢰⡄⠹⡷⣿⣦⣤⠤⣶⡇⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⣇⣾⣿⢸⢠⣧⢧⠘⣿⡇⠸⣿⢿⡆⠀⠀⠀⠀⠘⣯⠇⣿⠂⣸⢰⠀⠀⢀⣸⡧⣊⣼⡇⢸⣼⣸⣷⢣⢻⣄⠉⠙⠛⠉⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣳⣤⣴⣿⣏⣿⣾⢸⣿⡘⣧⣘⢿⣀⡙⣞⠁⠀⠀⠀⠀⢀⡬⢀⣉⢠⣧⡏⠀⠀⡎⣿⣿⣿⣿⠃⣸⡏⣿⣿⡎⢿⡘⡆⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⣠⣼⣿⣿⣿⣼⣿⣧⢿⣿⣿⣯⡻⠟⠀⠀⠀⠀⠀⠐⢯⠣⡽⢟⣽⠀⠀⢘⡇⣿⣿⣿⡟⣴⣿⣷⣿⣿⣧⣿⣷⡽⠀⠀⠀⠀⠀⠀⠀"
            "⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣼⣹⣿⣇⣸⣿⣿⣿⣻⣚⣿⡿⣿⣿⣦⣤⣀⡉⠃⠀⢀⣀⣤⡶⠛⡏⠀⢀⣼⢸⣿⣿⣿⣿⣿⣿⣿⢋⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀"
            "⣿⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠒⠒⠒⢭⢻⣽⣿⣿⣿⣿⣿⣿⢿⠿⣿⡏⠀⡼⠁⣀⣾⣿⣿⣿⣿⡿⣿⣿⣟⡻⣿⣿⡿⠣⠟⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠸⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢧⢿⣯⡽⠿⠛⠋⣵⢟⣋⣿⣶⣞⣤⣾⣿⣿⡟⢉⡿⢋⠻⢯⡉⢻⡟⢿⡅⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⢻⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡞⣿⣆⡀⠀⡼⡏⠉⠚⠭⢉⣠⠬⠛⠛⢁⡴⣫⠖⠁⠀⠀⣩⠟⠁⣸⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠈⢷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣽⣿⣿⣾⠳⡙⣦⡤⠜⠊⠁⠀⣀⡴⠯⠾⠗⠒⠒⠛⠛⠛⠛⠛⠓⠿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠘⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢷⣻⣿⣿⠔⢪⠓⠬⢍⠉⣩⣽⢻⣤⣶⣦⠀⠀⠀⢀⣀⣤⣴⣾⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠹⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣾⡏⢦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣯⣿⣿⠀⠀⣇⠀⣠⠎⠁⢹⡎⡟⡏⣷⣶⠿⠛⡟⠛⠛⣫⠟⠉⢿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⢻⡄⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣷⠈⢷⡤⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣾⣷⡀⣀⣀⣷⡅⠀⠀⠈⣷⢳⡇⣿⠀⠀⣸⠁⢠⡾⣟⣛⣻⣟⡿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⢷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢯⢻⣏⡵⠿⠿⢤⣄⠀⢀⣿⢸⣹⣿⣀⣴⣿⣴⣿⣛⠋⠉⠉⡉⠛⣿⣧⡀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠘⣧⠀⠀⠀⠀⠀ E M A C S ⠀⠀⠀⠀⠀⠀⠀⠈⡎⣿⣥⣶⠖⢉⣿⡿⣿⣿⡿⣿⣟⠿⠿⣿⣿⣿⡯⠻⣿⣿⣿⣷⡽⣿⡗⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠸⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⡘⣿⣩⠶⣛⣋⡽⠿⣷⢬⣙⣻⣿⣿⣿⣯⣛⠳⣤⣬⡻⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀"
            "⠀⣿⣛⣻⣿⡿⠿⠟⠗⠶⠶⠶⠶⠤⠤⢤⠤⡤⢤⣤⣤⣤⣤⣄⣀⣀⣀⣀⣀⣀⣀⣀⣣⢹⣷⣶⣿⣿⣦⣴⣟⣛⣯⣤⣿⣿⣿⣿⣿⣷⣌⣿⣿⣿⣿⣿⣿⣿⣤⣤⣤⣤⣤⣤⣄"
            "⠀⠉⠙⠛⠛⠛⠛⠛⠻⠿⠿⠿⠷⠶⠶⢶⣶⣶⣶⣶⣤⣤⣤⣤⣤⣥⣬⣭⣭⣉⣩⣍⣙⣏⣉⣏⣽⣶⣶⣶⣤⣤⣬⣤⣤⣾⣿⠶⠾⠿⠿⠿⠿⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠃"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠉⠛⠛⠛⠛⠛⠛⠋⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat
                 line (make-string (max 0 (- longest-line (length line)))
                                   32)))
               "\n"))
     'face 'doom-dashboard-banner)))

(defun draw-light-gojo-banner ()
  (let* ((banner
          '("⣁⡴⣈⡼⣟⣭⣷⣿⡿⠿⡽⡟⠍⡙⢕⣢⣿⡟⣱⣿⣿⣿⣿⣿⠟⠋⡕⢼⣣⣴⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣻⢿⣩⣾⣿⡿⣿⣿⢿⣿⣿⣿⣿⡿⠛⣙⢄⣽⣿⣿⣿⡃⢹⣿⣿⣾⢫⢿⢇⣿⡟⣼⣿⡇⠯⠈⠰⣶⣾⣶⡄⢻⣿⣿⢎⣮⡹⠗⣠⣵⣶⣿⣿⣷⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
            "⣫⣾⣯⠾⠛⣋⣥⣶⡿⠟⣩⢔⣼⣾⣿⣿⠏⣼⣿⣿⢟⣿⡟⣡⢊⣼⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⣿⡿⣫⣷⣿⣿⣿⣫⢏⡼⣫⣾⣿⣿⣿⣃⢔⠟⣱⣿⣿⡿⣛⣿⣿⣿⣿⣿⣿⣏⡾⣼⡿⣸⣿⣿⠃⣴⠠⢹⣸⡿⣿⣇⡱⡊⣿⣎⣎⢷⡘⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
            "⠿⢋⢥⣺⣯⣷⡿⢋⣴⣯⣾⡿⢟⢛⣻⠏⣼⣿⣿⠏⣾⣿⠟⣵⣿⣿⣿⣿⡿⠿⠟⠛⣛⣉⣥⣴⣶⡿⢟⣿⣿⣿⣿⡟⠑⣡⠯⣺⣿⣿⣿⣿⡿⢋⣴⣾⠿⠟⣫⣾⣿⣿⡟⣼⣿⣿⣿⡙⣽⡟⣵⣿⣿⣥⣦⡏⡇⠈⡏⣷⡹⣿⣦⠑⡜⣿⣯⢫⢭⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
            "⣥⣼⠿⣫⣥⢈⣶⠶⢛⢍⡒⣡⡶⣼⠏⣰⣿⣿⢋⠶⢿⢥⣾⣮⣭⣿⢤⣤⡶⡾⣻⣿⠟⣨⣿⡿⢋⣴⣿⡿⣛⡟⡁⣴⡞⣡⣾⣿⢟⣭⣿⡿⠱⠟⡡⡊⣠⣾⣿⡿⣫⣟⣼⣿⢫⢯⣿⢸⣿⣾⣿⣿⣿⣿⢼⣷⣿⠀⣷⢿⢸⣜⢿⣷⡘⣞⢿⣷⡵⡣⠘⢿⣿⣿⣿⣿⣿⣿⣿⠿⢟⡛⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
            "⡟⢡⣾⡿⢃⢈⡴⠚⠑⣋⣾⢟⠊⡄⢠⣿⡿⢃⡴⡵⣳⣿⢟⣵⡿⣵⡿⠿⠹⣼⣿⠏⣼⡿⢋⣴⣿⡿⣫⣪⢞⣡⠟⣢⣾⣿⠟⣵⡿⠛⣩⠞⣡⠪⢞⣾⣿⠟⢡⢞⠉⢊⣿⠇⡜⣸⡇⢠⣿⣿⣿⢿⣿⡟⣾⢹⣿⢈⣿⢸⠰⢻⡄⣻⣿⣎⢈⠻⣿⣞⢆⢸⣿⡿⢿⣻⣭⣷⣾⣿⣿⣿⣿⣶⣬⡛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
            "⣴⣿⠟⢑⣫⣷⠖⣡⣾⡿⡵⢁⡞⢻⣾⡟⢁⣞⣞⡽⣟⣵⡿⣫⠿⢋⡴⢰⣱⣿⠇⣼⠏⣠⣾⣿⢯⣾⢞⢵⣫⣷⢾⡯⠫⢠⡞⣡⢮⠞⣱⠞⣡⣢⣿⡿⠑⡠⣵⢇⣆⣾⡏⣼⠃⣿⠀⣽⡏⣿⡏⣼⣿⢳⡏⢨⡏⢘⣿⡔⢈⣸⣿⠱⡹⣿⢸⣰⡌⢛⣣⣬⣷⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣬⡻⢿⣿⣿⣿⣿⣿⣿⣿⣿"
            "⠩⢁⣴⣿⢟⣵⣾⡟⠩⠊⢒⢽⣾⣧⣻⡌⣾⢉⣬⠞⠏⠩⢚⣡⣾⠿⡃⡎⣿⠏⡼⢃⣼⣿⡟⢕⠕⣡⣴⢿⡫⠟⣙⣤⣶⠟⢌⡵⢋⡜⣡⡾⣵⣿⠟⢀⣤⡾⣱⡟⢌⡞⣰⡇⣠⡟⡠⣿⡇⣿⡇⣾⣿⡾⢀⣾⡟⣸⣿⣧⢸⣧⣿⢹⠁⣟⣬⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣙⢿⣿⣿⣿⣿⣿⣿"
            "⣤⣿⢟⡵⠟⣁⣨⢁⣾⡌⣿⠂⢻⣿⡧⣁⠵⣋⡴⢊⡔⠈⠼⡿⣫⣾⠀⣹⣿⣿⢡⡾⣿⣋⣤⣧⠿⠫⢓⡩⣴⣾⡿⣫⠉⢠⣞⡷⢪⣤⣟⣽⣿⠏⣴⣿⢏⣾⡿⠘⡞⢱⡿⣠⣿⠇⡆⣿⡇⣿⢇⣿⣿⠁⣾⣿⢳⣿⠿⢇⣦⠻⣉⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣙⢿⣿⣿⣿⣿"
            "⠏⠕⣩⣴⣿⡿⣣⡿⡳⣣⢹⠀⣃⠅⡨⠠⠞⢱⡞⣼⠛⣆⣧⣝⢛⡻⠤⢯⣟⣃⣲⣯⣿⠿⢛⢡⣶⣾⠛⣴⡿⣫⣾⠃⣰⣯⡟⣱⣯⣏⣼⣿⢃⣾⣿⢣⣿⢏⠄⡼⢡⣿⠇⣼⡿⢠⡏⣿⡇⣿⠈⣿⠇⣾⣿⢧⣿⠃⢀⣾⡟⡰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡙⣿⣿⣿"
            "⠇⣼⣿⣿⢟⡼⠋⣠⠞⠋⠀⠈⣤⣤⢷⢸⡟⣨⡇⠁⣇⢸⣿⣿⣷⣮⢁⠔⡭⠋⠉⡠⣊⡞⣳⣿⣿⣫⣼⢟⣾⣿⠁⡴⣳⢏⣾⣿⣟⡾⢻⣯⣿⣿⡡⢭⢏⡟⢰⢁⡟⡘⢰⣿⡅⣐⡚⣿⡇⣿⢂⡟⣼⣿⢏⣸⠇⣨⣼⡟⡌⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣈⢻⣿"
            "⠗⠝⡫⠞⣩⡔⣂⣮⢠⣶⡇⡐⡰⣶⠊⢸⠇⣿⡧⡗⣼⢾⣬⣭⡝⡡⡣⠚⠔⠀⢘⣼⣿⢳⣿⣿⣷⣿⣵⣿⣿⠃⣼⣵⢯⣿⣿⡟⣜⢡⡟⢹⣿⢱⣿⣿⣾⠃⢢⡟⣠⢇⣿⣿⡇⡯⠇⣽⡇⣿⢸⡽⣻⢟⠘⠈⣰⣿⡟⢸⢷⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⠋⢹⣿⡏⢹⣿⡟⠁⠈⣿⡿⠁⣿⣿⠁⣹⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⢹"
            "⣀⣥⣴⣾⣳⣾⢟⣵⢯⠞⡠⢳⢷⡭⢰⡏⡇⡏⡇⡅⢻⣿⡿⢋⠈⡀⣰⡷⠀⣠⣈⡹⢛⡿⠿⣿⣿⣿⣿⣿⡿⠰⣳⢫⣿⣿⣿⠹⣁⡾⢡⢸⢣⣿⣿⣿⠿⠐⢋⠚⡈⣬⣭⣴⣶⣞⡇⣿⡇⣿⣸⣱⠟⣎⡇⣸⣿⡟⣼⡟⡾⢸⣿⣿⣿⣿⣿⣿⣿⣿⡏⠀⠈⡿⢀⡾⠋⣠⠆⠀⣿⠁⠈⠉⠁⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⢸"
            "⣿⣿⣿⠟⣫⣴⠿⠕⣡⢮⡾⡘⣦⣿⡸⡇⠀⡅⢡⢥⢐⡋⢦⣶⡿⢯⣽⢧⢡⣿⣺⣟⣶⣾⣥⣜⣢⠫⣉⠿⣿⣾⢏⣿⣿⣿⣿⢰⠻⢣⣿⢈⡬⠝⣀⣲⣤⣴⣟⢞⣽⣿⣿⣿⡿⣿⡿⢸⡗⣿⠉⢣⡇⣿⢠⣿⣿⡹⠟⣼⢷⢸⣿⣿⣿⣿⣿⣿⣿⡿⠀⣶⠀⠀⡼⠁⣀⣠⡄⠠⠇⢠⣾⡟⢀⣾⡿⠋⣹⣿⣿⣿⣿⣿⣿⣿⡟⢸"
            "⠿⣋⣡⣘⣣⣴⡾⣽⣳⢏⡼⠁⠙⣿⡇⢿⠀⠻⡾⣸⣿⣿⡐⠢⠩⠀⠐⠀⠭⢒⣚⠯⢭⣛⡿⣿⣿⣷⣶⢤⡹⡟⣼⣿⣿⣿⣿⣮⣴⡿⠿⣄⣶⣾⣿⣿⡿⢟⣫⠭⠿⠒⠢⠤⠔⠀⠀⠘⣧⣿⠌⣿⠃⡟⣼⣿⣿⣇⠆⡿⣼⢸⣿⣿⣿⣿⣿⣿⣿⣧⣼⣿⣧⣼⣧⣼⣿⣿⣦⣴⣤⣿⣿⣦⣼⡟⣡⣾⣿⣿⣿⣿⣿⣿⣿⣿⡇⣼"
            "⣾⣿⣿⣿⣿⡿⣽⠃⢡⣾⠁⢞⣧⢹⡇⢸⡇⢧⢷⡉⣿⣿⣿⡃⠜⣿⣿⡇⢻⣷⡂⢸⣤⣈⠙⠂⣿⣿⣿⣧⢠⢸⣿⣿⣿⣿⣿⣿⡟⠁⣹⣿⣿⣿⣿⡿⠐⢋⠁⣤⣖⣘⣻⠇⣼⣿⣿⠃⣹⡏⠸⢃⡏⠀⣻⣿⣿⣟⡀⣇⡏⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠿⠛⢿⠛⢻⡿⠟⠛⠛⠛⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣿"
            "⣿⣿⣿⣿⣿⠗⢋⣴⣿⡏⠀⣾⡿⠀⠇⣾⡉⣘⣿⣧⡸⣿⣿⣧⡡⢻⣿⣿⣦⣘⠿⢽⣛⣽⣷⡀⠸⣿⣿⣿⣃⡀⣿⣿⣿⣿⣿⣿⡟⣧⣹⣿⣿⣿⣿⠃⢰⣿⣷⣝⡻⢛⣋⣴⣿⣿⢏⣇⢻⡌⠈⡸⢽⠐⣿⣿⡟⣼⣱⡿⣠⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡄⢠⣶⠀⣴⣿⠀⣠⣶⣶⠂⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣿"
            "⣿⣿⣿⣿⣿⣶⣿⣿⣿⠀⢰⣿⠃⡜⠀⢻⡇⢸⣿⣿⣷⣽⣿⣿⣿⣣⡻⢿⣿⣿⣿⣿⣿⣿⡿⢠⣐⢉⢉⡿⢉⣴⣿⣿⣿⣿⣿⣿⣿⣾⣿⡿⠻⢿⡏⢠⣌⢿⣿⣿⣿⣿⣿⣿⡿⣫⣜⣿⢳⢠⢹⡇⣸⣷⣾⢛⡇⢿⡟⣱⣿⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣾⣿⣿⣿⡏⢠⠿⠛⢁⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣿"
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⢠⡜⣣⣾⢁⣃⢹⣿⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣶⣾⣿⣥⣴⣿⣳⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣬⠡⠛⢿⣾⣶⣶⣶⣶⣿⣿⣿⣿⣿⣿⣿⠈⡇⢾⣷⣿⣿⡿⢸⣿⡞⡀⣾⣿⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⠉⢁⣀⣠⣽⣿⣿⣀⣀⣤⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣿"
            "⣿⣿⣿⣿⣿⣿⣿⣿⣻⣵⣾⣿⢇⢈⡜⣅⠹⡇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢏⣸⣧⢻⣿⣿⣿⡇⣿⡟⡀⡆⣿⣿⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣿"
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⢊⣬⣾⣿⣷⣤⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣾⣿⣿⣾⣿⣿⡿⠸⠟⠠⢠⢣⢿⣿⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⢹⡟⠈⢹⣿⠃⣸⠏⢸⡏⠈⣿⡿⠁⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣿"
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⡆⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⣴⠀⡏⣸⡇⠎⢿⡛⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⡟⢁⠀⠸⠃⣰⡟⢀⡿⠀⡀⠘⠃⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⣽"
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⣸⣿⠀⠀⣿⣿⢰⣾⡇⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⢠⣾⡀⠀⣴⡿⠁⣾⠁⣼⣷⠀⢠⣿⠛⢙⣿⣿⣿⣿⣿⣿⣿⣿⡇⣿"
            "⣿⡿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⢠⣿⡏⠠⣸⣿⣷⣿⣿⢃⣨⣿⣿⣿⣿⣿⣿⣿⣷⣶⣿⣿⣷⣾⣿⣷⣼⣿⣶⣿⣿⣷⣾⣿⣶⣿⣿⣿⣿⣿⣿⣿⣿⡿⣡⣿"
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠀⣾⣿⢁⣵⣿⣿⣿⣿⣿⣆⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣱⣿⣿"
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣬⡻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⣴⣿⣿⣿"
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣴⡙⢿⣿⡿⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠋⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣽⡻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⣼⣿⣿⣿⣿"
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⢂⡹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣾⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⣡⠀⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣯⣝⡻⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠟⠋⢁⣾⣿⣿⣿⣿⣿"
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⢱⡌⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⣡⣾⠃⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢿⣛⣿⣿⣿⣿⣿⣷⣶⣬⡁⣨⠿⣛⣛⣛⣻⣿⣿⣿⣿⣷⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠐⠌⣿⣆⠹⣿⣿⣿⣿⣿⣏⣙⣻⠿⠿⢿⣿⣿⣿⣿⣿⡿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢿⣟⣋⣤⣾⣿⣿⣿⡿⢣⣾⣿⢏⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⡴⣩⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⡳⢹⣿⣷⡈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣗⢦⡀⠀⠤⣤⣤⣤⣤⣤⣤⣄⠤⠖⡀⢴⣶⣿⣿⣿⣿⣿⣿⣿⡿⢋⣴⣿⡿⠋⣀⠀⣺⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⣨⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢰⣌⠊⣿⣿⣿⣆⠙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣮⣙⠛⠛⠒⠒⠒⠒⠒⡖⢒⣩⣼⣿⣿⣿⣿⣿⣿⣿⡿⢋⣴⣿⣿⣿⠍⣐⡇⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢸⣿⣷⣿⣿⣿⣿⣷⡌⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢋⣴⣿⣿⣿⣿⡏⢀⡳⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢸⣿⣿⣿⣿⣿⣿⣿⣖⢀⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⣱⣿⣿⣿⣿⣿⣿⡯⢅⡾⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠃⠘⣿⡷⣝⢿⣿⣿⣿⣿⡧⠢⡀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁⣰⣿⣿⣿⣿⣿⣿⣭⣾⣿⡇⡆⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⠉⠀⠀⠀⠀⣿⣿⣮⡳⡍⠿⣿⣿⣿⣌⠺⢔⣌⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁⢂⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠋⠁⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⡌⠲⣜⢿⣿⣿⣿⡄⢠⣹⣷⣆⣉⠛⠿⠿⠿⠿⢿⠿⡿⠿⠿⠟⠋⣀⠤⡢⢼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠉⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
            "⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣷⡐⢔⢌⢿⣿⣿⣿⣄⠐⢿⣿⣿⣿⣿⣷⣶⣶⣦⣦⣴⣤⣦⡔⠲⢌⡱⣴⣿⣿⣿⠟⢋⣩⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠈⠛⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
            "⣿⣿⣿⣿⡿⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣷⢠⠓⢮⣻⣿⣿⣿⣎⢈⠽⣛⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠣⠕⢲⣿⣿⣿⣿⢏⣰⣾⠿⣿⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
            "⣿⠿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⣇⢙⢴⢙⣿⣿⣿⣿⣷⡱⣦⣪⠬⣽⣛⡿⡟⣻⣿⣿⣣⣌⣴⣿⣿⣿⡿⢁⡴⢚⣋⠸⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⢝⢆⢻⣿⣿⣿⣿⣧⢩⣫⠭⢟⣻⢒⣼⣿⣿⣯⢅⣾⣿⣿⡿⢋⡀⢦⣼⠯⣭⣶⣾⡿⠟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠘⠿⢿⣿⣿⣿⣄⣺⢭⣻⡆⢾⣿⣿⣿⡄⣿⣿⣿⡟⠁⠀⢴⡟⣮⡿⠼⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat
                 line (make-string (max 0 (- longest-line (length line)))
                                   32)))
               "\n"))
     'face 'doom-dashboard-banner)))

(defun draw-young-gojo-banner ()
  (let* ((banner
          '("⣀⠂⡐⢠⢀⢂⠰⢠⡔⢲⡘⢦⡹⢜⡬⠳⣍⡞⣱⢯⡹⣭⢻⣭⢻⣭⢻⡝⣯⢻⡽⣏⣟⣻⡽⣻⣟⣯⣟⡿⣻⣟⣿⣻⣟⣿⢿⡿⣟⣿⣻⣟⣿⣛⣿⣟⡿⣟⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡙⠿⣿"
            "⠄⢂⡁⢆⡰⡌⢎⠵⣨⠓⡼⢡⢎⢣⢞⡱⢣⢞⡱⣎⠷⣭⢳⣎⠷⣞⣽⡺⣵⢯⣷⣻⢮⢷⣻⢷⡽⣖⣯⣟⡷⣯⢾⣳⣟⣾⢯⡿⣽⡾⣷⣻⣼⣻⢿⢯⣟⣯⢷⡿⣿⢎⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣌"
            "⢌⠲⢌⢢⠱⡌⢭⠒⡥⢛⠬⡓⠎⠳⠊⠵⣉⠶⡹⣜⡻⣜⡳⣎⢿⣙⢶⡹⣝⢮⡳⣭⣛⢯⣏⢿⣽⡻⣼⢯⣻⣭⣿⣳⢿⣞⣯⣿⣳⡿⣏⢯⣷⢿⣟⣯⡿⣽⣯⣿⡏⠈⣿⣿⣿⣾⣿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
            "⠊⠖⡌⢆⠳⡘⠦⠙⠀⠀⠀⢀⠠⡰⣉⠖⣩⢞⡱⢧⢻⣜⡳⣝⢮⡟⣾⡹⣽⣚⡷⢯⣏⢿⡞⣯⣞⡽⣯⣻⣵⣻⠾⣽⣻⢾⡽⣮⠿⣵⣻⢯⣟⡾⣞⣯⣟⣯⢿⣷⠃⡀⢻⣿⢯⣷⣿⣷⠙⢿⣿⣿⣿⣿⣿⡿⣿⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
            "⢉⠐⡈⠄⡂⢄⠠⡐⠰⡈⠖⡡⢧⠑⠀⢙⢦⢫⡝⢮⡳⣎⢷⡹⢮⡽⣲⣛⡶⣹⣝⢷⣹⡞⣽⢮⡗⣟⣳⡽⣞⡽⠂⢸⡿⣽⣞⢻⣽⣛⣯⢟⣾⣻⣟⣾⣯⣟⣿⡛⢀⡇⢸⣿⣻⣟⣿⣟⠠⡌⢻⣿⣿⣿⣿⣧⢹⡇⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⣿⣿⣿⣿"
            "⠆⠌⡐⢂⠥⡈⢆⢡⠣⡙⡬⠅⣠⠞⢠⡋⣎⢗⡺⣣⡝⣮⢳⡝⣯⢞⣵⢫⣞⡵⣏⣯⢳⡽⣏⢷⡻⣝⣳⢯⡿⠁⡄⢺⡿⡝⣦⡿⢾⡽⣮⢿⣷⢯⣟⡷⣿⣼⢿⠃⡸⡜⢰⣿⣻⣟⣿⣯⢘⡷⠈⣿⣿⣿⣿⣿⠸⣿⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣮⠛⣿⣿⣿⣿⣿"
            "⢂⠜⠠⣁⠢⡑⢌⢢⠣⡝⢂⣼⠋⡀⡴⡹⡜⢮⡕⢧⡻⣜⢧⡻⣜⢯⣞⡳⣝⢾⡹⢮⢯⠷⣯⡗⣿⡭⣟⢮⡏⠐⣆⠻⣝⣾⣟⣳⢘⣿⣽⡏⢸⣿⣞⡿⣷⣻⡿⠀⡵⢣⠘⣷⣟⣿⢿⣷⠨⣟⣄⠙⣿⣿⣿⣿⣇⣿⠀⡀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣌⠻⣿⣿⣿"
            "⡠⠌⡐⢄⠢⡑⢊⢆⢋⣴⠟⠁⠄⣸⢱⡱⣙⣎⢞⣣⡝⣮⢳⡝⣞⡳⣞⡵⣻⢮⣻⡝⣯⣻⢧⡟⣧⢿⡹⡏⠀⡜⢀⡼⣟⣲⡽⡇⢸⢷⢾⡇⢸⣯⣟⣿⣽⢽⡗⠀⣯⢳⡀⢼⡿⣯⣿⣿⠀⣟⢾⡃⠈⣿⣿⣿⣿⣿⡇⣿⡄⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⣿⣿⣿⣿⢹⣿⣿⣿⣿⣷⣌⠻⣿"
            "⢄⠒⣈⢄⠣⣌⢣⡤⡾⠃⣐⢣⡄⢧⣃⠷⡱⢎⡾⣡⢻⡜⣧⣛⢮⢷⡹⣞⢧⣛⢶⣛⣧⢟⣮⢿⣹⣏⡷⠃⢀⡰⠎⢹⣾⡝⣾⠁⠈⣿⢯⡇⢸⣯⡿⣞⣻⣞⠃⣰⢭⡳⢦⠈⢿⣿⣯⣿⢀⡿⣞⡽⡆⠹⣿⣷⣿⢿⡇⢸⣷⡀⢿⣿⣧⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⡞⣿⣿⡇⢿⣿⣿⣿⣿⣿⣷⣮"
            "⠄⢃⠌⣈⠱⣈⠦⠁⣄⠲⡜⢢⣙⠲⣌⠳⣍⡳⣣⠇⣻⡜⣧⡝⣮⢗⡻⣎⡿⣜⢯⣳⢞⣯⡞⣷⣏⡾⠃⠠⠉⣀⠆⢸⡽⣽⣻⠀⠄⣟⢯⡇⢸⡷⣟⣯⣿⢏⠀⡽⢎⡳⢯⠄⢺⠽⣿⣿⠨⣷⢺⣝⢷⡀⢿⣿⣿⢺⣇⢸⣿⣇⠘⣿⣿⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣧⢹⣿⣿⡈⣷⣮⣝⡛⠿⢿⣿"
            "⠘⠄⡸⢀⠃⠀⡀⠼⣀⠧⣘⠧⣘⢧⣘⠃⣇⢧⢣⠄⣇⠿⣤⢻⡜⣟⢧⡟⣼⢻⣼⢻⡿⣤⢿⡤⣟⠃⠀⢀⠸⣣⠄⢸⢿⣸⡇⢠⠀⢻⣜⡇⢸⣿⣻⣤⣿⠇⢸⡸⣟⡻⣟⡄⠸⣼⣿⣿⠀⡿⣟⡼⢿⣤⠘⣿⣿⣿⣿⢸⣧⣿⡄⢻⣿⣀⠘⢿⣿⣿⣿⣿⣿⣿⣿⡿⢿⣿⣿⡜⣿⣿⡘⣿⣿⣧⠸⣿⣿⣿⣧⣤⣤"
            "⢉⠰⠐⡂⣄⠢⣍⠲⣡⠚⡴⠣⠊⢂⣡⠀⣜⢪⢳⠀⣏⠿⣜⢧⣛⣮⡳⣏⢷⣛⡮⢿⡼⣫⣟⢾⣹⡏⠀⢲⢬⢱⢊⢸⣻⣜⡃⢠⠃⠸⣯⡇⢸⣯⣟⡾⣿⠀⢎⣳⢭⡳⣝⢶⠀⢻⡷⣿⠀⢿⡜⣯⣛⢾⡆⠸⣿⣿⣿⠸⣝⢾⣧⣘⣿⣿⣧⠘⣿⣿⣿⣿⣿⣿⣿⡇⣿⣿⣿⢧⣿⣿⣧⠹⣿⣿⣇⢹⣿⣿⣿⣿⣿"
            "⡀⢎⠱⡐⠢⠑⠆⠓⣀⣩⣤⣶⣿⣿⠃⠰⣎⠳⡌⢠⠞⡽⣎⢷⡹⣖⡻⣜⣧⢻⣼⡏⢠⢷⣏⣞⣧⠁⡜⣸⢢⢋⡆⢸⡳⣽⠀⣀⢏⠀⣿⡅⢸⣳⢏⣿⡝⢠⢞⣥⡻⣵⢫⣾⠁⠸⣿⣿⠀⣯⣝⢺⡽⣞⠳⠀⢻⣧⣿⢸⣏⢿⣹⣿⢻⣿⣿⣦⢸⣿⣿⣿⣿⡐⣿⢣⣿⣿⣟⢸⣷⠸⣿⡄⠻⣿⣿⣆⠻⣿⣿⣿⣿"
            "⠔⠈⠀⠁⠠⣤⣶⣾⣿⣿⣿⣿⣿⡟⢀⡳⣌⠻⡄⠨⢏⡳⣎⢷⡹⣞⡵⣫⢞⣧⢻⠆⢘⡷⣞⡵⣯⠀⢎⡱⢪⡑⡆⢸⡳⡃⢀⠆⡞⡀⢸⡇⢸⣽⣛⡾⠇⠘⡾⣰⢟⡼⣳⠎⠁⠄⢻⣿⠀⡳⠎⠓⡠⠄⠒⠉⠀⣿⡿⠀⠋⠻⠯⣽⣿⢻⣯⣿⡄⢿⣿⣿⣿⢸⣿⢸⣿⢻⡏⢈⣿⢠⡝⣿⡰⣝⢿⣿⣧⡙⣿⣿⣿"
            "⢐⠨⠐⣁⠣⣼⣿⣿⣿⣿⣿⠿⠋⠀⣀⠗⣬⠳⠁⢸⠡⠙⢨⠷⣹⢎⣷⡹⢾⣌⡿⠀⠈⡽⣎⢷⡍⠘⠨⠑⠃⠱⠂⢸⢳⠁⢨⢎⡱⢡⠀⣟⠈⣾⢭⣿⡁⢰⣍⡳⣏⢾⡱⡷⣬⡐⠘⣿⡀⠁⠀⠁⠀⠀⡀⠀⠀⢻⡟⠀⢀⠀⠀⠀⠈⠛⢾⡿⣧⠘⣿⣿⡇⣿⡇⣿⡿⣸⡇⢸⣿⠸⣷⡘⣧⢿⣧⡝⠿⣷⣌⢻⣿"
            "⠈⡄⢡⠀⠆⠻⠛⠛⠉⠁⠀⠀⠀⠢⣍⢚⡴⡉⢀⢇⠰⠁⢨⠫⣵⢫⠶⣝⡳⢮⡓⠀⡂⠌⡿⣼⠁⢨⡑⢎⡔⢢⠅⠸⡏⠀⢠⠂⡌⢑⠢⠘⡄⡿⢮⣷⠀⠰⣎⡵⣫⢞⡵⣛⡶⣹⠀⢻⡅⠀⠀⠀⠂⢁⠠⠀⠁⠈⡇⠀⠀⠀⠀⢀⠀⠀⠀⠙⠿⠃⢹⣿⡇⣿⠁⣿⡷⣹⢠⣿⡿⠀⢸⣷⣼⣷⠿⣿⣶⣮⣙⣆⣿"
            "⠅⠐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣌⠓⡤⠣⠌⠀⡘⣎⠀⠀⢠⡛⢦⢫⠟⣼⢹⣏⡇⠠⢅⠈⣷⢹⠀⠂⠉⠀⠈⠀⠀⠸⠀⠀⠀⠈⠀⠂⠡⠀⣄⢹⡻⣼⠀⢳⣌⡳⣝⢮⡳⣝⢮⡁⠀⠀⡇⠀⠀⠌⠐⠀⠀⠀⠐⠀⠁⠀⠀⡀⢀⠀⢀⠀⠀⠀⠀⢶⠌⣿⠀⡇⠀⢸⡇⠑⣿⣿⠁⡄⣿⣿⣿⣿⣿⣟⠻⣿⣿⣾⣿"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠜⡠⠍⠒⠀⠀⢠⢓⠀⠀⠀⠀⢇⠫⡜⣏⣞⠳⢞⡄⠐⡊⠄⢩⡓⠀⠀⠀⠀⠀⠀⠀⠘⠀⠀⠀⠀⠀⠀⠀⠀⠘⢈⠡⠄⠀⣣⢜⡱⣎⢧⢳⡍⢎⠀⠀⠀⢀⠀⠀⠀⠂⠀⡀⠀⠀⠀⠀⠀⠀⠀⠂⠌⠤⡈⠄⠀⠀⠀⠀⠃⠀⢰⠐⢸⡷⢶⣿⠃⢠⣤⣿⣿⣿⣿⣿⣿⣦⣤⣿⣿⣿"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⢄⠊⠐⠀⠀⠀⠀⠀⠆⠁⠀⠈⠀⠀⢚⢤⡋⡖⢮⠃⢨⠆⠐⡁⠀⠈⣇⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⢠⠌⣠⠄⢸⡐⢮⡱⢎⠧⣏⣌⠃⠀⠀⢀⠀⠀⠀⠁⠀⠐⠀⠀⠀⠀⠀⠀⡀⠀⠈⡌⠰⠠⠀⠈⠄⠀⢸⠆⣼⡘⠀⣼⣿⢸⡏⡀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠌⠀⠀⠄⠀⢀⠀⠈⢶⡁⣸⢹⠀⠈⠆⠀⠀⠀⠀⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠇⠀⢮⡁⠀⢙⢦⡙⣎⠳⡜⠢⠁⠀⠀⠀⠀⠀⠀⠀⢀⠂⠤⠐⠂⢌⠢⠑⠀⠀⠡⠐⠡⠁⠀⠌⡐⠀⢸⠘⣿⡇⣈⠃⡏⠾⢠⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢊⠀⠀⢂⠀⠃⡜⢦⡃⠀⢀⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠅⢂⠀⠔⡳⢨⠏⡠⠖⠀⠀⠀⠀⠁⡀⠄⠀⠠⠈⠄⠠⠀⢀⠀⡀⢀⠠⠁⠌⠀⢀⠀⠂⠀⠀⡜⢨⣿⡇⢻⡍⢻⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠄⠠⠘⢦⠁⠀⠀⠂⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⠠⠀⢀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠡⠎⠐⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⠈⠀⠁⠈⠠⠐⠀⠀⠀⠀⠀⠄⠂⠀⠈⠀⢀⡿⢠⣿⠃⠽⢇⣄⠘⣿⣿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡙⢆⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⢀⡀⣀⢠⠚⡄⠀⠀⠀⠀⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⠂⠁⠀⠂⠀⠀⢠⣾⣏⢸⣿⠀⠰⣿⡟⠰⣌⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡰⠀⠀⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡌⡀⢚⡤⢓⡌⡎⢽⡠⢠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⠀⡀⠀⠂⠁⢀⣴⡿⢿⡇⢸⣿⠈⡇⣿⡏⠀⠈⠻⣄⡙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠱⠀⢀⠁⡂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡱⠘⣌⠣⡜⣡⠞⣩⠖⣩⠖⡔⢂⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣰⣟⣻⣿⣿⠁⢻⡟⠀⢣⠘⣯⠀⠀⠀⠈⠳⣄⡙⢿⣿⣿⣿⣿⣿⣿⣿⣿"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⠀⠠⠁⢂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡰⢡⡙⢤⠛⡴⡑⢮⠥⣛⠴⣫⡙⢧⣚⢵⡢⢦⡄⣤⢠⡄⣤⢠⡤⣤⢶⣞⣯⡷⣿⣿⣿⣿⣿⡂⣿⡇⠀⠀⠀⠹⠀⠀⢀⠀⠀⠈⠹⢦⡙⢿⣿⣿⣿⣿⣿⣿"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠡⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠢⡑⢥⠚⡤⢛⠴⣙⢬⠳⣽⡘⣥⡛⡼⡜⡶⣹⢲⡝⣲⢏⡾⣱⢏⣾⣱⣟⡾⣯⣿⣿⣿⣿⣿⣿⠂⣿⠁⠀⠀⠀⠈⠀⠀⠄⠀⠁⠀⠀⠈⠙⢦⡌⠛⢿⣿⣿⣿"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠠⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠠⣀⠒⡄⣓⡘⠦⡙⡔⢫⠜⣜⢪⡙⣷⡽⢰⢫⡕⡯⣵⣋⢧⡻⣵⢫⡞⣧⣻⡼⣳⣯⢿⣻⣯⣿⣿⣟⣿⡏⣸⡟⠈⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠁⡀⠀⠀⠈⠛⡤⣍⠛⠿"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠠⢈⠰⢀⠂⡄⢄⠠⠄⡐⢄⠒⡌⢢⠑⠤⢋⡔⢢⢅⢣⠱⣊⢥⣋⠦⣣⠝⡜⣣⢏⡳⣜⢳⠮⣝⢮⣳⢭⡷⡽⢶⡯⣽⣻⢾⣻⣿⣽⣿⣿⣿⡟⢠⡟⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠄⠀⠀⠄⠀⠀⠀⠈⠛⡴"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⡀⢂⠡⠒⡈⢄⠢⡑⢌⠢⡑⠌⡆⡹⢨⠅⣎⠱⣊⢆⠳⡌⢆⠈⠣⡜⢎⡵⠃⠈⣱⢎⢯⡝⣮⢳⡝⣮⢗⡟⣧⡻⢷⣯⣻⣽⢿⡿⣿⣯⣽⠆⡞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⢀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⢢⠑⢨⡄⢱⠈⡆⢱⠈⡜⢰⠁⢣⡎⢰⢣⡜⡌⢳⡌⢣⠒⣤⠈⡎⣼⠙⢢⡝⡎⢳⡞⣵⢫⡞⣽⡎⣿⣵⢻⣿⡝⠉⣽⣿⣿⣿⣷⣿⠂⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠂⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠂⠰⢁⠰⠁⢎⠰⡁⢎⡑⠢⢉⠆⡸⢡⢆⡱⣉⠦⡙⢬⡒⢬⢚⠼⣡⢛⡬⢧⣙⡳⣚⣥⡛⢾⡱⣏⠷⣭⡟⠶⠉⠁⢐⣿⣍⣿⠾⠃⡤⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠔⡈⠤⢉⠂⠥⡘⠤⡈⠡⠌⡘⢡⠒⢬⠰⢡⠎⡱⢢⡙⡌⢎⠖⡥⢋⡴⢣⠖⣥⢣⠞⠹⠒⠙⣈⣉⣤⣤⠆⠀⣰⣾⢻⣿⠯⠁⡊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠐⠠⠈⠂⢅⠢⡑⠄⡀⠀⠈⠀⡉⠀⠉⠂⠌⠁⠃⠘⠘⢈⣈⣀⣉⣠⣍⣤⣤⣴⣶⣶⡿⠿⠛⢛⡡⠂⢠⣼⡻⣼⣟⡟⠀⠐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠡⢀⠂⡂⢅⠊⠔⢂⠄⠀⠁⠋⠿⠹⣞⣿⣹⢯⡟⣯⣻⡽⣯⣏⣿⣻⡽⣿⣤⣥⣴⣾⡿⠋⣠⢞⡻⢶⣹⢷⠚⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠐⢀⠂⡉⠌⡂⠜⡈⢄⠀⠒⠦⢤⣈⡽⣭⢾⣭⢷⡽⣭⣯⣷⣽⣛⣿⠿⠛⠂⣉⢄⡾⡥⣏⡻⣗⡫⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠒⡈⡐⠌⡰⠈⢆⠁⠂⢄⠈⡐⠉⠃⠛⠊⠛⠓⠙⠊⢁⣉⠠⡔⢮⣙⡜⣫⢞⡵⣫⡱⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠐⠠⠡⠘⣀⠣⡘⢄⠣⡘⠰⠉⢆⠱⢊⠜⣡⠋⠖⠌⠓⢹⢆⡳⣜⠳⡜⠧⠳⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠡⢀⠆⢡⢂⠱⡈⢆⡰⢠⢂⠤⢢⢄⠲⣐⠎⣍⢳⣊⠵⣊⢯⣉⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠊⠔⡡⠒⡌⠦⣉⢎⠱⣊⠕⣪⢙⠬⣓⠬⡓⣍⠲⠌⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠂⠈⠰⢡⠘⣐⠢⢌⢃⠦⡙⢤⢋⠖⣡⠣⠑⠎⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat
                 line (make-string (max 0 (- longest-line (length line)))
                                   32)))
               "\n"))
     'face 'doom-dashboard-banner)))
