{ config, lib, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/dotfiles";
in
{
  home.username = "v1hz";
  home.homeDirectory = "/home/v1hz";
  home.stateVersion = "26.05";

  xdg.enable = true;
  fonts.fontconfig.enable = true;
  targets.genericLinux.enable = true;

  programs.home-manager.enable = true;
  news.display = "silent";

  home.packages = [
    pkgs.maple-mono.NF-CN-unhinted
    pkgs.kanata
  ];

  xdg.configFile = lib.genAttrs (
    [
      "fish/config.fish"
      "git/config"
      "starship.toml"
      "Code/User/settings.json"
      "ghostty/config.ghostty"
      "kanata/kanata.kbd"
    ]
    ++ map (theme: "ghostty/themes/${theme}") (builtins.attrNames (builtins.readDir ../ghostty/themes))
  ) (file: {
    source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${file}";
  });

  systemd.user.services.kanata = {
    Unit = {
      Description = "Kanata keyboard remapper";
      StartLimitIntervalSec = 60;
      StartLimitBurst = 5;
      X-Restart-Triggers = [ (builtins.hashFile "sha256" ../kanata/kanata.kbd) ];
    };

    Service = {
      ExecStart = ''${lib.getExe pkgs.kanata} --cfg "${dotfiles}/kanata/kanata.kbd" --no-wait'';
      Restart = "on-failure";
      RestartSec = 3;
    };

    Install.WantedBy = [ "default.target" ];
  };
}
