# Use vi keybindings.
bindkey -v


zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
#!/bin/zsh

# Adds `~/.local/bin` to $PATH
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | paste -sd ':')"
# Default programs:
export EDITOR="nvim"
#export TERMINAL="st"
export BROWSER="chrome"

# ~/ Clean-up:
export LESSHISTFILE="-"
export WGETRC="${HOME}/.config/wget/wgetrc"
export INPUTRC="${HOME}/.config/inputrc"
export ZDOTDIR="${HOME}/.config/zsh"
export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
export VAGRANT_DEFAULT_PROVIDER="virtualbox"
export VAGRANT_WSL_WINDOWS_ACCESS_USER_HOME_PATH="/c/vagrant"
MAVEN_OPTS="-Ddependency-check.skip=true -Xshare:on -XX:TieredStopAtLevel=1 -XX:+UseParallelGC -Xverify:none -Dmaven.artifact.threads=25 -Dhttp.tcp.nodelay=false -Dmaven.wagon.provider.http=httpclient -Xmx2048M -Xss256M -XX:+CMSClassUnloadingEnabled -XX:-UseGCOverheadLimit"
# Load plugins
export ZPLUG_HOME=~/.local/share/zsh/zplug
source $ZPLUG_HOME/init.zsh
zplug "woefe/wbase.zsh"
zplug "woefe/git-prompt.zsh", use:"{git-prompt.zsh,examples/wprompt.zsh}"
zplug "zsh-users/zsh-history-substring-search"
zplug "Jxck/dotfiles", as:command, use:"bin/{histuniq,color}"
zplug "plugins/git",   from:oh-my-zsh
zplug "junegunn/fzf", use:"shell/*.zsh"
zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf,
# use:"*linux*amd64*"
# Group dependencies
# Load "emoji-cli" if "jq" is installed in this example
zplug "stedolan/jq", \
    from:gh-r, \
    as:command, \
    rename-to:jq
zplug "b4b4r07/emoji-cli", \
    on:"stedolan/jq"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug "sharkdp/fd", from:gh-r, as:command, rename-to:fd,
# use:"*x86_64-unknown-linux-gnu.tar.gz"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load
# Aliases
alias la='ls -lah --color=auto'
alias lh='ls -lh --color=auto'
alias ls='ls --color=auto'
alias l='ls --color=auto'
alias grep='grep --color=auto'
alias fd=fdfind
#alias -s {yml,yaml}=ansible-playbook
m2c='mvn -T 2C'
mci='mvn clean install'
mcp='mvn clean package'
mi2c='mvn -T 2C clean install'
mit8='mvn -T 8 clean install'
mjdoc='mvn javadoc:javadoc'
mp2c='mvn -T 2C clean package'
mpt8='mvn -T 8 clean package'
mt8='mvn -T 8'
export MOLECULE_DISTRO=debian10
export ANSIBLE_VAULT_PASSWORD_FILE=~/.vault_pass.txt
export GOPATH=~/.local/share/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:~/.cargo/bin
export PATH=$PATH:/usr/share/logstash/bin
export LS_HOME=/usr/share/logstash

# Keybindings for substring search plugin. Maps up and down arrows.
bindkey -M main '^[OA' history-substring-search-up
bindkey -M main '^[OB' history-substring-search-down
bindkey -M main '^[[A' history-substring-search-up
bindkey -M main '^[[B' history-substring-search-up
#
# # Keybindings for autosuggestions plugin
bindkey '^ ' autosuggest-accept
bindkey '^f' autosuggest-accept
#
# # Gray color for autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=247'
#
# # fzf settings. Uses sharkdp/fd for a faster alternative to `find`.
fe() {find . \( ! -regex '.*/\..*' \) -type f | fzf --preview 'bat --style=numbers --color=always {}' | xargs -r $EDITOR}
fp() {find . \( ! -regex '.*/\..*' \) -type f | fzf --preview 'bat --style=numbers --color=always {}' | xargs -r $PAGER}
fcd() {cd `find . \( ! -regex '.*/\..*' \) -type d | fzf`}
ms() {apropos .| fzf --preview 'echo {}| awk "{print $1}"| xargs man' | awk '{print $1}' | xargs man}
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi
FZF_CTRL_T_COMMAND='fdfind --type f --hidden --exclude .git --exclude .cache'
FZF_ALT_C_COMMAND='fdfind --type d --hidden --exclude .git'
#
# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export SAVEHIST=1000000000
export HISTFILE="${HOME}/.local/share/zsh/history"
DIRSTACKSIZE=${DIRSTACKSIZE:-20}
dirstack_file=${dirstack_file:-${HOME}/.zdirs}
# Record history at once and not after shell exit
setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T] "
# Record timestamps in history
setopt EXTENDED_HISTORY
DIRSTACKSIZE=${DIRSTACKSIZE:-20}
dirstack_file=${dirstack_file:-${HOME}/.local/share/zsh/zdirs}
export GPG_TTY=$(tty)

# Use modern completion system
autoload -Uz compinit
compinit -d "{HOME}/.local/share/zsh/zcompdump"

[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)
