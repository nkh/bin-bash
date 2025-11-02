# Setup fzf
# ---------
if [[ ! "$PATH" == */home/nadim/nadim/devel/repositories/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/nadim/nadim/devel/repositories/fzf/bin"
fi

eval "$(fzf --bash)"
