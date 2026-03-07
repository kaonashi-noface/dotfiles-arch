
if not status is-interactive
    return
end

##############################
# PATH Configurations
##############################
export UID=1000
export XDG_RUNTIME_DIR="/run/user/$UID"
export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"
export XDG_SESSION_TYPE="wayland"
export XDG_CONFIG_HOME="$HOME/.config"

export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"



# Starship custom prompt
starship init fish | source

# Direnv + Zoxide
command -v direnv &> /dev/null && direnv hook fish | source
command -v zoxide &> /dev/null && zoxide init fish --cmd cd | source

# Better ls
alias ls='eza --icons --group-directories-first -1'

# Abbrs
abbr lg 'lazygit'
abbr gd 'git diff'
abbr ga 'git add .'
abbr gc 'git commit -am'
abbr gl 'git log'
abbr gs 'git status'
abbr gst 'git stash'
abbr gsp 'git stash pop'
abbr gp 'git push'
abbr gpl 'git pull'
abbr gsw 'git switch'
abbr gsm 'git switch main'
abbr gb 'git branch'
abbr gbd 'git branch -d'
abbr gco 'git checkout'
abbr gsh 'git show'

abbr l 'ls'
abbr ll 'ls -l'
abbr la 'ls -a'
abbr lla 'ls -la'

# Custom colours
cat ~/.local/state/caelestia/sequences.txt 2> /dev/null

# For jumping between prompts in foot terminal
function mark_prompt_start --on-event fish_prompt
    echo -en "\e]133;A\e\\"
end



# Setup Yazi Wrapper
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end


########################################
# Runtime Environment Configurations
########################################
# Set your default version
eval "$(fnm env --use-on-cd --version-file-strategy=recursive)"
_fnm_autoload_hook



########################################
# CUSTOM ALIASES
########################################
# Setup directory navigation aliases
alias ..="cd .."
alias .2="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."
alias .5="cd ../../../../.."
alias mkdir="mkdir -p"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias code="code --force-device-scale-factor=1.25"

bind ctrl-c cancel-commandline



