# # If you come from bash you might have to change your $PATH.


export PATH=/home/iani/.local/bin:$PATH

# ZSH_THEME="powerlevel10k/powerlevel10k"
# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(starship init zsh)"
# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

# ---- FZF -----

# Set up fzf key bindings and fuzzy completion

alias cd="z"
# ---- Eza (better ls) -----

alias ls="eza --icons=always"

alias fd=fdfind
alias nvmconf=nvim ~/.config/nvim/
alias lazygit=~/go/bin/lazygit
alias config='/usr/bin/git --git-dir=/home/iani/.dotfiles/ --work-tree=/home/iani'
