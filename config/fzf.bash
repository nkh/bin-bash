# Setup fzf
# ---------
if [[ ! "$PATH" == */home/nadim/nadim/devel/repositories/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/nadim/nadim/devel/repositories/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/nadim/nadim/devel/repositories/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/nadim/nadim/devel/repositories/fzf/shell/key-bindings.bash"
