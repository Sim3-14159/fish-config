if status is-interactive
    # Commands to run in interactive sessions can go here
end

# ALIASES
alias bat "batcat --italic-text=always"
alias mdv "mdv --theme dark --watch"
alias ls "eza --icons=always"
alias dwdiff "dwdiff -c"
alias v nvim
alias fd fdfind

function gd --description 'Make a directory and cd into it. ("Go to Dir")'
    mkdir $argv && cd $argv
end

# ABBREVIATIONS
abbr wttr "curl wttr.in/Billings"
#abbr gc "git commit -m \""
#abbr gp "git push"
#abbr ga "git add ."
#abbr gs "git status"
abbr l lsd
abbr s "" # in case I type l\ns then the s disappears
abbr lt "ls --tree"
abbr la "ls -A"
abbr lf "ls -F"
abbr cl clear
abbr pf "ps --forest"
abbr pymol "env -u PYTHONPATH -u PYENV_ROOT PATH=/usr/bin:/bin pymol"
abbr q exit
abbr u "cd .."
abbr uu "cd ../.."
abbr sim-paste "xsel -ob"
abbr sim-copy "xsel -ib"
abbr rm trash

#function _multicd -d 'cd .. multiple times'
#    set -l length (math (string length -- $argv) - 1)
#    echo cd (string repeat -n $length ../)
#end
#abbr --add dotdot --regex '^\.\.+$' --function _multicd

# KEYBINDINGS
## Git
bind -M insert \cgc 'commandline "git commit -m \\"\\""; commandline -C 15'
bind -M insert \cgp 'commandline "git push"'
bind -M insert \cga 'commandline "git add ."'
bind -M insert \cgs 'echo ""; git status; echo ""; commandline -f repaint'
bind -M insert \cgd 'git diff; commandline -f repaint'
bind -M insert \cgl "echo ''; git log --graph --all --decorate --pretty=format:'%C(auto)%h%d %s %C(dim white)(%cr)%Creset'; echo ''; commandline -f repaint"

# ENV VARS
export MANPAGER='nvim +Man!'
export EDITOR=nvim
export PATH="$PATH:$HOME/go/bin:/snap/bin"
export TERMINFO_DIRS="$HOME/.terminfo:/usr/local/share/terminfo:"
export COWPATH="$HOME/.local/share/cowsay/cows:/usr/share/cowsay/cows"

# SHELL WRAPPERS
eval "$(zoxide init fish)"

## Yazi
function y --description "Open yazi file manager and cd to exited directory" --wraps yazi
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    command rm -f -- "$tmp"
end

## Projectdo
abbr -a b projectdo_build
abbr -a r projectdo_run
abbr -a t projectdo_test
abbr -a p projectdo_tool
