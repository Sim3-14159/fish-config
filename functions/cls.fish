function cls --description "Clear the screen, as well as the scrollback buffer"
    printf '\033[2J\033[3J\033[1;1H'
end
