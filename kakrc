source "%val{config}/plugins/plug.kak/rc/plug.kak"

plug "alexherbo2/connect.kak" config %{
    define-command ranger -params .. -file-completion %(connect ranger %arg(@))
}

plug "ul/kak-lsp" do %{
    cargo build --release --locked
    cargo install --force --path . # `--path .' is needed by recent versions of cargo
} config %{
    set-option global lsp_diagnostic_line_error_sign '!'
    set-option global lsp_diagnostic_line_warning_sign '?'

    define-command lsp-restart -docstring 'restart lsp server' %{ lsp-stop; lsp-start }

    hook global WinSetOption filetype=(c|cpp|rust|javascript|typescript) %{
        map window normal <c-k> ": enter-user-mode lsp<ret>"
        set-option window lsp_hover_anchor false
        lsp-auto-hover-enable
        lsp-enable-window
        lsp-auto-hover-insert-mode-disable
        set-option window idle_timeout 1000
        set-face window DiagnosticError default+u
        set-face window DiagnosticWarning default+u
    }

    hook global WinSetOption filetype=rust %{
        set-option window lsp_server_configuration rust.clippy_preference="on"
    }
    define-command -hidden -override lsp-show-document-symbol -params 2 -docstring "Render symbols" %{
        evaluate-commands -try-client %opt[toolsclient] %{
            show-locations "%arg{2}"
        }
    }
    define-command -hidden -override lsp-show-references -params 2 -docstring "Render references" %{
      evaluate-commands -try-client %opt[toolsclient] %{
            show-locations "%arg{2}"
        }
    }
    map global user r ':lsp-rename-prompt<ret>' -docstring 'rename prompt'
  
    hook global KakEnd .* lsp-exit
}

plug "andreyorst/powerline.kak" config %{
  # powerline-theme solarized-dark-termcolors
}

hook global WinSetOption filetype=javascript %{
  set buffer lintcmd 'npm run lint -- --format=/Users/joltdev/.notion/tools/image/node/10.15.3/6.4.1/lib/node_modules/eslint-formatter-kakoune'
  lint-enable
  lint

  # Fix template highlights
  remove-highlighter "shared/javascript/literal"
  add-highlighter "shared/javascript/literal" region "`" (?<!\\)(\\\\)*` regions
  add-highlighter "shared/javascript/literal/string" default-region fill string
  add-highlighter "shared/javascript/literal/expr" region \$\{ \} ref javascript
}

# General Commands
define-command -hidden jump-to-location -params 1 -docstring "Jump to location after fzf" %{
  evaluate-commands %sh{
    file_name=$(echo "$1" | cut -f 1 -d:)
    line_num=$(echo "$1" | cut -f 2 -d:)
    col_num=$(expr $(echo "$1" | cut -f 3 -d:) - 1)
    printf "edit %s\n" $file_name
    printf "execute-keys %sggh%sl\n" $line_num $col_num
  }
}

define-command -hidden show-locations -params 1 -docstring "Show locations in sk" %{
  echo -debug %arg{1}
  tmux-terminal-vertical sh -c "echo eval -client %val{client} \""jump-to-location $(echo '%arg{1}' | sk | cut -f 1,2,3 -d:)\"" | kak -p %val{session}"
}

define-command search-files -params 1 -docstring "Search files in the directory in fzf using ripgrep" %{
  fzf -items-cmd "rg --line-buffered --vimgrep '%arg{1}' *" \
    -kak-cmd %{jump-to-location} \
    -filter "cut -f 1,2,3 -d:"
}

define-command -hidden skim-files %{
  tmux-terminal-vertical sh -c "echo eval -client %val{client} \""edit $(sk -c 'fd -t f')\"" | kak -p %val{session}"
}

#OS copy buffers
define-command -hidden paste-os-buffer %{
  execute-keys |
  execute-keys %sh{
    if [ -x "$(command -v pbpaste)" ]; then
      printf "pbpaste"
    else
      printf "wl-paste"
    fi
  }
  execute-keys <ret>
}

define-command -hidden copy-os-buffer %{
  execute-keys <a-|>
  execute-keys %sh{
    if [ -x "$(command -v pbcopy)" ]; then
      printf "pbcopy"
    else
      printf "wl-copy"
    fi
  }
  execute-keys <ret>
}

# USER KEYBINDINGS
map global normal <c-p> ': skim-files<ret>'
map global normal '#' '<a-i>w*<a-n>' -docstring 'search for previous instance of word'
map global user y ':copy-os-buffer<ret>' -docstring 'copy to mac buffer'
map global user p ':paste-os-buffer<ret>' -docstring 'paste from mac buffer'
map global user / ':comment-line<ret>' -docstring 'comment line'

# Line numbers
add-highlighter global/ number-lines

# Solarized
colorscheme solarized-dark-termcolors

hook global WinSetOption filetype=latex %{
      set buffer makecmd "pdflatex '%val{buffile}'"
      hook buffer BufWritePost .* %{
        make
        execute-keys "<c-o>"
      }
}

# Turn Tabs into spaces
hook global InsertChar \t %{ exec -draft -itersel h@ }
set global tabstop 2
set global indentwidth 2


add-highlighter global/ wrap
