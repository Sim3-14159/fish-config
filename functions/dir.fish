function dir --description 'DOS-style directory listing'
    set -l target .
    if test (count $argv) -gt 0
        set target $argv[1]
    end

    if not test -d "$target"
        echo "File Not Found"
        return 1
    end

    set -l target (string replace -r '/+$' '' -- "$target")
    test -z "$target"; and set target /

    echo " Volume in drive "(/bin/df -P "$target" 2>/dev/null | tail -n 1 | awk '{print $1}')
    echo " Directory of $target"
    echo

    set -l dirs 0
    set -l files 0
    set -l bytes 0

    for entry in "$target"/*
        if not test -e "$entry"; and not test -L "$entry"
            continue
        end

        set -l name (basename "$entry")
        set -l stamp (date -r "$entry" '+%m/%d/%Y  %I:%M %p')

        if test -d "$entry"
            printf "%s    %-14s  %s\n" "$stamp" "<DIR>" "$name"
            set dirs (math $dirs + 1)
        else
            set -l size (/bin/stat -c '%s' -- "$entry" 2>/dev/null)
            set -l formatted (numfmt --grouping "$size")
            printf "%s    %14s  %s\n" "$stamp" "$formatted" "$name"
            set files (math $files + 1)
            set bytes (math "$bytes + $size")
        end
    end

    echo
    printf " %d File(s) %s bytes\n" $files (numfmt --grouping "$bytes")
    printf " %d Dir(s)\n" $dirs
end
