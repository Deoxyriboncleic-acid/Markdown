# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred e￼复制
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
source /home/wqy/.oh-my-zsh/custom/plugins/zsh-autosuggestions

export MPI_HOME=/usr/local/openmpi
export PATH=${MPI_HOME}/bin:$PATH
export LD_LIBRARY_PATH=${MPI_HOME}/lib:$LD_LIBRARY_PATH
export MANPATH=${MPI_HOME}/share/man:$MANPATH
export OMP_NUM_THREADS=8

alias git-log='git log --pretty=oneline --all --abbrev-commit --graph'
alias git-push='git push --set-upstream'

#alias clion ='./~/.app/clion-2022.3.2/bin/clion.sh'

#set -o vi
export ATHAME_ENABLED=0

alias clion=/home/wqy/.app/clion-2022.3.2/bin/clion.sh
alias idea=/home/wqy/.app/idea-IC-223.8617.56/bin/idea.sh
alias pycharm=/home/wqy/.app/pycharm-community-2022.3.2/bin/pycharm.sh
alias qt=/home/wqy/.app/Qt5.9.9/Tools/QtCreator/bin/qtcreator.sh

alias chatgpt='python3 /home/wqy/Work_Station/Mac_Workstation/CS61A/lab/ChatGPT.py'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/wqy/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/wqy/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/wqy/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/wqy/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
conda config --set auto_activate_base True

alias unsecure_battry="sudo tlp setcharge 0 0 BAT0"
alias secure_battry="sudo tlp setcharge 1 1 BAT0"

alias translator="/home/wqy/.app/translator/translator-rs"
alias clash="/home/wqy/.app/clash-GUI/cfw"

alias vim="/usr/bin/nvim"
alias vim-set="nvim /home/wqy/.config/nvim/init.vim"
alias rmswp="rm $HOME/.config/nvim/tmp/backup"

alias inspur1="ssh inspur1"
alias inspur3="ssh inspur3"
alias inspur2="ssh inspur2"
alias huawei="ssh huawei-cloud"

export CPLUS_INCLUDE_PATH=/usr/include/c++/11

alias Work_Station="cd /home/wqy/Work_Station"




alias rm=trash
alias cattrash='ls ~/.trash'
alias unrm=undelfile
alias cleartrash=cleartrash
undelfile()
{
    mv -i ~/.trash/$@ ./
}
trash()
{
    mv $@ ~/.trash/
}
