fish_add_path --path "$HOME/.nix-profile/bin"
fish_add_path --path "$HOME/.local/bin"

if status is-interactive
    set -g fish_greeting ""
    /usr/bin/mise activate fish | source
    /usr/bin/starship init fish | source
    alias ls 'eza -l --icons=always'
    alias ll 'eza -lah --icons=always'
    alias rebuild 'home-manager switch --flake ~/dotfiles/home-manager#v1hz'
end