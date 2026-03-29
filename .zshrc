# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
export PATH="$HOME/.local/bin:$PATH"
export PATH="/eww/target/release:$PATH"
export APT_HOME=/APT/APT_v3.0.9
export PATH=$APT_HOME:$PATH
export YOUTUBE_API_KEY="hahakeygoesbrrrr"
# Set APT_ARCH to either MAC or LINUX or UNIX or WIN
alias tcshAPT='env APT_HOME=$APT_HOME PATH=$PATH APT_ARCH=LINUX tcsh'
export GODEBUG=netdns=go

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
# source /share/powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme


# use FZF
eval "$(fzf --zsh)"
# use the fuck
eval "$(thefuck --alias fuck)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias ls="eza --color=always --long --git --no-permissions --icons=always"
alias speed="speedtest-cli"
alias spot="ncspot"
alias y="yazi"

typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# change cd to Z using zoxide
eval "$(zoxide init zsh)"

# run neofetch on launch
neofetch

eval $(thefuck --alias)
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/nvm/init-nvm.sh

export ANDROID_HOME=~/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# SSH agent setup (clean & safe)
if [ -f ~/.ssh/agent_env ]; then
  source ~/.ssh/agent_env > /dev/null
fi

if ! ps -p "$SSH_AGENT_PID" > /dev/null 2>&1; then
  ssh-agent > ~/.ssh/agent_env
  source ~/.ssh/agent_env > /dev/null
fi

# Add default key if needed
ssh-add -l >/dev/null 2>&1 || ssh-add ~/.ssh/id_ed25519 2>/dev/null

function man() {
  hour=$(date +%H)
  min=$(date +%M)
  if [[ $hour -eq 0 && $min -eq 30 ]]; then
    echo "🎶 Gimme gimme gimme a man after midnight... 🎶"
  fi
  command man "$@"
}
export QT_QPA_PLATFORMTHEME=kvantum

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/home/Deboo/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<
