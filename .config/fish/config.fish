
if not status is-interactive
    return
end

########################################
# User Session Configurations
########################################
export UID=1000
export XDG_RUNTIME_DIR="/run/user/$UID"
export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"
export XDG_SESSION_TYPE="wayland"

########################################
# PATH Configurations
########################################
export XDG_CONFIG_HOME="$HOME/.config"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"

# Starship custom prompt
starship init fish | source

########################################
# FISH Configurations
########################################
# Direnv + Zoxide
command -v direnv &> /dev/null && direnv hook fish | source
command -v zoxide &> /dev/null && zoxide init fish --cmd cd | source

bind ctrl-c cancel-commandline


########################################
# CUSTOM ALIASES
########################################
# Setup directory navigation aliases
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

abbr l 'ls  --color=auto'
abbr ll 'ls -l  --color=auto'
abbr la 'ls -a  --color=auto'
abbr lla 'ls -la  --color=auto'

abbr .. "cd .."
abbr .2 "cd ../.."
abbr .3 "cd ../../.."
abbr .4 "cd ../../../.."
abbr .5 "cd ../../../../.."
abbr mkdir "mkdir -p"
abbr grep "grep --color=auto"
abbr code "vscodium"

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
# Automatice NodeJS Version Detection
eval "$(fnm env --use-on-cd --version-file-strategy=recursive)"
_fnm_autoload_hook


