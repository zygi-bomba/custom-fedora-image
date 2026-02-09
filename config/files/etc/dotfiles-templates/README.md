# Szablony konfiguracji dotfiles

Te pliki to przykładowe, bazowe konfiguracje gotowe do skopiowania do repozytorium dotfiles.

## Jak użyć

1. Uruchom `jg init-dots` aby sklonować repozytorium dotfiles
2. Przejdź do `~/dotfiles`
3. Skopiuj wybrane foldery z `/etc/dotfiles-templates/` do `~/dotfiles/`
4. Dostosuj konfiguracje do swoich potrzeb
5. Dodaj i commituj zmiany do swojego repo
6. Uruchom `jg update-dots` aby zaaplikować

## Struktura

```
/etc/dotfiles-templates/
├── bash/              # Rozbudowana konfiguracja bash
│   ├── .bashrc
│   └── .bashrc.d/     # Modułowe pliki konfiguracji
├── starship/          # Prompt configuration
│   └── .config/starship.toml
├── atuin/             # Historia poleceń
│   └── .config/atuin/config.toml
├── git/               # Konfiguracja Git
│   └── .gitconfig
└── nvim/              # Konfiguracja Neovim (po setup-lazyvim)
    └── .config/nvim/lua/config/
```
