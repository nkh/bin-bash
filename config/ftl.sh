export FTL_CFG="$HOME/.config/ftl"
source $FTL_CFG/etc/bin/cdf

tmux bind C-F run-shell    'tmux new-window -n ftl ftl "#{pane_current_path}"'
tmux bind C-D new-window   -n download "ftl $HOME/downloads"
tmux bind C-S new-window   -c "#{pane_current_path}" 'd="$(tmux_new_window_fzm)" ; ftl "$d"'

tmux bind f   split-window -c "#{pane_current_path}" ftl

