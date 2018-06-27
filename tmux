set-option -g default-command "reattach-to-user-namespace -l sh"
# You probably already put this in
set -g prefix C-a

unbind-key C-b
bind-key C-a send-prefix
set -g mouse on
set-option -s escape-time 10

set-window-option -g mode-keys vi
bind-key -T copy-mode-vi 'v' send-keys -X begin-selection
bind-key -T copy-mode-vi 'y' send-keys -X copy-selection-and-cancel
bind-key p paste-buffer

if-shell 'test "$(uname)" = "Darwin"' 'source ~/.tmux-osx.conf' 
