{...}: {
  programs.starship = {
    enable = true;
    settings = {
      aws.disabled = true;
      gcloud.disabled = true;
      hostname.disabled = true;
    };
  };
}
