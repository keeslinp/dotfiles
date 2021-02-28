set -g prefix C-a
unbind-key C-b
bind-key C-a send-prefix
set -g mouse on
set-option -s escape-time 10
set -g base-index 1


bind-key -r w choose-window -F '#{window_index} | #{pane_current_command} | #{host} | #{pane_current_path}'

# splits open in same working directory
bind '"' split-window -c "#{pane_current_path}"
bind '%' split-window -h -c "#{pane_current_path}"

bind r source-file ~/.tmux.conf \; display-message " ✱ tmux.conf is reloaded"

# clipboard stuff
set-window-option -g mode-keys vi
bind-key -T copy-mode-vi 'v' send-keys -X begin-selection
bind-key -T copy-mode-vi 'y' send-keys -X copy-selection-and-cancel

if-shell 'test "$(uname)" = "Darwin"' 'source ~/.tmux-osx.conf' 
if-shell 'test "$(uname)" = "Linux"' 'source ~/.tmux-linux.conf' 

bind C-r run "resize-main-pane -p 70 -l main-vertical"

# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-urlview'
set -g @plugin "arcticicestudio/nord-tmux"


# smart pane switching with awareness of vim splits
bind -n C-h run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-h) || tmux select-pane -L"
# bind -n C-j run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-j) || tmux select-pane -D"
# bind -n C-k run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-k) || tmux select-pane -U"
bind -n C-l run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-l) || tmux select-pane -R"
# bind -n C-\ run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys 'C-\\') || tmux select-pane -l"

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run -b '~/.tmux/plugins/tpm/tpm'
