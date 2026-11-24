{ pkgs, ... }:

{
  home.username = "v1hz";
  home.homeDirectory = "/home/v1hz";
  home.stateVersion = "26.05";

  targets.genericLinux.enable = true;
  xdg.enable = true;
  fonts.fontconfig.enable = true;

  home.packages = [
    pkgs.maple-mono.NF-CN-unhinted
    pkgs.kanata
  ];

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    package = null;
  };

  xdg.configFile = {
    "fish/config.fish".source = ../fish/config.fish;
    "starship.toml".source = ../starship.toml;
    "Code/User/settings.json".source = ../Code/User/settings.json;
    "ghostty/config.ghostty".source = ../ghostty/config.ghostty;
    "ghostty/themes" = {
      source = ../ghostty/themes;
      recursive = true;
    };
    "kanata/kanata.kbd".source = ../kanata/kanata.kbd;
  };
}
