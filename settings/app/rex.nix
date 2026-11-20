{ ... }:
{
  services.rex = {
    enable = true;
    extraListen = [ "http://192.168.193.156:7297" ];
    allowAnonymous = true;
  };
}
