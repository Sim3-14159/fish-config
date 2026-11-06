function fish_greeting
    printf '\e[?7l'
    begin
        set_color blue --bold
        ps aux --sort -%cpu | head -16 | awk '{print $3 "\t" $11}' | tail -16 | sed 's/\/.*\///g'
    end | fastfetch --logo-type file-raw --logo -
    echo ''
    fortune -s
    echo ''
    printf '\e[?7h'
end
