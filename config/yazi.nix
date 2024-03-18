{ ... }:
{
  enable = true;
  settings.yazi = ''
    [manager]
    sort_by        = "natural"
    sort_sensitive = true
    sort_reverse   = false
    sort_dir_first = true
    linemode       = "none"
    show_hidden    = false
    show_symlink   = true

    [preview]
    tab_size        = 2
    max_width       = 600
    max_height      = 900
    cache_dir       = ""
    image_filter    = "triangle"
    image_quality   = 80
    sixel_fraction  = 15
    ueberzug_scale  = 1
    ueberzug_offset = [ 0, 0, 0, 0 ]
  '';
  settings.theme = ''
    # vim:fileencoding=utf-8:foldmethod=marker
    # : Manager {{{

    [manager]
    cwd = { fg = "#94e2d5" }

    # Hovered
    hovered         = { fg = "#1e1e2e", bg = "#89b4fa" }
    preview_hovered = { underline = false }

    # Find
    find_keyword  = { fg = "#f9e2af", italic = true }
    find_position = { fg = "#f5c2e7", bg = "reset", italic = true }

    # Marker
    marker_selected = { fg = "#a6e3a1", bg = "#a6e3a1" }
    marker_copied   = { fg = "#f9e2af", bg = "#f9e2af" }
    marker_cut      = { fg = "#f38ba8", bg = "#f38ba8" }

    # Tab
    tab_active   = { fg = "#1e1e2e", bg = "#89b4fa" }
    tab_inactive = { fg = "#cdd6f4", bg = "#45475a" }
    tab_width    = 1

    # Border
    border_symbol = " "
    border_style  = { fg = "#7f849c" }

    # Highlighting
    syntect_theme = "~/.config/yazi/Catppuccin-mocha.tmTheme"

    # : }}}


    # : Status {{{

    [status]
    separator_open  = ""
    separator_close = ""
    separator_style = { fg = "#45475a", bg = "#45475a" }

    # Mode
    mode_normal = { fg = "#1e1e2e", bg = "#89b4fa", bold = true }
    mode_select = { fg = "#1e1e2e", bg = "#a6e3a1", bold = true }
    mode_unset  = { fg = "#1e1e2e", bg = "#f2cdcd", bold = true }

    # Progress
    progress_label  = { fg = "#ffffff", bold = true }
    progress_normal = { fg = "#89b4fa", bg = "#45475a" }
    progress_error  = { fg = "#f38ba8", bg = "#45475a" }

    # Permissions
    permissions_t = { fg = "#89b4fa" }
    permissions_r = { fg = "#f9e2af" }
    permissions_w = { fg = "#f38ba8" }
    permissions_x = { fg = "#a6e3a1" }
    permissions_s = { fg = "#7f849c" }

    # : }}}


    # : Input {{{

    [input]
    border   = { fg = "#89b4fa" }
    title    = {}
    value    = {}
    selected = { reversed = true }

    # : }}}


    # : Select {{{

    [select]
    border   = { fg = "#89b4fa" }
    active   = { fg = "#f5c2e7" }
    inactive = {}

    # : }}}


    # : Tasks {{{

    [tasks]
    border  = { fg = "#89b4fa" }
    title   = {}
    hovered = { underline = true }

    # : }}}


    # : Which {{{

    [which]
    mask            = { bg = "#313244" }
    cand            = { fg = "#94e2d5" }
    rest            = { fg = "#9399b2" }
    desc            = { fg = "#f5c2e7" }
    separator       = "  "
    separator_style = { fg = "#585b70" }

    # : }}}


    # : Help {{{

    [help]
    on      = { fg = "#f5c2e7" }
    exec    = { fg = "#94e2d5" }
    desc    = { fg = "#9399b2" }
    hovered = { bg = "#585b70", bold = true }
    footer  = { fg = "#45475a", bg = "#cdd6f4" }

    # : }}}


    # : File-specific styles {{{

    [filetype]

    rules = [
        # Images
        { mime = "image/*", fg = "#94e2d5" },

        # Videos
        { mime = "video/*", fg = "#f9e2af" },
        { mime = "audio/*", fg = "#f9e2af" },

        # Archives
        { mime = "application/zip",             fg = "#f5c2e7" },
        { mime = "application/gzip",            fg = "#f5c2e7" },
        { mime = "application/x-tar",           fg = "#f5c2e7" },
        { mime = "application/x-bzip",          fg = "#f5c2e7" },
        { mime = "application/x-bzip2",         fg = "#f5c2e7" },
        { mime = "application/x-7z-compressed", fg = "#f5c2e7" },
        { mime = "application/x-rar",           fg = "#f5c2e7" },

        # Fallback
        { name = "*", fg = "#cdd6f4" },
        { name = "*/", fg = "#89b4fa" }
    ]

    [icon]
    rules = [
        { name = ".git/", text = "" },
        { name = "Desktop/", text = "" },
        { name = "Documents/", text = "" },
        { name = "Downloads/", text = ""  },
        { name = "Dotfiles/", text = "" },
        { name = "Dropbox/", text = "" },
        { name = "Music/", text = "" },
        { name = "Pictures/", text = "" },
        { name = "Public/", text = "" },
        { name = "Templates/", text = "" },
        { name = "Videos/", text = "" },
        { name = ".bash_aliases", text = "" },
        { name = ".bash_history", text = "" },
        { name = ".bash_logout", text = "" },
        { name = ".bash_profile", text = "" },
        { name = ".bashprofile", text = "" },
        { name = ".bashrc", text = "" },
        { name = ".dmrc", text = "" },
        { name = ".DS_Store", text = "" },
        { name = ".fasd", text = "" },
        { name = ".fehbg", text = "" },
        { name = ".gitattributes", text = "" },
        { name = ".gitconfig", text = "" },
        { name = ".gitignore", text = "" },
        { name = ".gitlab-ci.yml", text = "" },
        { name = ".gvimrc", text = "" },
        { name = ".inputrc", text = "" },
        { name = ".jack-settings", text = "" },
        { name = ".mime.types", text = "" },
        { name = ".ncmpcpp", text = "" },
        { name = ".nvidia-settings-rc", text = "" },
        { name = ".pam_environment", text = "" },
        { name = ".profile", text = "" },
        { name = ".recently-used", text = "" },
        { name = ".selected_editor", text = "" },
        { name = ".vim", text = "" },
        { name = ".viminfo", text = "" },
        { name = ".vimrc", text = "" },
        { name = ".Xauthority", text = "" },
        { name = ".Xdefaults", text = "" },
        { name = ".xinitrc", text = "" },
        { name = ".xinputrc", text = "" },
        { name = ".Xresources", text = "" },
        { name = ".zshrc", text = "" },
        { name = "_gvimrc", text = "" },
        { name = "_vimrc", text = "" },
        { name = "a.out", text = "" },
        { name = "authorized_keys", text = "" },
        { name = "bspwmrc", text = "" },
        { name = "cmakelists.txt", text = "" },
        { name = "config", text = "" },
        { name = "config.ac", text = "" },
        { name = "config.m4", text = "" },
        { name = "config.mk", text = "" },
        { name = "config.ru", text = "" },
        { name = "configure", text = "" },
        { name = "docker-compose.yml", text = "" },
        { name = "dockerfile", text = "" },
        { name = "Dockerfile", text = "" },
        { name = "dropbox", text = "" },
        { name = "exact-match-case-sensitive-1.txt", text = "X1" },
        { name = "exact-match-case-sensitive-2", text = "X2" },
        { name = "favicon.ico", text = "" },
        { name = "gemfile", text = "" },
        { name = "gruntfile.coffee", text = "" },
        { name = "gruntfile.js", text = "" },
        { name = "gruntfile.ls", text = "" },
        { name = "gulpfile.coffee", text = "" },
        { name = "gulpfile.js", text = "" },
        { name = "gulpfile.ls", text = "" },
        { name = "ini", text = "" },
        { name = "known_hosts", text = "" },
        { name = "ledger", text = "" },
        { name = "license", text = "" },
        { name = "LICENSE", text = "" },
        { name = "LICENSE.md", text = "" },
        { name = "LICENSE.txt", text = "" },
        { name = "Makefile", text = "" },
        { name = "makefile", text = "" },
        { name = "Makefile.ac", text = "" },
        { name = "Makefile.in", text = "" },
        { name = "mimeapps.list", text = "" },
        { name = "mix.lock", text = "" },
        { name = "node_modules", text = "" },
        { name = "package-lock.json", text = "" },
        { name = "package.json", text = "" },
        { name = "playlists", text = "" },
        { name = "procfile", text = "" },
        { name = "Rakefile", text = "" },
        { name = "rakefile", text = "" },
        { name = "react.jsx", text = "" },
        { name = "README", text = "" },
        { name = "README.markdown", text = "" },
        { name = "README.md", text = "" },
        { name = "README.rst", text = "" },
        { name = "README.txt", text = "" },
        { name = "sxhkdrc", text = "" },
        { name = "user-dirs.dirs", text = "" },
        { name = "webpack.config.js", text = "" },
        { name = "*.3g2", text = "" },
        { name = "*.3gp", text = "" },
        { name = "*.7z", text = "" },
        { name = "*.8svx", text = "" },
        { name = "*.a", text = "" },
        { name = "*.aa", text = "" },
        { name = "*.aac", text = "" },
        { name = "*.aax", text = "" },
        { name = "*.ai", text = "" },
        { name = "*.aiff", text = "" },
        { name = "*.alac", text = "" },
        { name = "*.amr", text = "" },
        { name = "*.amv", text = "" },
        { name = "*.ape", text = "" },
        { name = "*.apk", text = "" },
        { name = "*.asf", text = "" },
        { name = "*.asm", text = "" },
        { name = "*.asp", text = "" },
        { name = "*.au", text = "" },
        { name = "*.aup", text = "" },
        { name = "*.avi", text = "" },
        { name = "*.awb", text = "" },
        { name = "*.awk", text = "" },
        { name = "*.bash", text = "" },
        { name = "*.bat", text = "" },
        { name = "*.bmp", text = "" },
        { name = "*.bz2", text = "" },
        { name = "*.c", text = "" },
        { name = "*.c++", text = "" },
        { name = "*.cab", text = "" },
        { name = "*.cbr", text = "" },
        { name = "*.cbz", text = "" },
        { name = "*.cc", text = "" },
        { name = "*.cda", text = "" },
        { name = "*.class", text = "" },
        { name = "*.clj", text = "" },
        { name = "*.cljc", text = "" },
        { name = "*.cljs", text = "" },
        { name = "*.cmake", text = "" },
        { name = "*.coffee", text = "" },
        { name = "*.conf", text = "" },
        { name = "*.cp", text = "" },
        { name = "*.cpio", text = "" },
        { name = "*.cpp", text = "" },
        { name = "*.cs", text = "" },
        { name = "*.csh", text = "" },
        { name = "*.css", text = "" },
        { name = "*.csv", text = "" },
        { name = "*.cue", text = "" },
        { name = "*.cvs", text = "" },
        { name = "*.cxx", text = "" },
        { name = "*.d", text = "" },
        { name = "*.dart", text = "" },
        { name = "*.db", text = "" },
        { name = "*.deb", text = "" },
        { name = "*.diff", text = "" },
        { name = "*.dll", text = "" },
        { name = "*.doc", text = "" },
        { name = "*.docx", text = "" },
        { name = "*.dss", text = "" },
        { name = "*.dump", text = "" },
        { name = "*.dvf", text = "" },
        { name = "*.edn", text = "" },
        { name = "*.eex", text = "" },
        { name = "*.efi", text = "" },
        { name = "*.ejs", text = "" },
        { name = "*.elf", text = "" },
        { name = "*.elm", text = "" },
        { name = "*.epub", text = "" },
        { name = "*.erl", text = "" },
        { name = "*.ex", text = "" },
        { name = "*.exe", text = "" },
        { name = "*.exs", text = "" },
        { name = "*.f//", text = "" },
        { name = "*.fifo", text = "|" },
        { name = "*.fish", text = "" },
        { name = "*.flac", text = "" },
        { name = "*.flv", text = "" },
        { name = "*.fs", text = "" },
        { name = "*.fsi", text = "" },
        { name = "*.fsscript", text = "" },
        { name = "*.fsx", text = "" },
        { name = "*.gem", text = "" },
        { name = "*.gemspec", text = "" },
        { name = "*.gif", text = "" },
        { name = "*.gifv", text = "" },
        { name = "*.go", text = "" },
        { name = "*.gsm", text = "" },
        { name = "*.gz", text = "" },
        { name = "*.gzip", text = "" },
        { name = "*.h", text = "" },
        { name = "*.haml", text = "" },
        { name = "*.hbs", text = "" },
        { name = "*.hh", text = "" },
        { name = "*.hpp", text = "" },
        { name = "*.hrl", text = "" },
        { name = "*.hs", text = "" },
        { name = "*.htaccess", text = "" },
        { name = "*.htm", text = "" },
        { name = "*.html", text = "" },
        { name = "*.htpasswd", text = "" },
        { name = "*.hxx", text = "" },
        { name = "*.ico", text = "" },
        { name = "*.iklax", text = "" },
        { name = "*.img", text = "" },
        { name = "*.ini", text = "" },
        { name = "*.iso", text = "" },
        { name = "*.ivs", text = "" },
        { name = "*.jar", text = "" },
        { name = "*.java", text = "" },
        { name = "*.jl", text = "" },
        { name = "*.jpeg", text = "" },
        { name = "*.jpg", text = "" },
        { name = "*.js", text = "" },
        { name = "*.json", text = "" },
        { name = "*.jsx", text = "" },
        { name = "*.key", text = "" },
        { name = "*.ksh", text = "" },
        { name = "*.leex", text = "" },
        { name = "*.less", text = "" },
        { name = "*.lha", text = "" },
        { name = "*.lhs", text = "" },
        { name = "*.log", text = "" },
        { name = "*.lua", text = "" },
        { name = "*.lzh", text = "" },
        { name = "*.lzma", text = "" },
        { name = "*.m4a", text = "" },
        { name = "*.m4b", text = "" },
        { name = "*.m4p", text = "" },
        { name = "*.m4v", text = "" },
        { name = "*.markdown", text = "" },
        { name = "*.md", text = "" },
        { name = "*.mdx", text = "" },
        { name = "*.mjs", text = "" },
        { name = "*.mka", text = "" },
        { name = "*.mkv", text = "" },
        { name = "*.ml", text = "λ" },
        { name = "*.mli", text = "λ" },
        { name = "*.mmf", text = "" },
        { name = "*.mng", text = "" },
        { name = "*.mogg", text = "" },
        { name = "*.mov", text = "" },
        { name = "*.movpkg", text = "" },
        { name = "*.mp3", text = "" },
        { name = "*.mp4", text = "" },
        { name = "*.mpc", text = "" },
        { name = "*.mpeg", text = "" },
        { name = "*.mpg", text = "" },
        { name = "*.msi", text = "" },
        { name = "*.msv", text = "" },
        { name = "*.mustache", text = "" },
        { name = "*.mxf", text = "" },
        { name = "*.nix", text = "" },
        { name = "*.nmf", text = "" },
        { name = "*.norg", text = "" },
        { name = "*.o", text = "" },
        { name = "*.oga", text = "" },
        { name = "*.ogg", text = "" },
        { name = "*.opus", text = "" },
        { name = "*.org", text = "" },
        { name = "*.pdf", text = "" },
        { name = "*.php", text = "" },
        { name = "*.pl", text = "" },
        { name = "*.pm", text = "" },
        { name = "*.png", text = "" },
        { name = "*.pp", text = "" },
        { name = "*.ppt", text = "" },
        { name = "*.pptx", text = "" },
        { name = "*.ps1", text = "" },
        { name = "*.psb", text = "" },
        { name = "*.psd", text = "" },
        { name = "*.pub", text = "" },
        { name = "*.py", text = "" },
        { name = "*.pyc", text = "" },
        { name = "*.pyd", text = "" },
        { name = "*.pyo", text = "" },
        { name = "*.r", text = "ﳒ" },
        { name = "*.ra", text = "" },
        { name = "*.rake", text = "" },
        { name = "*.rar", text = "" },
        { name = "*.rb", text = "" },
        { name = "*.rc", text = "" },
        { name = "*.rf64", text = "" },
        { name = "*.rlib", text = "" },
        { name = "*.rm", text = "" },
        { name = "*.rmd", text = "" },
        { name = "*.rmvb", text = "" },
        { name = "*.rom", text = "" },
        { name = "*.rpm", text = "" },
        { name = "*.rproj", text = "鉶" },
        { name = "*.rs", text = "" },
        { name = "*.rss", text = "" },
        { name = "*.rtf", text = "" },
        { name = "*.s", text = "" },
        { name = "*.sass", text = "" },
        { name = "*.scala", text = "" },
        { name = "*.scss", text = "" },
        { name = "*.sh", text = "" },
        { name = "*.slim", text = "" },
        { name = "*.sln", text = "" },
        { name = "*.so", text = "" },
        { name = "*.sql", text = "" },
        { name = "*.styl", text = "" },
        { name = "*.suo", text = "" },
        { name = "*.svi", text = "" },
        { name = "*.swift", text = "" },
        { name = "*.t", text = "" },
        { name = "*.tar", text = "" },
        { name = "*.tex", text = "ﭨ" },
        { name = "*.tgz", text = "" },
        { name = "*.toml", text = "" },
        { name = "*.ts", text = "" },
        { name = "*.tsx", text = "" },
        { name = "*.tta", text = "" },
        { name = "*.twig", text = "" },
        { name = "*.vim", text = "" },
        { name = "*.vimrc", text = "" },
        { name = "*.viv", text = "" },
        { name = "*.vob", text = "" },
        { name = "*.voc", text = "" },
        { name = "*.vox", text = "" },
        { name = "*.vue", text = "﵂" },
        { name = "*.wav", text = "" },
        { name = "*.wasm", text = "" },
        { name = "*.webm", text = "" },
        { name = "*.webmanifest", text = "" },
        { name = "*.webp", text = "" },
        { name = "*.wma", text = "" },
        { name = "*.wmv", text = "" },
        { name = "*.wv", text = "" },
        { name = "*.xbps", text = "" },
        { name = "*.xcplayground", text = "" },
        { name = "*.xhtml", text = "" },
        { name = "*.xls", text = "" },
        { name = "*.xlsx", text = "" },
        { name = "*.xml", text = "" },
        { name = "*.xul", text = "" },
        { name = "*.xz", text = "" },
        { name = "*.yaml", text = "" },
        { name = "*.yml", text = "" },
        { name = "*.yuv", text = "" },
        { name = "*.zip", text = "" },
        { name = "*.zsh", text = "" },

        # default
        { name = "*", text = "" },
        { name = "*/", text = "" },
    ] 
'';
}
