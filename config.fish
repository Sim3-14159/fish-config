if not status is-interactive
    exit
end

# ALIASES
# =======
alias bat "batcat --italic-text=always"
alias mdv "mdv --theme dark --watch"
alias ls "eza --icons=always"
alias dwdiff "dwdiff -c"
alias v nvim
alias fd fdfind
alias nano nvim # Whenever I copy a command from online and they use nano 🤮
function rd --description "cd to a recent directory" --wraps cd # `rd` for "recent directory"
    set -l dirs */
    if test -n "$dirs[1]"
        cd (/bin/ls -dt1 $dirs | head -n 1)
    else
        echo "rd: No directories found" >&2
        return 1
    end
end
if test "$TERM" = xterm-kitty
    alias ssh="kitten ssh"
end

# ABBREVIATIONS
# =============
# Super cool abbreviation! `gd:dir` turns to `mkdir -p dir && cd dir`
abbr --add gd_expand --regex '^gd:\S+' --function __expand_gd
function __expand_gd
    set -l dir (string replace -r '^gd:' '' -- "$argv[1]")
    echo "mkdir -p $dir && cd $dir"
end

# `gc:User/Repo` turns into `gh repo clone User/Repo && cd Repo`
abbr --add gc_expand --regex '^gc:\S+' --function __expand_gc
function __expand_gc
    set -l reponame (string replace -r '^gc:' '' -- "$argv[1]")
    set -l foldername (string split / "$reponame" -f 2)
    echo "gh repo clone $reponame && cd $foldername"
end

abbr 4DIRS --set-cursor=! "$(string join \n -- 'for dir in */' 'cd $dir' '!' 'cd ..' 'end')"
abbr 4FILES --set-cursor=! "$(string join \n -- 'for file in *' '!' 'end')"

abbr wttr "curl wttr.in/Billings"
abbr pg "ps aux | grep"
abbr l lsd
abbr nd nextd # also can press alt+rarrow
abbr pd prevd # also can press alt+larrow
abbr s "" # in case I type l\ns then the s disappears
abbr lt "ls --tree"
abbr la "ls -A"
abbr lf "ls -F"
abbr cl clear
abbr py python
abbr pf "ps --forest"
abbr pymol "env -u PYTHONPATH -u PYENV_ROOT PATH=/usr/bin:/bin pymol"
abbr q exit
abbr u "cd .."
abbr uu "cd ../.."
abbr sim-paste "xsel -ob"
abbr sim-copy "xsel -ib"
abbr rm trash
abbr diff delta # delta is better but I'm hardcoded to type diff

# KEYBINDINGS
# ===========
# Git
# ---
bind -M insert \cgc 'commandline "git commit -m \\"\\""; commandline -C 15'
bind -M insert \cgp 'commandline "git push"'
bind -M insert \cga 'commandline "git add ."'
bind -M insert \cgs 'echo ""; git status; echo ""' repaint
bind -M insert \cgd 'git diff' repaint
bind -M insert \cgl "echo ''
 git log --graph --all --decorate --pretty=format:'%C(auto)%h%d %s %C(dim white)(%cr)%Creset'"
bind -M default \cgc 'commandline "git commit -m \\"\\""
 commandline -C 15'
bind -M default \cgp 'commandline "git push"'
bind -M default \cga 'commandline "git add ."'
bind -M default \cgs 'echo ""
 git status
 echo ""' repaint
bind -M default \cgd 'git diff' repaint
bind -M default \cgl "echo ''
 git log --graph --all --decorate --pretty=format:'%C(auto)%h%d %s %C(dim white)(%cr)%Creset'
 echo ''" repaint

bind -M insert alt-k prevd repaint
bind -M insert alt-j nextd repaint
bind -M default alt-k prevd repaint
bind -M default alt-j nextd repaint

# If there is no keybinding for something, insert the char instead
bind '' self-insert
# In "default" mode I can use `l` instead of right arrow, but
# in "insert" mode I use this instead
bind -M insert ctrl-\; accept-autosuggestion

# ENV VARS
# ========
export MANPAGER='nvim +Man!'
export EDITOR=nvim
export PATH="$PATH:$HOME/go/bin:/snap/bin"
export TERMINFO_DIRS="$HOME/.terminfo:/usr/local/share/terminfo:"
export COWPATH="$HOME/.local/share/cowsay/cows:/usr/share/cowsay/cows"

# SHELL WRAPPERS
# ==============
eval "$(zoxide init fish)"

# Yazi
# ----
function y --description "Open yazi file manager and cd to exited directory" --wraps yazi
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    command rm -f -- "$tmp"
end

# Projectdo
# ---------
abbr -a b projectdo_build
abbr -a r projectdo_run
abbr -a t projectdo_test
abbr -a p projectdo_tool
source /home/sim-likes-pi/.local/share/undo/undo.fish
