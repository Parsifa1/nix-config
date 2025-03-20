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
  #临时使用软件包
  environment.systemPackages = with pkgs; [
    zig
    nixd
    gcc14
    gnupg
    agenix
  ];

  nixosConfig = {
    userinfo.enable = true;
    nixconf.enable = true;
    fonts.enable = true;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username} = {
      imports = [ inputs.self.homeModules.darwin ];
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

  environment.variables.FONTCONFIG_FILE = "${pkgs.makeFontsConf {
    fontDirectories = [ "/Library/Fonts" ];
  }}";

  programs = {
    gnupg.agent.enable = true;
    fish.enable = true;
  };

  system = {
    startup.chime = false;
    defaults.dock.autohide = true;
    stateVersion = 5;
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  imports = [ ./service.nix ];
}
