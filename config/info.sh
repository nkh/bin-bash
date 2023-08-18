# https://github.com/HiPhish/info.vim

# Create a shell function as a wrapper
viminfo () {
    vim -R -M -c "Info $1 $2" +only
}
# Alias info to our new function
alias info=viminfo
