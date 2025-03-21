# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab


# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias open='xdg-open'
alias vim='nvim'
alias c='clear'
alias ll='ls -lah'
alias lls='ls -lsah'
alias lzg='lazygit'
alias lzd='lazydocker'
alias startdocker='sudo systemctl start docker'
alias tks='tmux kill-session'
alias tka='tmux kill-session -a'
alias tns='tmux new -s coding'
alias hacker='docker run --rm -it bcbcarl/hollywood'

# Shell integrations
eval "$(fzf --zsh)"

mongo_connect() {
  # Prompt for container name, username, and password
  read "container_name?Enter MongoDB container name: "
  read "username?Enter MongoDB username: "
  read -s "password?Enter MongoDB password: "

  # Run the MongoDB shell with authentication
  docker exec -it $container_name mongosh -u $username -p $password --authenticationDatabase admin
}

fd() {
  local dir
  dir=$(find . -maxdepth 2 -type d -print | fzf) && cd "$dir"
}

ft() {
  local dir
  dir=$(find . -maxdepth 2 -type d -print | fzf) || return
  dir_name=$(basename "$dir")

  tmux has-session -t "$dir_name" 2>/dev/null
  if [ $? -eq 0 ]; then
    tmux attach-session -t "$dir_name"
  else
    tmux new-session -s "$dir_name" -c "$dir"
  fi
}

export PATH="$PATH:$HOME/.local/bin"
export PATH=/usr/local/go/bin:$PATH
export PATH=/home/sahil/bash_scripts:$PATH
