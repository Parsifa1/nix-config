{ pkgs, ... }:
{
  programs.starship = {
    enable = true;
    package = pkgs.starship;
    settings = {
      aws.disabled = true;
      gcloud.disabled = true;
      hostname.disabled = true;
      username.disabled = true;
      custom.fhs = {
        command = "echo 🐧";
        when = ''
          test -n "$FHS"
        '';
      };
    };
  };
}
