function fish_greeting
    printf '\e[?7l'
    fastfetch
    printf '\e[?7h'
end
