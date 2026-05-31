{ ... }:
{
  home.sessionVariables = rec {
    PI_CODING_AGENT_DIR = "$HOME/${PI_CONFIG_DIR}/agent";
    CLAUDE_CONFIG_DIR = "$HOME/.config/claude";
    CODEX_HOME = "$HOME/.config/codex";
    PI_CONFIG_DIR = ".config/omp";
  };
}
