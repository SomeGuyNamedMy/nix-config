{ pkgs, lib, config, ... }: #my-wallpapers, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "Orchis";
      package = pkgs.orchis;
    };
    gtk3.extraConfig = {
      gtk-decoration-layout = ":menu";
      gtk-button-images = 0;
      gtk-menu-images = 0;
    };
    gtk4.extraConfig = {
      gtk-decoration-layout = ":menu";
      gtk-button-images = 0;
      gtk-menu-images = 0;
    };
  };

  qt.enable = true;
  qt.platformTheme = "gtk";



  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    recommendedEnvironment = true;
    extraConfig = builtins.readFile ./hyprland.conf
      + "bind=SUPER,R,exec,${pkgs.bemenu}/bin/bemenu-run -b\n"
      + "bind=SUPER,P,exec,${pkgs.fuzzel}/bin/fuzzel";
    #+ "exec=${pkgs.wbg}/bin/wbg ${my-wallpapers}/log-horizon.png";
  };

  services.kanshi = {
      enable = true;
      profiles = {
          desktop = {
              outputs = [
                  #{
                      #criteria = "eDP-1";
                  #}
                  #{
                      #criteria = "BOE 0x08FA";
                      #mode = ""
                  #}
              ];
          };
          flex = {
              outputs = [
                  {
                      criteria = "eDP-1";
                  }
                  {
                      criteria = "BOE 0x08FA";
                      mode = "1920x1080@60Hz";
                  }
              ];
          };
      };
  };

  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
    systemd.enable = true;
    #settings = {
    #    mainBar = {
    #        layer = "top";
    #        position = "top";
    #        height = 30;
    #        modules-left = [ "wlr/workspaces" ];
    #        modules-center = [ "hyprland/window" ];
    #        modules-right = ["bluetooth" "pulseaudio" "clock" ];
    #    };
    #    "bluetooth" = {
    #        format = " {status}";
    #    };
    #};
  };

  programs.qutebrowser = {
    enable = true;
  };

  programs.foot = {
    enable = true;
    settings = {
      colors = {
        alpha = 0.9;
      };
    };
  };

  programs.wezterm = {
    enable = true;
    colorSchemes = {
      Cloud = {
        ansi = [
          "#222827"
          "#d5a8e3"
          "#9c75dd"
          "#9898ae"
          "#654a96"
          "#625566"
          "#a9d1df"
          "#e6ebe5"
        ];
        brights = [
          "#5d6f74"
          "#cd749c"
          "#63b0b0"
          "#c0c0dd"
          "#5786bc"
          "#3f3442"
          "#849da2"
          "#d9d6cf"
        ];
        background = "#000000";
        cursor_bg = "#ffffff";
        cursor_border = "#ffffff";
        cursor_fg = "#000000";
        foreground = "#ffffff";
        selection_bg = "#444444";
        selection_fg = "#E9E9E9";
      };
    };
    extraConfig = builtins.readFile ./wezterm.lua;
  };

  services.fnott = {
    enable = true;
  };

  services.gammastep = {
    enable = true;
    dawnTime = "6:00-7:45";
    duskTime = "18:35-20:15";
  };

  programs.mpv = {
    enable = true;
  };

  programs.swww = {
    enable = true;
    systemd.enable = true;
  };
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: with epkgs; [
      direnv
      # text manipulation and navigation
      evil
      origami
      aggressive-indent
      # ui
      vertico
      marginalia
      prescient
      dirvish
      doom-modeline
      all-the-icons
      all-the-icons-dired
      all-the-icons-completion
      dashboard
      minimap
      auto-sudoedit

      markdown-preview-mode

      #programming
      nix-mode
      rust-mode
      haskell-mode
      dhall-mode
      lsp-mode
      lsp-ui
      lsp-origami
      lsp-haskell
      magit

    ];
    extraConfig = builtins.readFile ./init.el;
  };

  xdg.enable = true;
  xdg.desktopEntries = {
    imv = {
      name = "Imv";
      genericName = "Image Viewer";
      exec = "imv %U";
      terminal = false;
      mimeType = [ "image/jpeg" "image/png" ];
    };
  };
  xdg.mime.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = [ "imv.desktop" ];
      "text/plain" = [ "emacs.desktop" ];
    };
  };
}
