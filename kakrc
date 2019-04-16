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
}

# Turn Tabs into spaces
hook global InsertChar \t %{ exec -draft -itersel h@ }
set global tabstop 2
set global indentwidth 2

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

add-highlighter global/ wrap
