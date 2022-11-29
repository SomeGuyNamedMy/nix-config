{ pkgs, lib, config, ... }:

{
  home.sessionVariables = {
    TERMINAL = "wezterm";
    GTK_CSD = "0";
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    autocd = true;
    zplug.plugins = [
      {
        name = "arzzen/calc.plugin.zsh";
      }
    ];
  };

  programs.nushell = {
    enable = true;
  };

  programs.helix = {
    enable = true;
    #settings = {
    #  theme = "nord";
    #};
  };

  programs.bat = {
    enable = true;
  };

  programs.gh = {
    enable = true;
    enableGitCredentialHelper = true;
  };
  programs.git = {
    enable = true;
    userName = "SomeGuyNamedMy";
    userEmail = "mfdear444@gmail.com";
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.lsd = {
    enable = true;
    enableAliases = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$directory"
        #"$git_branch"
        #"$git_state"
        #"$git_state"
        "$cmd_duration"
        "$line_break"
        "$character"
      ];
      directory = {
        style = "blue";
      };
      cmd_duration = {
        format = "[$duration]($style) ";
        style = "yellow";
      };
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
        vicmd_symbol = "[❮](green)";
      };
    };
  };
}
