#!/bin/sh

# Define User
echo "Enter username:"
read user

# OS
echo "Select OS:"
echo "
  1. Gentoo
  2. Arch
  3. Debian
  4. OpenSuse
  5. Ubuntu
"
read os
case $os in
  1) emerge -q app-shells/zsh ;;
  2) pacman -S zsh --noconfirm ;;
  3) apt install -y zsh ;;
  4) zypper in -y zsh ;;
  5) apt install -y zsh ;;
esac

# Create config
touch /home/$user/.zshrc
chown $user:$user /home/$user/.zshrc

# Define exports
echo "Choose browser"
read brw
echo "Choose editor"
read edtr
echo "export BROWSER='$brw'" >> /home/$user/.zshrc
echo "export EDITOR='$edtr'" >> /home/$user/.zshrc
echo "export VISUAL='$edtr'" >> /home/$user/.zshrc
echo "export TERM='xterm-256color'" >> /home/$user/.zshrc
echo "" >> /home/$user/.zshrc
echo "set -o vi" >> /home/$user/.zshrc

# Define prompt
echo "PROMPT='%(?.%F{green}>>.%F{red}>>)%f %B%F{6}%~%b%F{13}[%B%F{11}%#%F{13}%b]%f '" >> /home/$user/.zshrc

# Install highlighting autosugestions and history
mkdir -p /home/$user/.clones/
chown $user:$user /home/$user/.clones
cd /home/$user/.clones

echo "Installing zsh-history-substring..."
git clone https://github.com/zsh-users/zsh-history-substring-search.git
chown $user:$user zsh-history-substring-search
cd zsh-history-substring-search
mkdir -p /usr/share/zsh/site-functions
cp -v zsh-history-substring-search.zsh /usr/share/zsh/site-functions/
echo "
# SEARCH HISTORY SUBSTRING
source /usr/share/zsh/site-functions/zsh-history-substring-search.zsh
export HISTFILE=~/.zsh_history
export HISTSIZE=100000      
export SAVEHIST=100000
setopt share_history        
setopt extended_history     
setopt hist_ignore_all_dups 
setopt hist_ignore_space    
setopt hist_reduce_blanks  
" >> /home/$user/.zshrc

cd /home/$user/.clones
echo "Installing zsh-autosuggestions..."
git clone https://github.com/zsh-users/zsh-autosuggestions.git
chown $user:$user zsh-autosuggestions
cd zsh-autosuggestions
cp -v zsh-autosuggestions.zsh /usr/share/zsh/site-functions/
echo "
# AUTO-COMPLETION
source /usr/share/zsh/site-functions/zsh-autosuggestions.zsh
setopt notify
setopt correct
setopt auto_cd
setopt auto_list
" >> /home/$user/.zshrc

cd /home/$user/.clones
echo "Installing zsh-syntax-highlighting..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
chown $user:$user zsh-syntax-highlighting
cd zsh-syntax-highlighting
cp -v zsh-syntax-highlighting.zsh /usr/share/zsh/site-functions/
cp -v .version /usr/share/zsh/site-functions/
cp -v .revision-hash /usr/share/zsh/site-functions/
cp -rv highlighters/ /usr/share/zsh/site-functions/
echo "
# SYNTAX HIGHLIGHTING
source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=cyan,underline
ZSH_HIGHLIGHT_STYLES[precommand]=fg=cyan,underline
ZSH_HIGHLIGHT_STYLES[arg0]=fg=cyan
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')
" >> /home/$user/.zshrc

cd /home/$user

# Configure git
echo "
# Git
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' * '
zstyle ':vcs_info:*' stagedstr ' + '
zstyle ':vcs_info:git:*' formats '%F{13}(%F{11}%b%F{1}%u%c%F{13})%F{6}%r%f'
zstyle ':vcs_info:git:*' actionformats '%F{13}(%F{11}%b%F{1}%a%u%c%F{13})%F{6}%r%f'
zstyle ':vcs_info:*' enable git
" >> /home/$user/.zshrc
sed -i 's/=\$/=\\$/g' /home/$user/.zshrc

# Configure aliases
echo "
### Aliases ###

# navigation
alias ..='cd ..'
alias ls='ls --color=auto'
alias la='ls -lah'
# adding flags
alias rm='rm -i'
alias RM='rm -rf'

# Configs
alias ip='ip -c'
alias grep='grep --color=auto'
alias mpd='mpd .mpd/mpd.conf'
alias vim='$edtr'
" >> /home/$user/.zshrc

