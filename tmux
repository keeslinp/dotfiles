# You probably already put this in
set -g prefix C-a

unbind-key C-b
bind-key C-a send-prefix
set -g mouse on
set-option -s escape-time 10

set-window-option -g mode-keys vi
bind-key -T copy-mode-vi 'v' send -X begin-selection
bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel
