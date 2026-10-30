function fish_right_prompt
    set -l seconds (math "(round $CMD_DURATION/100) / 10")
    set -l minutes (math "floor($seconds/60) * 60")
    set seconds (math $seconds - $minutes)
    set minutes (math $minutes / 60)
    if test $seconds -ge 2 -o $minutes -gt 0
        echo (set_color black)\#(set_color grey)"󱎫 "
        if test $minutes -gt 0
            echo -n $minutes:
        end
        echo $seconds(set_color normal)
    end
end
