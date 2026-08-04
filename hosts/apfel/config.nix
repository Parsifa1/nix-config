{
  pkgs,
  config,
  inputs,
  ...
}:
let
  username = config.username;
in
{
  nixosConfig = {
    fonts.enable = true;
    secret.enable = true;
    nixconf.enable = true;
    userinfo.enable = true;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username} = {
      imports = [
        ./home.nix
        inputs.self.homeModules.default
      ];
    };
  };

  users = {
    users.${username} = {
      uid = 501;
      shell = pkgs.fish;
      name = username;
      home = "/Users/${username}";
    };
    knownUsers = [ username ];
  };

  environment.variables = {
    FONTCONFIG_FILE = "${pkgs.makeFontsConf {
      fontDirectories = [ "/Library/Fonts" ];
    }}";
    DOCKER_CONFIG = "$HOME/.config/docker";
  };

  programs = {
    gnupg.agent.enable = true;
    fish.enable = true;
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      extraEnv = {
        XDG_CONFIG_HOME = "/Users/${username}/.config";
      };
    };
    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [
      "llvm@20"
      "mole"
    ];
    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    casks = [
      "thaw"
      "stats"
      "alt-tab"
      "keycastr"
      "linearmouse"
    ];
  };

  system = {
    startup.chime = false;
    stateVersion = 5;
    primaryUser = "${username}";
    defaults = {
      dock.autohide = true;
      CustomUserPreferences = {
        "org.hammerspoon.Hammerspoon" = {
          MJConfigFile = "~/.config/hammerspoon/init.lua";
        };
      };
    };
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  imports = [ ./service.nix ];
}
