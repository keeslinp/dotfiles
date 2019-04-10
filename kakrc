source "%val{config}/plugins/plug.kak/rc/plug.kak"

plug "andreyorst/fzf.kak" config %{
    map global normal <c-p> ': enter-user-mode fzf<ret>'
}

plug "ul/kak-lsp" do %{
    cargo build --release --locked
    cargo install --force --path .
} config %{
    set-option global lsp_completion_trigger "execute-keys 'h<a-h><a-k>\S[^\h\n,=;*(){}\[\]]\z<ret>'"
    set-option global lsp_diagnostic_line_error_sign "!"
    set-option global lsp_diagnostic_line_warning_sign "?"
    lsp-stop-on-exit-enable
    hook global WinSetOption filetype=(c|cpp|rust|javascript) %{
        map window normal <c-l> ": enter-user-mode lsp<ret>"
        lsp-enable-window
        lsp-auto-hover-enable
        lsp-auto-hover-insert-mode-disable
        set-option window idle_timeout 500
        set-face window DiagnosticError default+u
        set-face window DiagnosticWarning default+u
    }

    hook global WinSetOption filetype=rust %{
        set-option window lsp_server_configuration rust.clippy_preference="on"
    }
    hook global KakEnd .* lsp-exit
    define-command -hidden lsp-jump-to-location -params 1 -docstring "Jump to location after fzf" %{
      echo -debug "running"
      echo -debug "%arg{1}"
      evaluate-commands %sh{
        file_name=$(echo "$1" | cut -f 1 -d:)
        line_num=$(echo "$1" | cut -f 2 -d:)
        col_num=$(expr $(echo "$1" | cut -f 3 -d:) - 1)
        printf "edit %s\n" $file_name
        printf "execute-keys %sggh%sl\n" $line_num $col_num
      }
    }
    define-command -hidden lsp-show-locations -params 1 -docstring "Show locations in fzf" %{
        # cut prevents bad text in a reference list from busting things \
        fzf -items-cmd "echo '%arg{1}'" \
        -kak-cmd %{lsp-jump-to-location}\
        -filter 'cut -f 1,2,3 -d:' \
        -preview -preview-cmd "--preview 'cat $(echo {} | cut -f 1 -d:) | nl | tail -n +$(echo {} | cut -f 2 -d:)'"
    }
    define-command -hidden -override lsp-show-document-symbol -params 2 -docstring "Render symbols" %{
        evaluate-commands -try-client %opt[toolsclient] %{
            echo "%arg{1}"
            lsp-show-locations "%arg{2}"
        }
    }
    define-command -hidden -override lsp-show-references -params 2 -docstring "Render references" %{
      evaluate-commands -try-client %opt[toolsclient] %{
            lsp-show-locations "%arg{2}"
        }
    }
    map global user r ':lsp-rename-prompt<ret>' -docstring 'rename prompt'
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

define-command search-files -params 1 -docstring "Search files in the directory in fzf using ripgrep" %{
  fzf -items-cmd "rg --line-buffered --vimgrep '%arg{1}' *" \
    -kak-cmd %{lsp-jump-to-location} \
    -filter "cut -f 1,2,3 -d:"
}

# Turn Tabs into spaces
hook global InsertChar \t %{ exec -draft -itersel h@ }
set global tabstop 2
set global indentwidth 2

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
map global normal '#' '<a-i>w*<a-n>' -docstring 'search for previous instance of word'
map global user y ':copy-os-buffer<ret>' -docstring 'copy to mac buffer'
map global user p ':paste-os-buffer<ret>' -docstring 'paste from mac buffer'
map global user / ':comment-line<ret>' -docstring 'comment line'

# Line numbers
add-highlighter global/ number-lines

# Solarized
colorscheme solarized-dark-termcolors
