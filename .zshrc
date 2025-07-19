# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
export PATH="$HOME/.local/bin:$PATH"
export PATH="/eww/target/release:$PATH"


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

# Start ssh-agent if not already running
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
  eval "$(ssh-agent -s)" > ~/.ssh/agent_env
fi

# Load the SSH agent environment
if [ -f ~/.ssh/agent_env ]; then
  source ~/.ssh/agent_env > /dev/null
  export SSH_AUTH_SOCK
fi

# Add key if not already added
ssh-add -l | grep "id_ed25519" > /dev/null || ssh-add ~/.ssh/id_ed25519 2>/dev/null

