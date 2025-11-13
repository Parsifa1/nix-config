{ ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      notARepository = "skip";
      gui.nerdFontsVersion = "3";
      git.pagers = [
        {
          pager = "delta --dark --paging=never";
          colorArg = "always";
        }
      ];
      git.overrideGpg = true;
      customCommands = [
        {
          key = "P";
          loadingText = "pushing";
          context = "remoteBranches";
          description = "Push to remote branch";
          prompts = [
            {
              type = "menu";
              title = "How to push?";
              options = [
                { value = "push"; }
                { value = "push --force-with-lease"; }
                { value = "push --force"; }
              ];
            }
          ];
          command = "git {{index .PromptResponses 0}} {{.SelectedRemote.Name}} {{.SelectedRemoteBranch.Name}}";
        }
        {
          key = "p";
          loadingText = "pulling";
          context = "remoteBranches";
          description = "Pull from remote branch";
          command = "git pull {{.SelectedRemote.Name}} {{.SelectedRemoteBranch.Name}}";
        }
      ];
    };
  };
}
