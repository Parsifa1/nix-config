{...}: {
  programs = {
    gpg.settings = {
      keyid-format = "0xlong";
      with-fingerprint = true;
    };
    gnupg.agent.settings = {
      max-cache-ttl = 604800000;
      default-cache-ttl = 604800000;
      allow-preset-passphrase = true;
      no-allow-external-cache = true;
    };
  };
}
