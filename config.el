(setq org-directory "~/org/")



;; visuals
(blink-cursor-mode)
(setq display-line-numbers-type 'relative)
(setq show-paren-style 'expression)
(setq +doom-dashboard-ascii-banner-fn #'draw-kiki-cat-banner)
(setq whitespace-style '(face trailing))
(global-whitespace-mode +1)



(add-hook 'c-mode-hook (lambda () (flycheck-mode -1)))
(add-hook 'c-mode-hook (lambda () (lsp-mode -1)))
(add-hook 'org-mode (lambda () (whitespace-mode -1)))
(advice-add 'smartparens-mode :override #'ignore)



;; keybindings
(map! :n "TAB" #'+fold/toggle)
(map! :n "C-n" #'toggle-theme
      :desc "Toggle theme brightness")
(map! :leader
      :desc "Open a new vterm"
      "m" #'multi-vterm)
(map! :n "C-k" #'evil-scroll-up)
(map! :n "C-j" #'evil-scroll-down)

;; change this later
(map! :leader
      :desc "Search a project"
      "l" #'+vertico/project-search)



;; moe-theme configuration
;; (use-package! moe-theme
;;   :commands (moe-dark
;;              moe-light)
;;   :config
;;
;;         ;; light
;;   (setq moe-light-bg "#fdfdd7"
;;         moe-light-comment "#c685cf"
;;         moe-light-comment-delimiter "#d4a2db"
;;
;;         ;; dark
;;         moe-dark-comment "#496b52"
;;         moe-dark-comment-delimiter "#62906e"))
;;
;; (moe-light)



(use-package! seoul256-theme
  :config
  (setq seoul256-background 252)
  (load-theme 'seoul256 t))
(setq doom-theme 'seoul256)



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

        verilog-auto-newline nil
        verilog-auto-indent-on-newline nil

        ;; "This is 0 to prevent automatic indentation after declaring `default_nettype none"
        verilog-cexp-indent              2
        verilog-minimum-comment-distance 10
        verilog-auto-lineup              '(all)

        verilog-ext-formatter-column-limit 80
        verilog-ext-formatter-wrap-spaces 2
        verilog-ext-formatter-indentation-spaces 2
        verilog-ext-formatter-over-column-limit-penalty 80
        verilog-ext-formatter-line-break-penalty 1000)
;; (add-hook 'verilog-mode-hook #'lsp-mode)
  (add-hook 'verilog-mode-hook
    (lambda ()
      (define-key verilog-mode-map ";" nil)))
  (add-hook 'verilog-mode-hook #'rainbow-delimiters-mode))

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



;; scala-mode setup
(use-package scala-mode
  :config
  (setq scala-indent:step 2))



;; lsp-haskell setup
(use-package lsp-haskell
  :config
  (setq lsp-haskell-plugin-stan-global-on :json-false))



;; theme toggling between moe light and dark
;; (defun toggle-theme ()
;;   (interactive)
;;   (if (eq doom-theme 'moe-dark)
;;     (progn
;;       (moe-light)
;;       (setq +doom-dashboard-ascii-banner-fn #'draw-kiki-cat-banner))
;;     (progn
;;       (moe-dark)
;;       (setq +doom-dashboard-ascii-banner-fn #'draw-laptop-girl-banner)))
;;   (+doom-dashboard-reload-maybe-h))

(defun toggle-theme ()
  (interactive)
  (if (eq seoul256-background 252)
    (progn
      (setq seoul256-background 236)
      (setq +doom-dashboard-ascii-banner-fn #'draw-laptop-girl-banner))
    (progn
      (setq seoul256-background 252)
      (setq +doom-dashboard-ascii-banner-fn #'draw-kiki-cat-banner)))
  (load-theme 'seoul256 t)
  (+doom-dashboard-reload-maybe-h))


;; source: https://github.com/hieutkt/dotfiles/blob/0d156648056ae37237b3623450ca373f18dd6793/emacs/.doom.d/config.org
(if (string-match-p "RSVG" system-configuration-features)
    (setq org-preview-latex-default-process 'dvisvgm))

(use-package! org-latex-preview
  :after org
  :hook ((org-mode . org-latex-preview-auto-mode))
  :config
  ;; Increase preview width
  (plist-put org-latex-preview-appearance-options
             :page-width 0.6)

  ;; Block C-n and C-p from opening up previews when using auto-mode
  (add-hook 'org-latex-preview-auto-ignored-commands 'next-line)
  (add-hook 'org-latex-preview-auto-ignored-commands 'previous-line)
  ;; Ignored faces
  (pushnew! org-latex-preview--ignored-faces 'org-list-dt 'fixed-pitch)

  ;; Enable consistent equation numbering
  (setq org-latex-preview-numbered t
        org-startup-with-latex-preview t
        org-latex-preview-live t
        org-latex-preview-preamble "\\documentclass{article}
[DEFAULT-PACKAGES]
[PACKAGES]
\\usepackage[dvipsnames,svgnames]{xcolor}
\\usepackage[sfdefault]{AlegreyaSans}
\\usepackage{graphicx}
\\usepackage{newtxsf}
\\definecolor{DarkRed}{RGB}{204,36,29}
\\definecolor{ForestGreen}{RGB}{184,187,38}
\\definecolor{red}{RGB}{251,73,52}
\\definecolor{orange}{RGB}{254,128,25}
\\definecolor{blue}{RGB}{69,133,136}
\\definecolor{green}{RGB}{184,187,38}
\\definecolor{yellow}{RGB}{250, 189, 47}
\\definecolor{purple}{RGB}{211, 134, 155}"))

(after! org-src
  (add-to-list 'org-src-block-faces '("latex" (:inherit default :extend t))))

(setq org-latex-preview-compiler-command-map
      '(("pdflatex" . "latex")
        ("lualatex" . "latex")))

(use-package! ox-extra
  :config
  (ox-extras-activate '(ignore-headlines)))

(use-package! ox-latex
  :config
  ;; (setq org-latex-pdf-process
  ;;       '("latexmk -pdflatex='%latex -shell-escape -bibtex -interaction=nonstopmode' -pdf -output-directory=%o -f %f"))

  ;; Default packages
  (setq org-export-headline-levels 5
        org-latex-default-packages-alist
        '(("AUTO" "inputenc" t ("pdflatex" "lualatex"))
          ("T1" "fontenc" t ("pdflatex"))
          ;;Microtype
          ;;- pdflatex: full microtype features, fast, however no fontspec
          ;;- lualatex: good microtype feature support, however slow to compile
          ;;- xelatex: only protrusion support, fast compilation
          ("activate={true,nocompatibility},final,tracking=true,kerning=true,spacing=true,factor=1100,stretch=10,shrink=10"
           "microtype" nil ("pdflatex"))
          ("activate={true,nocompatibility},final,tracking=true,factor=1100,stretch=10,shrink=10"
           "microtype" nil ("lualatex"))
          ("protrusion={true,nocompatibility},final,factor=1100,stretch=10,shrink=10"
           "microtype" nil ("xelatex"))
          ("dvipsnames,svgnames" "xcolor" nil)
          ("colorlinks=true, linkcolor=DarkBlue, citecolor=BrickRed, urlcolor=DarkGreen" "hyperref" nil))))

(after! ox
  ;; Add KOMA-scripts classes to org export
  (add-to-list 'org-latex-classes
               '("koma-letter" "\\documentclass[11pt]{scrletter}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

  (add-to-list 'org-latex-classes
               '("koma-article" "\\documentclass[11pt]{scrartcl}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

  (add-to-list 'org-latex-classes
               '("koma-report" "\\documentclass[11pt]{scrreprt}"
                 ("\\part{%s}" . "\\part*{%s}")
                 ("\\chapter{%s}" . "\\chapter*{%s}")
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))

  (add-to-list 'org-latex-classes
               '("koma-book" "\\documentclass[11pt]{scrbook}"
                 ("\\part{%s}" . "\\part*{%s}")
                 ("\\chapter{%s}" . "\\chapter*{%s}")
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))

  ;; Add the custom cheatsheet class
  (add-to-list 'org-latex-classes
               '("hpcheatsheet" "\\documentclass[columns=4,bgcolor=white,fgcolor=black]{hpcheatsheet}"
                 ("\\boxtitle{%s}" . "\\boxtitle{%s}")
                 ("\\sectiontitle{%s}" . "\\sectiontitle{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  )

(setq org-latex-default-class "koma-article")

(after! ox-latex
  (setq org-latex-src-block-backend 'engraved))

(use-package! engrave-faces
  :init
  (setq engrave-faces-themes
        '((default .
           (;; faces.el --- excluding: bold, italic, bold-italic, underline, and some others
            (default                             :short "default"             :slug "D"   :foreground "#000000" :background "#ffffff" :family "Monospace")
            (variable-pitch                      :short "var-pitch"           :slug "vp"  :foreground "#000000"                       :family "Sans Serif")
            (shadow                              :short "shadow"              :slug "h"   :foreground "#7f7f7f")
            (success                             :short "success"             :slug "sc"  :foreground "#228b22" :weight bold)
            (warning                             :short "warning"             :slug "w"   :foreground "#ff8e00" :weight bold)
            (error                               :short "error"               :slug "e"   :foreground "#ff0000" :weight bold)
            (link                                :short "link"                :slug "l"   :foreground "#ff0000")
            (link-visited                        :short "link"                :slug "lv"  :foreground "#ff0000")
            (highlight                           :short "link"                :slug "hi"  :foreground "#ff0000")
            ;; font-lock.el
            (font-lock-comment-face              :short "fl-comment"          :slug "c"   :foreground "#b22222")
            (font-lock-comment-delimiter-face    :short "fl-comment-delim"    :slug "cd"  :foreground "#b22222")
            (font-lock-string-face               :short "fl-string"           :slug "s"   :foreground "#8b2252")
            (font-lock-doc-face                  :short "fl-doc"              :slug "d"   :foreground "#8b2252")
            (font-lock-doc-markup-face           :short "fl-doc-markup"       :slug "m"   :foreground "#008b8b")
            (font-lock-keyword-face              :short "fl-keyword"          :slug "k"   :foreground "#9370db")
            (font-lock-builtin-face              :short "fl-builtin"          :slug "b"   :foreground "#483d8b")
            (font-lock-function-name-face        :short "fl-function"         :slug "f"   :foreground "#0000ff")
            (font-lock-variable-name-face        :short "fl-variable"         :slug "v"   :foreground "#a0522d")
            (font-lock-type-face                 :short "fl-type"             :slug "t"   :foreground "#228b22")
            (font-lock-constant-face             :short "fl-constant"         :slug "o"   :foreground "#008b8b")
            (font-lock-warning-face              :short "fl-warning"          :slug "wr"  :foreground "#ff0000" :weight bold)
            (font-lock-negation-char-face        :short "fl-neg-char"         :slug "nc")
            (font-lock-preprocessor-face         :short "fl-preprocessor"     :slug "pp"  :foreground "#483d8b")
            (font-lock-regexp-grouping-construct :short "fl-regexp"           :slug "rc"                        :weight bold)
            (font-lock-regexp-grouping-backslash :short "fl-regexp-backslash" :slug "rb"                        :weight bold)
            ;; org-faces.el
            (org-block                           :short "org-block"           :slug "ob") ; forcing no background is preferable
            (org-block-begin-line                :short "org-block-begin"     :slug "obb") ; forcing no background is preferable
            (org-block-end-line                  :short "org-block-end"       :slug "obe") ; forcing no background is preferable
            ;; outlines
            (outline-1                           :short "outline-1"           :slug "Oa"  :foreground "#0000ff")
            (outline-2                           :short "outline-2"           :slug "Ob"  :foreground "#a0522d")
            (outline-3                           :short "outline-3"           :slug "Oc"  :foreground "#a020f0")
            (outline-4                           :short "outline-4"           :slug "Od"  :foreground "#b22222")
            (outline-5                           :short "outline-5"           :slug "Oe"  :foreground "#228b22")
            (outline-6                           :short "outline-6"           :slug "Of"  :foreground "#008b8b")
            (outline-7                           :short "outline-7"           :slug "Og"  :foreground "#483d8b")
            (outline-8                           :short "outline-8"           :slug "Oh"  :foreground "#8b2252")
            ;; highlight-numbers.el
            (highlight-numbers-number            :short "hl-number"           :slug "hn"  :foreground "#008b8b")
            ;; highlight-quoted.el
            (highlight-quoted-quote              :short "hl-qquote"           :slug "hq"  :foreground "#9370db")
            (highlight-quoted-symbol             :short "hl-qsymbol"          :slug "hs"  :foreground "#008b8b")
            ;; rainbow-delimiters.el
            (rainbow-delimiters-depth-1-face     :short "rd-1"                :slug "rda" :foreground "#707183")
            (rainbow-delimiters-depth-2-face     :short "rd-2"                :slug "rdb" :foreground "#7388d6")
            (rainbow-delimiters-depth-3-face     :short "rd-3"                :slug "rdc" :foreground "#909183")
            (rainbow-delimiters-depth-4-face     :short "rd-4"                :slug "rdd" :foreground "#709870")
            (rainbow-delimiters-depth-5-face     :short "rd-5"                :slug "rde" :foreground "#907373")
            (rainbow-delimiters-depth-6-face     :short "rd-6"                :slug "rdf" :foreground "#6276ba")
            (rainbow-delimiters-depth-7-face     :short "rd-7"                :slug "rdg" :foreground "#858580")
            (rainbow-delimiters-depth-8-face     :short "rd-8"                :slug "rdh" :foreground "#80a880")
            (rainbow-delimiters-depth-9-face     :short "rd-9"                :slug "rdi" :foreground "#887070")
            ;; Diffs
            (diff-added       :short "diff-added"       :slug  "diffa"  :foreground "#4F894C")
            (diff-changed     :short "diff-changed"     :slug  "diffc"  :foreground "#842879")
            (diff-context     :short "diff-context"     :slug  "diffco" :foreground "#525866")
            (diff-removed     :short "diff-removed"     :slug  "diffr"  :foreground "#99324B")
            (diff-header      :short "diff-header"      :slug  "diffh"  :foreground "#398EAC")
            (diff-file-header :short "diff-file-header" :slug  "difffh" :foreground "#3B6EA8")
            (diff-hunk-header :short "diff-hunk-header" :slug  "diffhh" :foreground "#842879")
            )))))



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
