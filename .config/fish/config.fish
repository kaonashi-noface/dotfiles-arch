# Fail Fast Fish Shell
if not status is-interactive
    return
end



########################################
# Setup Mise-En-Place Configurations
########################################
set -gx MISE_SHELL fish
if not set -q __MISE_ORIG_PATH
    set -gx __MISE_ORIG_PATH $PATH
end

function mise
    if test (count $argv) -eq 0
        command mise
        return
    end

    set command $argv[1]
    set -e argv[1]

    if contains -- --help $argv
        command mise "$command" $argv
        return $status
    end

    switch "$command"
    case deactivate shell sh
        # if help is requested, don't eval
        if contains -- -h $argv
            command mise "$command" $argv
        else if contains -- --help $argv
            command mise "$command" $argv
        else
            source (command mise "$command" $argv |psub)
        end
    case '*'
        command mise "$command" $argv
    end
end

function __mise_env_eval --on-event fish_prompt --description 'Update mise environment when changing directories';
    mise hook-env -s fish | source;

    if test "$mise_fish_mode" != "disable_arrow";
        function __mise_cd_hook --on-variable PWD --description 'Update mise environment when changing directories';
            if test "$mise_fish_mode" = "eval_after_arrow";
                set -g __mise_env_again 0;
            else;
                mise hook-env -s fish | source;
            end;
        end;
    end;
end;

function __mise_env_eval_2 --on-event fish_preexec --description 'Update mise environment when changing directories';
    if set -q __mise_env_again;
        set -e __mise_env_again;
        mise hook-env -s fish | source;
        echo;
    end;

    functions --erase __mise_cd_hook;
end;

__mise_env_eval

if functions -q fish_command_not_found; and not functions -q __mise_fish_command_not_found
    functions -e __mise_fish_command_not_found
    functions -c fish_command_not_found __mise_fish_command_not_found
end

function fish_command_not_found
    if string match -qrv -- '^(?:mise$|mise-)' $argv[1] &&
        mise hook-not-found -s fish -- $argv[1]
        mise hook-env -s fish | source
    else if functions -q __mise_fish_command_not_found
        __mise_fish_command_not_found $argv
    else
        __fish_default_command_not_found_handler $argv
    end
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


