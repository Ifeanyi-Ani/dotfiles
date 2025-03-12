# To customize prompt, run `p10k configure` or edit ~//.p10k.zsh.
[[ ! -f ~//.p10k.zsh ]] || source ~//.p10k.zsh
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~//.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# # If you come from bash you might have to change your $PATH.


export PATH=/home/iani/.local/bin:$PATH

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=100000
HISTSIZE=50000
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

source ~/powerlevel10k/powerlevel10k.zsh-theme
#  NOTE: zsh-autosuggestions and zsh-syntax-highlighting is install using package manager and
#        /usr/share is where there are located in my machine
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ╭──────────────────────────────────────────────────────────╮
# │                   eval                                   │
# ╰──────────────────────────────────────────────────────────╯
# eval "$(starship init zsh)"
# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

# ---- FZF -----

# Set up fzf key bindings and fuzzy completion
# ╭──────────────────────────────────────────────────────────╮
# │                 alias                                    │
# ╰──────────────────────────────────────────────────────────╯
alias cd="z"
# ---- Eza (better ls) -----
alias tmux='tmux -u'   # to start up tmux with unicode
alias ls="eza --icons=always --group-directories-first"
alias ll="eza -la --icons=always --group-directories-first"
alias tree="eza --tree --icons=always"
alias grep="grep --color=auto"
alias fd=fdfind
alias config='/usr/bin/git --git-dir=/home/iani/.dotfiles/ --work-tree=/home/iani' # bare repository for managing dotfiles
alias autotilling='/bin/autotilling.py'
alias nvmconf="nvim ~/.config/nvim/"
alias zshconf="nvim ~/.zshrc"
alias tmuxconf="nvim ~/.tmux.conf"
alias update="sudo nala update &&  sudo nala upgrade -o APT::Get::Fix-Missing=true"

. "$HOME/.cargo/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --preview 'bat --style=numbers --color=always --line-range :500 {}'"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fpath+=${ZDOTDIR:-~}/.zsh_functions
export PATH="$HOME/software/flutter/bin:$PATH"
export PATH="$HOME/software/android-studio/bin:$PATH"
