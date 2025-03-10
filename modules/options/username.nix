{ lib, ... }:
{
  config.username = "parsifa1";
  options = {
    username = lib.mkOption { type = lib.types.lines; };
  };
}
