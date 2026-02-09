# ~/.bashrc - Rozbudowana konfiguracja

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# ===== PATH Configuration =====
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# ===== Shell Options =====
shopt -s histappend      # Append to history, don't overwrite
shopt -s checkwinsize    # Check window size after each command
shopt -s cdspell         # Autocorrect typos in path names
shopt -s dirspell        # Autocorrect directory names

# ===== History Configuration =====
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoreboth:erasedups
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S  "

# ===== Environment Variables =====
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less

# Better less options
export LESS='-R -F -X -i'

# ===== Modern Tools Integration =====

# Starship prompt (if installed)
if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
fi

# Zoxide - smarter cd (if installed)
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init bash)"
fi

# Atuin - magical shell history (if installed)
if command -v atuin &> /dev/null; then
    eval "$(atuin init bash)"
fi

# FZF - fuzzy finder (if installed)
if command -v fzf &> /dev/null; then
    eval "$(fzf --bash)"
    
    # FZF colors matching terminal theme
    export FZF_DEFAULT_OPTS="
        --color=fg:#c0caf5,bg:#1a1b26,hl:#ff9e64
        --color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64
        --color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff
        --color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"
fi

# ===== Aliases =====

# Modern replacements
if command -v eza &> /dev/null; then
    alias ls='eza --icons'
    alias ll='eza -la --icons --git'
    alias lt='eza --tree --level=2 --icons'
else
    alias ll='ls -lah'
fi

if command -v bat &> /dev/null; then
    alias cat='bat --style=auto'
    alias bcat='/usr/bin/cat'  # Original cat
fi

# Common shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git shortcuts
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias glog='git log --oneline --graph --decorate'

# Lazy shortcuts
if command -v lazygit &> /dev/null; then
    alias lg='lazygit'
fi

# Safety aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# System shortcuts
alias update='sudo dnf update'
alias cleanup='sudo dnf autoremove && sudo dnf clean all'

# ===== Functions =====

# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Quick backup
backup() {
    cp "$1"{,.backup-$(date +%Y%m%d-%H%M%S)}
}

# Extract various archive formats
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# ===== Load additional configs =====
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
