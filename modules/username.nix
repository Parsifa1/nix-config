{ lib, ... }:
{
  options = {
    username = lib.mkOption { type = lib.types.lines; };
  };
  config = {
    username = "parsifa1";
  };
}
