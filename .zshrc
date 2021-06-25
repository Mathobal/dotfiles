#
# .zshrc
#
# Modified from geerlingguy/dotfiles
#

# Nicer prompt.
export PS1=$'\n'"%F{green} %*%F %3~ %F{white}"$'\n'"$ "

# Enable plugins.
plugins=(git brew history kubectl history-substring-search)

# PyEnv Configuration
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# Include alias file (if present) containing aliases for ssh, etc.
if [ -f ~/.aliases ]
then
  source ~/.aliases
fi

# Set architecture-specific brew share path.
arch_name="$(uname -m)"
if [ "${arch_name}" = "x86_64" ]; then
    share_path="/usr/local/share"
elif [ "${arch_name}" = "arm64" ]; then
    share_path="/opt/homebrew/share"
else
    echo "Unknown architecture: ${arch_name}"
fi

# Allow history search via up/down keys.
source ${share_path}/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# Completions.
autoload -Uz compinit && compinit
# Case insensitive.
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# Tell homebrew to not autoupdate every single time I run it (just once a week).
export HOMEBREW_AUTO_UPDATE_SECS=604800

# Delete a given line number in the known_hosts file.
knownrm() {
 re='^[0-9]+$'
 if ! [[ $1 =~ $re ]] ; then
   echo "error: line number missing" >&2;
 else
   sed -i '' "$1d" ~/.ssh/known_hosts
 fi
}