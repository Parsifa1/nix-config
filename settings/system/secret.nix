{ config, ... }:
{
  age = config.genSecrets {
    github = ".github.key";
  };
}
