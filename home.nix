{ config, pkgs, inputs, ... }:

{
  # User Settings
  home.username = "ghriphos";
  home.homeDirectory = "/home/ghriphos";

  home.stateVersion = "26.05";

  # Alacritty
  programs.alacritty = {
    enable = true;

    settings = {
      general.import = [
        "~/.config/alacritty/themes/noctalia.toml"
      ];

      window = {
	opacity = 0.88;
	blur = true;
      };

      window.padding = {
	x = 10;
	y = 10;
      };
    };
  };

  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "opacity 0.88, match:class ^(code)$"
      "opacity 0.88, match:class ^(beekeeper-studio)$"
    ];
  };

  home.file.".config/fish/config.fish".source =
    ./themes/config.fish;

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;

    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;

    hyprcursor.enable = true;
  };

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
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    configType = "hyprlang";
    settings = {
      source = "/etc/nixos/dotfiles/hypr/hyprland.conf";
    };
  };
 
  # rclone
  systemd.user.services.rclone-gdrive = {
    Unit = {
      Description = "Google Drive via rclone";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };

    Service = {
      Type = "notify";

      ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount gdrive: %h/GoogleDrive \
          --config=%h/.config/rclone/rclone.conf \
          --vfs-cache-mode=full \
          --dir-cache-time=24h \
          --poll-interval=1m \
          --umask=022
      '';

      ExecStop = ''
        ${pkgs.fuse3}/bin/fusermount3 -u %h/GoogleDrive
      '';

      Restart = "on-failure";
      RestartSec = "5s";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  # nvim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.noctalia = {
    enable = true;

    settings = {
      wallpaper = {
	directory = "/home/ghriphos/wallpapers";
	shell.offline_mode = false;

	default = {
	  path = "";
	};

	automation = {
	  enabled = false;
	  recursive = true;
	};
      };

      plugins = {
	enabled = [
	  "noctalia/wallhaven"
	];

	auto_updated = "official";
      };

      bar.main.end = [
        "media"
      	"tray"
      	"notifications"
      	"clipboard"
      	"network"
      	"bluetooth"
      	"volume"
      	"brightness"
      	"battery"

      	# Botão do Wallhaven
      	"wallhaven"

      	"control-center"
      	"session"
      ];

      widget.wallhaven = {
	type = "noctalia/wallhaven:wallhaven";
      	glyph = "photo";
      	color = "secondary";
      };

      theme = {
        mode = "dark";
	shell_mode = "follow";

        source = "wallpaper";
        wallpaper_scheme = "m3-content";

        templates = {
          enable_builtin_templates = true;

          builtin_ids = [
            "alacritty"
            "starship"
	    "fish"
          ];
        };
      };
    };
  };

  # monitors
  home.packages = let
    updateMonitors = pkgs.writeShellScriptBin "update-monitors" ''
    #!/usr/bin/env bash

    LID_STATE_FILE="/proc/acpi/button/lid/LID/state"

    HDMI_CONNECTED=false
    MONITOR_DESCRIPTION=""

    if hyprctl monitors all | grep -q "^Monitor HDMI-A-1"; then
      HDMI_CONNECTED=true

      MONITOR_DESCRIPTION="$(
        hyprctl monitors all \
          | awk '
            /^Monitor HDMI-A-1/ {found=1}
            found && /description:/ {
              sub(/^[ \t]*description:[ \t]*/, "")
              print
              exit
            }
          '
      )"
    fi

    LID_CLOSED=false

    if [ -f "$LID_STATE_FILE" ]; then
      if grep -qi "closed" "$LID_STATE_FILE"; then
        LID_CLOSED=true
      fi
    fi

    if $HDMI_CONNECTED; then

      case "$MONITOR_DESCRIPTION" in

        "Beihai Century Joint Innovation Technology Co.Ltd SFVC-3415")
          EXTERNAL_MODE="3440x1440@100"
          EXTERNAL_WIDTH=3440
          ;;

        *)
          # Monitor antigo / fallback
          EXTERNAL_MODE="2560x1080@199"
          EXTERNAL_WIDTH=2560
          ;;

      esac

      hyprctl keyword monitor \
        "HDMI-A-1,$EXTERNAL_MODE,0x0,1.0"

      if $LID_CLOSED; then

        hyprctl keyword monitor \
          "eDP-1,disable"

      else

        hyprctl keyword monitor \
          "eDP-1,1920x1080@144.00101,''${EXTERNAL_WIDTH}x0,1.0"

      fi

    else

      hyprctl keyword monitor \
        "eDP-1,1920x1080@144.00101,0x0,1.0"

    fi
    '';
  in
  with pkgs; [
    vesktop
    bibata-cursors
    osu-lazer
    vlc

    updateMonitors

    opencode
    flyctl

    bun
  ];
}

