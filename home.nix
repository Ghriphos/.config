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

}

