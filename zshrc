# PATH stuff
PATH=$PATH:~/.cargo/bin
PATH=$PATH:~/.arc_install/arcanist/bin
PATH=$PATH:~/.pub-cache/bin
PATH=$PATH:/opt/dart-sdk-dev/bin
PATH=$PATH:~/scripts
PATH=$PATH:~/packages/flutter/bin
PATH=/usr/local/bin:$PATH
PATH="/usr/local/opt/curl/bin:$PATH"
PATH="/usr/local/opt/curl/lib:$PATH"

export XDG_CONFIG_HOME=~/.config

export EDITOR="nvim"
export VISUAL="nvim"

alias tm="tmux new-session -A -s main"
alias k="kakoune_daemon_script.sh"

export REACT_EDITOR=nvim
export REACT_EDITOR_CMD=/usr/local/bin/nvim

export PATH="$HOME/.yarn/bin:/Users/pearcekeesling/Library/Python/3.8/bin/:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# NODE VERSION
eval "$(fnm env)"

# <Android stuff>
export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_NDK_HOME=/Users/pearcekeesling/Library/Android/sdk/ndk/21.3.6528147
PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools
# </Android>

export PATH=~/.rbenv/shims:$PATH

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/pearcekeesling/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  vi-mode
  fzf
)


source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/pearcekeesling/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
    # eval "$__conda_setup"
# else
    # if [ -f "/Users/pearcekeesling/anaconda3/etc/profile.d/conda.sh" ]; then
        # . "/Users/pearcekeesling/anaconda3/etc/profile.d/conda.sh"
    # else
        # export PATH="/Users/pearcekeesling/anaconda3/bin:$PATH"
    # fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

# [ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

export BITBAR_API_TOKEN=dWFhT05hcUE2RXpxbU5jRVRzQ01KMW1rd0JSaWV0MGQ6
# export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# tab multiplexer configuration: https://github.com/austinjones/tab-rs/
source "/Users/pearcekeesling/Library/Application Support/tab/completion/zsh-history.zsh"
# end tab configuration

