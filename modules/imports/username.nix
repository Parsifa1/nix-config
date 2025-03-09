{ lib, ... }:
{
  options = {
    username = lib.mkOption { type = lib.types.lines; };
  };
}
