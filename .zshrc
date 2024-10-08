# ZSH and Oh-My-Z
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

zstyle ':omz:update' mode auto      
COMPLETION_WAITING_DOTS="true"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# GO ENV
export GOPATH=$HOME/go
export GOROOT=/usr/local/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# FZF
eval "$(fzf --zsh)"

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

source ~/fzf-git.sh/fzf-git.sh
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

# Aliases
alias ls="eza --color=always --long --git --icons=always --no-filesize --no-time --no-user --no-permissions"
alias cd="z"
alias python="python3"
alias pip="pip3"

eval $(thefuck --alias)
eval $(thefuck --alias fk)
eval "$(zoxide init zsh)"

# Bun
[ -s "/Users/malewicz/.bun/_bun" ] && source "/Users/malewicz/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Yandex CLI
if [ -f '/Users/malewicz/yandex-cloud/path.bash.inc' ]; then source '/Users/malewicz/yandex-cloud/path.bash.inc'; fi
if [ -f '/Users/malewicz/yandex-cloud/completion.zsh.inc' ]; then source '/Users/malewicz/yandex-cloud/completion.zsh.inc'; fi

