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
}

# Turn Tabs into spaces
hook global InsertChar \t %{ exec -draft -itersel h@ }
set global tabstop 2
set global indentwidth 2

# Line numbers
add-highlighter global/ number-lines

# Solarized
colorscheme solarized-dark-termcolors
