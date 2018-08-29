set-option -g default-command "reattach-to-user-namespace -l sh"
# You probably already put this in
set -g prefix C-a

unbind-key C-b
bind-key C-a send-prefix
set -g mouse on
set-option -s escape-time 10

bind-key -r w choose-window -F '#{window_index} | #{pane_current_command} | #{host} | #{pane_current_path}'
set -g status-bg black
set-window-option -g window-status-current-format '#[fg=white,bold]** #{window_index} #[fg=green]#{pane_current_command} #[fg=blue]#(echo "#{pane_current_path}" | rev | cut -d'/' -f-3 | rev) #[fg=white]**|'
set-window-option -g window-status-format '#[fg=white,bold]#{window_index} #[fg=green]#{pane_current_command} #[fg=blue]#(echo "#{pane_current_path}" | rev | cut -d'/' -f-3 | rev) #[fg=white]|'

# splits open in same working directory
bind '"' split-window -c "#{pane_current_path}"
bind '%' split-window -h -c "#{pane_current_path}"

bind r source-file ~/.tmux.conf \; display-message " ✱ tmux.conf is reloaded"


# clipboard stuff
set-window-option -g mode-keys vi
bind-key -T copy-mode-vi 'v' send-keys -X begin-selection
bind-key -T copy-mode-vi 'y' send-keys -X copy-selection-and-cancel

if-shell 'test "$(uname)" = "Darwin"' 'source ~/.tmux-osx.conf' 

run "resize-main-pane -p 70 -l main-vertical"
