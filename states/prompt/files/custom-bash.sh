# /etc/profile.d/custom-bash.sh: Custom styled bash configuration with trigraph BLE


# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# Environment variables
export TRIGRAPH="BLE"
export EDITOR="vim"
# User-specific environment variables and PATH
export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH"
export LESS="-R" # Enable color in less


# History settings for better tracking
export HISTSIZE=15000
export HISTFILESIZE=30000
export HISTCONTROL=ignoredups:erasedups
export HISTTIMEFORMAT="%F %T " # Add timestamps to history
shopt -s histappend
shopt -s cmdhist # Save multi-line commands as one


# Enable color support with vibrant scheme
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ls='ls --color=auto'


# Cybersecurity and development aliases
alias nmap='nmap --reason -v'
alias gitstatus='git status --short --branch --show-stash'
alias dockerps='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias vulnscan='nmap -sV --script=vuln --open'
alias checkports='ss -tuln | grep LISTEN' # Quick check for open ports
if command -v dnf &>/dev/null; then
    alias update='sudo dnf update'
elif command -v apt &>/dev/null; then
    alias update='sudo apt update && sudo apt upgrade'
fi
alias gitdiff='git diff --color=always | less -R'


# Function to check if current directory is a Git repository
in_git_repo() {
    git rev-parse --is-inside-work-tree >/dev/null 2>&1
    return $?
}


# Function to get Git branch and status with styled output
get_git_info() {
    if in_git_repo; then
        local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
        local status=$(git status --porcelain 2>/dev/null | wc -l)
        local color="\033[1;32m" # Bold green for clean
        if [ $status -ne 0 ]; then
            color="\033[1;31m" # Bold red for dirty
        fi
        echo -e ": ${color}${branch}\033[0m"
    else
        echo ""
    fi
}


# Custom styled prompt with trigraph, user, pwd, and Git info
#PS1='\[\033[1;35m\]====(\[\033[1;36m\]${TRIGRAPH}\[\033[1;35m\])====\[\033[1;33m\]\u\[\033[0m\]:\[\033[1;34m\]\w\[\033[0m\]$(get_git_info)\[\033[1;37m\]\$\[\033[0m\] '

# Custom styled prompt with blue and orange theme, trigraph, user, pwd, and Git info
#PS1="\[\033[1;34m\]=====( \[\033[1;34m\]\${TRIGRAPH}\[\033[1;34m\] )=====\[\033[1;33m\](\u:\w\$(get_git_info))\[\033[0m\]\n\[\033[1;34m\]>\[\033[0m\] "
PS1="\[\033[1;34m\]=====( \[\033[1;34m\]\${TRIGRAPH}\[\033[1;34m\] )=====\[\033[38;5;208m\](\u@\H:\w\$(get_git_info))\[\033[0m\]\n\[\033[1;34m\]>\[\033[0m\] "
PS2='\[\033[1;90m\]>\[\033[0m\] '
                                                                                                                                                                      
# Enable bash completion for enhanced usability                                                                                                                       
if ! shopt -oq posix; then                                                                                                                                            
    if [ -f /usr/share/bash-completion/bash_completion ]; then                                                                                                        
        . /usr/share/bash-completion/bash_completion                                                                                                                  
    elif [ -f /etc/bash_completion ]; then                                                                                                                            
        . /etc/bash_completion                                                                                                                                        
    fi                                                                                                                                                                
fi                                                                                                                                                                    
                                                                                                                                                                      
                                                                                                                                                                      
# Security tool environment setup                                                                                                                                     
if [ -d "/opt/burp" ]; then                                                                                                                                           
    export PATH="$PATH:/opt/burp"                                                                                                                                     
fi                                                                                                                                                                    
if [ -d "/opt/metasploit-framework/bin" ]; then                                                                                                                       
    export PATH="$PATH:/opt/metasploit-framework/bin"                                                                                                                 
fi                                                                                                                                                                    
                                                                                                                                                                      
                                                                                                                                                                      
# Custom welcome message with system info                                                                                                                             
#echo -e "\033[1;36mWelcome, $TRIGRAPH!\033[0m"                                                                                                                       
#echo -e "\033[1;34mCurrent dir:\033[0m $(pwd)"                                                                                                                       
#echo -e "\033[1;34mSystem:\033[0m $(uname -r) on $(hostname)"                                                                                                        
#echo -e "\033[1;34mUptime:\033[0m $(uptime -p)"
