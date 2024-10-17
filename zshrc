# Cozy zsh config. Based off Luke's.

# Enable colors and change prompt:
autoload -U colors && colors

# RGB color function
function rgb_color {
  local r=$1
  local g=$2
  local b=$3
  echo "\e[38;2;${r};${g};${b}m"
}

# Get color for updates based on the number of updates
function get_update_color {
  local updates=$1
  if (( updates == 0 )); then
    echo $(rgb_color 76 153 0)  # Green
  elif (( updates < 10 )); then
    echo $(rgb_color 255 255 0)  # Yellow
  elif (( updates < 20 )); then
    echo $(rgb_color 255 165 0)  # Orange
  else
    echo $(rgb_color 255 0 0)  # Red
  fi
}

# Set prompt
PS1="%B%{$(rgb_color 128 128 128)%}[%{$(rgb_color 153 153 0)%}%n%{$(rgb_color 128 128 128)%}@%{$(rgb_color 76 153 0)%}%M %{$(rgb_color 128 128 128)%}%~%{$(rgb_color 122 156 127)%}]%{$reset_color%}$%b "

# History settings
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Keybindings
bindkey '^[[H' beginning-of-line

# Basic auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Load zsh-syntax-highlighting; should be last
#source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#eval "$(zoxide init zsh)"
