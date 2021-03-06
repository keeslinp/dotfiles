source "%val{config}/plugins/plug.kak/rc/plug.kak"

plug "kak-lsp/kak-lsp" do %{
    cargo install --locked --force --path . # `--path .' is needed by recent versions of cargo
} config %{

    nop %sh{ (kak-lsp -s $kak_session -vvv ) > /tmp/kak-lsp.log 2>&1 < /dev/null & }

    set-option global lsp_diagnostic_line_error_sign '!'
    set-option global lsp_diagnostic_line_warning_sign '?'

    define-command lsp-restart -docstring 'restart lsp server' %{ lsp-stop; lsp-start }

    hook global WinSetOption filetype=(c|cpp|rust|javascript|typescript) %{
        map window normal <c-k> ": enter-user-mode lsp<ret>"
        set-option window lsp_hover_anchor false
        lsp-auto-hover-enable
        lsp-enable-window
        lsp-auto-hover-insert-mode-disable
        lsp-stop-on-exit-enable
        set-option window lsp_auto_highlight_references true
        set-option window idle_timeout 1000
        set-face window DiagnosticError default+u
        set-face window DiagnosticWarning default+u
    }

    # hook global WinSetOption filetype=rust %{
    #     set-option window lsp_server_configuration rust.clippy_preference="on"
    # }
    define-command -hidden -override lsp-show-document-symbol -params 2 -docstring "Render symbols" %{
        evaluate-commands -try-client %opt[toolsclient] %{
            show-locations "%arg{2}" 4
        }
    }
    define-command -hidden -override lsp-show-references -params 2 -docstring "Render references" %{
      evaluate-commands -try-client %opt[toolsclient] %{
            show-locations "%arg{2}" "1,4"
        }
    }
    map global user r ':lsp-rename-prompt<ret>' -docstring 'rename prompt'
}

# plug "andreyorst/powerline.kak" config %{
#   # powerline-theme solarized-dark-termcolors
# }


plug "alexherbo2/prelude.kak"
plug "alexherbo2/explore.kak"
plug "alexherbo2/terminal-mode.kak"
plug "alexherbo2/connect.kak" config %{
    require-module connect-fzf
    require-module connect-lf
    require-module connect-nnn
    require-module terminal-mode
}

hook global WinSetOption filetype=(javascript|typescript) %{
  # set window formatcmd 'yarn prettier --stdin --parser typescript'
  # hook buffer BufWritePre .* %{format}

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

define-command -hidden show-locations -params 2 -docstring "Show locations in sk" %{
  terminal-set global tmux tmux-terminal-vertical tmux-focus
  connect-terminal sh -c "echo '%arg{1}' | sk --delimiter ':' --with-nth %arg{2} --preview 'bat --color=always -n {1} -H {2} -r $(expr {2} - 5):' | cut -f 1,2,3 -d: | xargs :send jump-to-location"
}

define-command search-files -params 1 -docstring "Search files in the directory in fzf using ripgrep" %{
}

define-command browse -docstring "Exlore files in lf" %{
  terminal-set global tmux tmux-terminal-horizontal tmux-focus
  connect-terminal sh -c "tmux move-pane -bh -t 0 && OPENER=:edit lf"
}

define-command skim-files -params 1 %{
  terminal-set global tmux tmux-terminal-vertical tmux-focus
  connect-terminal sh -c %sh{
    printf "sk -c 'fd -t f --color always"
    if [ "$1" = true ] ; then
      printf " --no-ignore"
    fi
    printf "' --ansi --preview 'bat --color always {}' | xargs :edit"
  }
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
map global normal <c-p> ': skim-files false<ret>'
map global normal '#' '<a-i>w*<a-n>' -docstring 'search for previous instance of word'
map global user y ':copy-os-buffer<ret>' -docstring 'copy to mac buffer'
map global user p ':paste-os-buffer<ret>' -docstring 'paste from mac buffer'
map global user / ':comment-line<ret>' -docstring 'comment line'

# Line numbers
add-highlighter global/ number-lines

# Theme
# colorscheme nord


# Latex
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

hook global WinSetOption filetype=(rust) %{
  set global tabstop 4
  set global indentwidth 4
}


add-highlighter global/ wrap


#### ZIG STUFF
plug "Vurich/zig-kak"
hook global WinSetOption filetype=(zig) %{
  set window formatcmd 'zig fmt --stdin'
  # hook buffer InsertKey .* %{format}
}

#### Racket
plug "KJ_Duncan/kakoune-racket.kak" domain "bitbucket.org"

#### Kotlin
# plug "KJ_Duncan/kakoune-kotlin.kak" domain "bitbucket.org"
#
