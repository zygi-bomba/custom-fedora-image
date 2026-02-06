# /etc/profile.d/init-user.sh

# Uruchom tylko jeśli:
# 1. To jest sesja interaktywna
# 2. Nie ma jeszcze pliku-znacznika
if [[ $- == *i* ]] && [ ! -f "$HOME/.config/.home-initialized" ]; then
    echo "Wykryto pierwsze logowanie. Konfiguruję środowisko..."
    just setup-home
fi
