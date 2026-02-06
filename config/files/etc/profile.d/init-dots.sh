# /etc/profile.d/init-dots.sh

if [[ $- == *i* ]] && [ ! -d "$HOME/dotfiles" ]; then
    echo "--- KONFIGURACJA SYSTEMU ---"
    echo "Wykryto świeżą instalację. Czy chcesz teraz pobrać swoje dotfiles?"
    echo "Wpisz: 'just setup-dots', aby zacząć."
    echo "---------------------------"
fi
