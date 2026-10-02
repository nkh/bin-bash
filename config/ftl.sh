export FTL_CFG="$HOME/.config/ftl"
source $FTL_CFG/etc/bin/cdf

tmux bind C-f new-window -c "#{pane_current_path}" -n ftl ftl 

tmux bind -Tprefix   f switch-client -Ttable_f

tmux bind -Ttable_f f split-window -c "#{pane_current_path}" ftl
tmux bind -Ttable_f d new-window   -c "#{pane_current_path}" -n ftl ftl -TML -R gg /home/nadim/nadim/downloads/
#\; switch-client -Tprefix
