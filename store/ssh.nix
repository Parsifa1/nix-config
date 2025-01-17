{ ... }:
{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host github.com
          Hostname ssh.github.com
          Port 443
          User git
      Host debian
          Hostname 192.131.142.134
          Port 11451
          User parsifa1
    '';
  };
}
