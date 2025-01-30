(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(apheleia-formatters
   '((verible "verible-verilog-format" "--column_limit"
      (number-to-string verilog-ext-formatter-column-limit)
      "--indentation_spaces"
      (number-to-string verilog-ext-formatter-indentation-spaces)
      "--line_break_penalty"
      (number-to-string verilog-ext-formatter-line-break-penalty)
      "--over_column_limit_penalty"
      (number-to-string verilog-ext-formatter-over-column-limit-penalty)
      "--wrap_spaces"
      (number-to-string verilog-ext-formatter-wrap-spaces)
      "--assignment_statement_alignment" "flush-left" "--port_declarations_alignment" "preserve" "-")
     (astyle "astyle"
      (apheleia-formatters-locate-file "--options" ".astylerc"))
     (asmfmt "asmfmt")
     (bean-format "bean-format" input)
     (beautysh "beautysh"
      (apheleia-formatters-indent "--tab" "--indent-size" 'sh-basic-offset)
      "-")
     (black "black"
      (when
          (apheleia-formatters-extension-p "pyi")
        "--pyi")
      (apheleia-formatters-fill-column "--line-length")
      "-")
     (brittany "brittany")
     (buildifier "buildifier")
     (caddyfmt "caddy" "fmt" "-")
     (clang-format "clang-format" "-assume-filename"
      (or
       (apheleia-formatters-local-buffer-file-name)
       (apheleia-formatters-mode-extension)
       ".c"))
     (cljfmt "cljfmt" "fix" "-")
     (cmake-format "cmake-format" "-")
     (crystal-tool-format "crystal" "tool" "format" "-")
     (css-beautify "css-beautify" "--file" "-" "--end-with-newline"
      (apheleia-formatters-indent "--indent-with-tabs" "--indent-size"))
     (dart-format "dart" "format")
     (denofmt "deno" "fmt" "-")
     (denofmt-js "deno" "fmt" "-" "--ext" "js")
     (denofmt-json "deno" "fmt" "-" "--ext" "json")
     (denofmt-jsonc "deno" "fmt" "-" "--ext" "jsonc")
     (denofmt-jsx "deno" "fmt" "-" "--ext" "jsx")
     (denofmt-md "deno" "fmt" "-" "--ext" "md")
     (denofmt-ts "deno" "fmt" "-" "--ext" "ts")
     (denofmt-tsx "deno" "fmt" "-" "--ext" "tsx")
     (dhall-format "dhall" "format")
     (docformatter "apheleia-docformatter" inplace)
     (dprint "dprint" "fmt" "--stdin" filepath)
     (elm-format "elm-format" "--yes" "--stdin")
     (fish-indent "fish_indent")
     (fourmolu "fourmolu")
     (gawk "gawk" "-f" "-" "--pretty-print=-")
     (gleam "gleam" "format" "--stdin")
     (gofmt "gofmt")
     (gofumpt "gofumpt")
     (goimports "goimports")
     (google-java-format "google-java-format" "-")
     (hclfmt "hclfmt")
     (html-beautify "html-beautify" "--file" "-" "--end-with-newline"
      (apheleia-formatters-indent "--indent-with-tabs" "--indent-size"))
     (html-tidy "tidy" "--quiet" "yes" "--tidy-mark" "no" "--vertical-space" "yes" "-indent"
      (when
          (derived-mode-p 'nxml-mode)
        "-xml")
      (apheleia-formatters-indent "--indent-with-tabs" "--indent-spaces")
      (apheleia-formatters-fill-column "-wrap"))
     (isort "isort" "-")
     (js-beautify "js-beautify" "--file" "-" "--end-with-newline"
      (apheleia-formatters-indent "--indent-with-tabs" "--indent-size"))
     (jq "jq" "." "-M"
      (apheleia-formatters-indent "--tab" "--indent"))
     (lisp-indent . apheleia-indent-lisp-buffer)
     (ktlint "ktlint" "--log-level=none" "--stdin" "-F" "-")
     (latexindent "latexindent" "--logfile=/dev/null")
     (mix-format "apheleia-from-project-root" ".formatter.exs" "apheleia-mix-format" filepath)
     (nixfmt "nixfmt")
     (ocamlformat "ocamlformat" "-" "--name" filepath "--enable-outside-detected-project")
     (ocp-indent "ocp-indent")
     (ormolu "ormolu" "--stdin-input-file" filepath)
     (perltidy "perltidy" "--quiet" "--standard-error-output"
      (apheleia-formatters-indent "-t" "-i")
      (apheleia-formatters-fill-column "-l"))
     (pgformatter "pg_format"
      (apheleia-formatters-indent "--tabs" "--spaces" 'tab-width)
      (apheleia-formatters-fill-column "--wrap-limit"))
     (phpcs "apheleia-phpcs")
     (prettier "apheleia-npx" "prettier" "--stdin-filepath" filepath
      (apheleia-formatters-js-indent "--use-tabs" "--tab-width"))
     (prettier-css "apheleia-npx" "prettier" "--stdin-filepath" filepath "--parser=css"
      (apheleia-formatters-js-indent "--use-tabs" "--tab-width"))
     (prettier-html "apheleia-npx" "prettier" "--stdin-filepath" filepath "--parser=html"
      (apheleia-formatters-js-indent "--use-tabs" "--tab-width"))
     (prettier-graphql "apheleia-npx" "prettier" "--stdin-filepath" filepath "--parser=graphql"
      (apheleia-formatters-js-indent "--use-tabs" "--tab-width"))
     (prettier-javascript "apheleia-npx" "prettier" "--stdin-filepath" filepath "--parser=babel-flow"
      (apheleia-formatters-js-indent "--use-tabs" "--tab-width"))
     (prettier-json "apheleia-npx" "prettier" "--stdin-filepath" filepath "--parser=json"
      (apheleia-formatters-js-indent "--use-tabs" "--tab-width"))
     (prettier-markdown "apheleia-npx" "prettier" "--stdin-filepath" filepath "--parser=markdown"
      (apheleia-formatters-js-indent "--use-tabs" "--tab-width"))
     (prettier-ruby "apheleia-npx" "prettier" "--stdin-filepath" filepath "--plugin=@prettier/plugin-ruby" "--parser=ruby"
      (apheleia-formatters-js-indent "--use-tabs" "--tab-width"))
     (prettier-scss "apheleia-npx" "prettier" "--stdin-filepath" filepath "--parser=scss"
      (apheleia-formatters-js-indent "--use-tabs" "--tab-width"))
     (prettier-svelte "apheleia-npx" "prettier" "--stdin-filepath" filepath "--plugin=prettier-plugin-svelte" "--parser=svelte"
      (apheleia-formatters-js-indent "--use-tabs" "--tab-width"))
     (prettier-typescript "apheleia-npx" "prettier" "--stdin-filepath" filepath "--parser=typescript"
      (apheleia-formatters-js-indent "--use-tabs" "--tab-width"))
     (prettier-yaml "apheleia-npx" "prettier" "--stdin-filepath" filepath "--parser=yaml"
      (apheleia-formatters-js-indent "--use-tabs" "--tab-width"))
     (purs-tidy "apheleia-npx" "purs-tidy" "format")
     (pyang "pyang" "--ignore-errors" "-f" "yang")
     (robotidy "robotidy" "--no-color" "-"
      (apheleia-formatters-indent nil "--indent")
      (apheleia-formatters-fill-column "--line-length"))
     (python3-json "python3" "-m" "json.tool"
      (apheleia-formatters-indent "--tab" "--indent"))
     (rubocop "rubocop" "--stdin" filepath "-a" "--stderr" "--format" "quiet" "--fail-level" "fatal")
     (ruby-standard "standardrb" "--stdin" filepath "--fix" "--stderr" "--format" "quiet" "--fail-level" "fatal")
     (ruby-syntax-tree "apheleia-from-project-root" ".streerc" "stree" "format" filepath)
     (ruff "ruff" "format" "--silent"
      (apheleia-formatters-fill-column "--line-length")
      "--stdin-filename" filepath "-")
     (ruff-isort "ruff" "check" "-n" "--select" "I" "--fix" "--fix-only" "--stdin-filename" filepath "-")
     (snakefmt "snakefmt"
      (apheleia-formatters-fill-column "--line-length")
      "-")
     (shfmt "shfmt" "-filename" filepath "-ln"
      (cl-case
          (bound-and-true-p sh-shell)
        (sh "posix")
        (t "bash"))
      (when apheleia-formatters-respect-indent-level
        (list "-i"
              (number-to-string
               (cond
                (indent-tabs-mode 0)
                ((boundp 'sh-basic-offset)
                 sh-basic-offset)
                (t 4)))))
      "-")
     (rufo "rufo" "--filename" filepath "--simple-exit")
     (stylua "stylua" "-")
     (rustfmt "rustfmt" "--quiet" "--emit" "stdout")
     (terraform "terraform" "fmt" "-")
     (treefmt "treefmt" "--stdin" filepath)
     (typstyle "typstyle")
     (vfmt "v" "fmt")
     (xmllint "xmllint" "--format" "-")
     (yapf "yapf")
     (yq-csv "yq" "--prettyPrint" "--no-colors" "--input-format" "csv" "--output-format" "csv")
     (yq-json "yq" "--prettyPrint" "--no-colors" "--input-format" "json" "--output-format" "json"
      (apheleia-formatters-indent nil "--indent"))
     (yq-properties "yq" "--prettyPrint" "--no-colors" "--input-format" "props" "--output-format" "props")
     (yq-tsv "yq" "--prettyPrint" "--no-colors" "--input-format" "tsv" "--output-format" "tsv")
     (yq-xml "yq" "--prettyPrint" "--no-colors" "--input-format" "xml" "--output-format" "xml"
      (apheleia-formatters-indent nil "--indent"))
     (yq-yaml "yq" "--prettyPrint" "--no-colors" "--no-doc" "--input-format" "yaml" "--output-format" "yaml"
      (apheleia-formatters-indent nil "--indent"))
     (zig-fmt "zig" "fmt" "--stdin")))
 '(custom-safe-themes
   '("935cdfc778539529d8124a5500923a660b7e05eb9dba5a762107c7db7a4d56ae" "8d412c0ed46b865312d6df5c1dfd1821d349dd3cba00049cf88c4ad34403597e" "9f986dcc0de26c1c8b6dfd749eb7351b1a3c8db31b3330a7dfdd25be1b47cb22" "4edad12267c88bb57aab5a5c0d2e23740c6f552b6a36fb785dfb4e4725808eab" default))
 '(package-selected-packages '(moe-theme))
 '(warning-suppress-types '((initialization) (defvaralias) (lexical-binding))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
