# Copy to system clipboard
function fish_user_key_bindings
    # Copy yanked text to the X11 system clipboard
    bind yy 'commandline -b | string collect | xclip -selection clipboard'
    bind -M visual y fish_clipboard_copy
end
