#=-                                                             -=#

##
# SETUP
##

# GREETING
function fish_greeting
    fastfetch
    mommy # Yes...
    echo ""
end

# UPDATE DONE.FISH
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

# AMD GPU
set --export AMD_VULKAN_ICD RADV
# set --export VK_ICD_FILENAMES "/usr/share/vulkan/icd.d/radeon_icd.x86_64.json" # (Not required, but could be useful if you're using multiple drivers.)

set --export HSA_OVERRIDE_GFX_VERSION "11.0.0"
set --export TORCH_ROCM_AOTRITON_ENABLE_EXPERIMENTAL "1"
set --export GPU_MAX_ALLOC_PERCENT 100
set --export GPU_MAX_HEAP_SIZE 100

set --export MESA_SHADER_CACHE_DISABLE true
set --export MESA_GLSL_CACHE_DISABLE true

#=-                                                             -=#

function fish_prompt -d "Write out the prompt"
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

# Lazy 101
function git_commit_push -d "Do everything in one step, cuz lazy"
  set current_branch "$(git remote show origin | sed -n '/HEAD branch/s/.*: //p')"
  set random_name "$(rand)"

  git add . && git commit -m $random_name && git push origin $current_branch
end

# Early return
if not status is-interactive
    return 0 
end

#=-                                                             -=#

##
# ALIASES
##

alias rmf="rm -rf"
alias open="xdg-open"
alias rand="openssl rand -base64 32"

alias ls 'eza --icons auto'
alias pamcan pacman # Skill issue 101
alias clear "printf '\033[2J\033[3J\033[1;1H'"

alias c="clear"
alias C="clear"
alias l="ls -la"
alias L="ls -la"

alias gc="git checkout"
alias gst="git status"
alias glog="git log --oneline"
alias gadd="git add ."
alias gpush="git push"
alias gpull="git pull"
alias gbr="git branch"
alias gps=git_commit_push

alias dps="docker ps"
alias dc="docker compose"
alias dcu="dc up -d"
alias dcd="dc down"
alias dct="oxker --host unix://$XDG_RUNTIME_DIR/docker.sock"

alias ex="TERM=xterm-kitty yazi"
alias ff="fastfetch"
alias mm="mommy"
alias ze="zellij"
alias gui="gitui"
alias lat="laterem"
alias mixer="wiremix"
alias sp="spotify_player"

alias why="witr"
alias bright="set-brightness.sh"

alias wineenv="cat /proc/\"$(pgrep -fl wineserver | awk '{print $1}')\"/environ | tr '\0' '\n' | grep -i wine"
alias hyprconf="nvim $HOME/.config/hypr"
alias set-wallpaper="mpvpaper -o \"no-audio --panscan=1.0 --loop-playlist\" ALL"

alias ryujinx="$HOME/.local/share/ryujinx/Ryujinx.sh"

#=-                                                             -=#

##
# PATHS
##

# BASE
set PATH $PATH $HOME/.local/bin
set PATH $PATH $HOME/.config/hypr/scripts

# LINKS
# set --export LD_LIBRARY_PATH $LD_LIBRARY_PATH "/usr/local/lib"

# DOCKER
set DOCKER_HOST "unix://$XDG_RUNTIME_DIR/docker.sock"

# RUST UP
set PATH $PATH "$HOME/.cargo/bin"

# NPM PATH
set NPM_PACKAGES "$HOME/.npm-packages"
set PATH $PATH $NPM_PACKAGES/bin

set MANPATH $NPM_PACKAGES/share/man $MANPATH

# GOLANG
set PATH $PATH $HOME/go/bin
set PATH $PATH /usr/local/go/bin

# BUN
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# DOTNET
set --export DOTNET_ROOT "$HOME/.dotnet"

set PATH $PATH "$DOTNET_ROOT"
set PATH $PATH "$DOTNET_ROOT/tools"

# ANDROID

set --export ANDROID_HOME "/opt/android-sdk"
set --export ANDROID_SDK_ROOT "/opt/android-sdk"

set PATH $PATH "$ANDROID_HOME/emulator"
set PATH $PATH "$ANDROID_HOME/platform-tools"
set PATH $PATH "$ANDROID_HOME/cmdline-tools/latest/bin"

#=-                                                             -=#

##
# BINARIES
##

# ZELLIJ
# Zellij sets ZELLIJ=0 on shells inside a session. The snippet below treats
# any value as "already inside" and will not launch again. Drop an inherited
# marker unless zellij is this shell's parent (through nested shells).
begin
    if set -q ZELLIJ
        set -l pid $fish_pid
        set -l in_pane 0
        while test "$pid" -gt 1
            set -l next (string match -r --groups-only 'PPid:\s*(\d+)' </proc/$pid/status)
            if not set -q next[1]
                break
            end
            set pid $next[1]
            set -l comm (string trim </proc/$pid/comm)
            if test "$comm" = zellij
                set in_pane 1
                break
            end
            if not contains -- $comm fish bash zsh sh dash nu sudo su
                break
            end
        end
        if test $in_pane -eq 0
            set -l leaked (set --names | string match -r '^ZELLIJ$|^ZELLIJ_.+')
            if set -q leaked[1]
                set leaked (string match -v -r '^ZELLIJ_AUTO_' -- $leaked)
            end
            if set -q leaked[1]
                set -e $leaked
            end
        end
    end
end
eval (zellij setup --generate-auto-start fish | string collect)

# STARSHIP PLUGIN
starship init fish | source

# ZOXIDE PLUGIN
zoxide init fish --cmd cd | source

# Forgor
if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
end

# opencode
fish_add_path /home/d-kja/.opencode/bin
