{ config, pkgs, ... }:

{
  # User Settings
  home.username = "ghriphos";
  home.homeDirectory = "/home/ghriphos";

  home.stateVersion = "26.05";

  home.file.".config/alacritty/alacritty.toml".source =
    ./themes/alacritty.toml;

  home.file.".config/fish/config.fish".source =
    ./themes/config.fish;

  home.packages = with pkgs; [
    vesktop
  ];

  xdg.configFile."noctalia".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/noctalia";
  
  # Git Home Configuration
  programs.git = {
    enable = true;

    settings.user = {
      name = "Ghriphos";
      email = "luismelo.developer@gmail.com";
    };
  };  

  # Keybindings
  dconf = {
    enable = true;

    settings = {
      "org/gnome/desktop/wm/keybindings" = {
        switch-to-workspace-left = [ "<Control><Super>Left" ];
        switch-to-workspace-right = [ "<Control><Super>Right" ];

        move-to-workspace-left = [ "<Control><Super><Shift>Left" ];
        move-to-workspace-right = [ "<Control><Super><Shift>Right" ];

        move-to-monitor-left = [ "<Super><Shift>Left" ];
        move-to-monitor-right = [ "<Super><Shift>Right" ];
      };

      "org/gnome/mutter/keybindings" = {
        toggle-tiled-left = [ "<Super>Left" ];
        toggle-tiled-right = [ "<Super>Right" ];
      };
    };
  };

  # Hyprland 
  wayland.windowManager.hyprland.systemd.enable = false;
 
  xdg.configFile."hypr" = {
    source = ./dotfiles/hypr;
    recursive = true;
  };
}

