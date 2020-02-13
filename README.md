# My Personal Developer Environment configuration

This repository is installed by running the following:

```
git clone https://github.com/NonLogicalDev/conf.dotfiles ~/.config/dotter
python3 -m pip install --user nl-dotter
dotter link
```

## Structure:

```
.
├── README.md
├── __deprecated (old unused configurations)
│   ├── dot.conf
│   ├── bin
│   ├── emacs
│   ├── irssi
│   ├── pentadactyl
│   ├── taskwarrior
│   ├── term
│   ├── vimperator
│   └── zprezto
├── common (cross-platform configurations)
│   ├── dot.json
│   ├── bin
│   ├── git
│   ├── tmux
│   ├── vifm
│   ├── vim
│   └── zsh
└── mac (mac os only configs)
    ├── dot.json
    └── hammerspoon
```
