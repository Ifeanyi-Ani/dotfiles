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

# ╭──────────────────────────────────────────────────────────╮
# │                   Sources                                │
# ╰──────────────────────────────────────────────────────────╯

#  NOTE: zsh-autosuggestions and zsh-syntax-highlighting is install using package manager and
#        /usr/share is where there are located in my machine
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ╭──────────────────────────────────────────────────────────╮
# │                   eval                                   │
# ╰──────────────────────────────────────────────────────────╯
eval "$(starship init zsh)"
# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

# ---- FZF -----

# Set up fzf key bindings and fuzzy completion
# ╭──────────────────────────────────────────────────────────╮
# │                 alias                                    │
# ╰──────────────────────────────────────────────────────────╯
alias cd="z"
# ---- Eza (better ls) -----
alias tmux='tmux -u'
alias ls="eza --icons=always"

alias fd=fdfind
alias nvmconf=nvim ~/.config/nvim/
alias lazygit=~/go/bin/lazygit
alias config='/usr/bin/git --git-dir=/home/iani/.dotfiles/ --work-tree=/home/iani'
