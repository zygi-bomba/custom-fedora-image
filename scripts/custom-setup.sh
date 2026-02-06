#!/usr/bin/env bash
set -euo pipefail

echo "Konfigurowanie systemu i użytkownika..."

# 1. Tworzymy użytkownika (jeśli chcesz mieć go od razu w obrazie)
# Hasło jest puste - ustawisz je sobie po pierwszym zalogowaniu przez 'passwd'
if ! id "uzytkownik" &>/dev/null; then
    useradd -m -G wheel -s /usr/bin/bash uzytkownik
    passwd -d uzytkownik
fi

# 2. Poprawiamy uprawnienia dla plików skopiowanych do /etc/skel
chown -R root:root /etc/skel
chmod -R 755 /etc/skel

echo "Setup zakończony pomyślnie!"
