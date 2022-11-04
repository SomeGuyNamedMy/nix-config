{pkgs, lib, config, ...}:

{
  home.sessionVariables = {
      TERMINAL = "foot";
      GTK_CSD = "0";
  };

  programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      autocd = true;
      plugins = [
          {
          name = "zsh-autocomplete";
          src = pkgs.fetchFromGithub {
              owner = "marlonrichert";
              name = "zsh-autocomplete";
              rev = "f07efda31f27446c8940b069d054bb8b0f61e026";
              sha256 = "x7pXSd8XT8EEIbXgdqDVSLpSvaeKdvHa/YFmFFb3oXU=";
          };
          }
      ];
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

  programs.bat = {
      enable = true;
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
