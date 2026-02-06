# /etc/profile.d/just-global.sh

# Alias 'jg' (jak Just Global) uruchamia systemowy justfile
# --working-directory ~ jest ważne, aby stow i inne komendy 
# domyślnie operowały na Twoim katalogu domowym, a nie na /etc
alias jg='just --justfile /etc/justfile --working-directory ~'
