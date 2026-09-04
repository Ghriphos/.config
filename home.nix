{ config, pkgs, ... }:

{
  home.username = "ghriphos";
  home.homeDirectory = "/home/ghriphos";

  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    vesktop
  ];

  programs.git = {
    enable = true;

    settings.user = {
      name = "Ghriphos";
      email = "luismelo.developer@gmail.com";
    };
  };  

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
      toggle-tiled-left = [ ];
      toggle-tiled-right = [ ];
    };
  };
};

}

