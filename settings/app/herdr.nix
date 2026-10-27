{ ... }: {
  programs.herdr = {
    enable = true;
    settings = {
      onboarding = false;
      theme.custom = {
        accent = "#a7c080";
        panel_bg = "reset";
        sidebar_bg = "reset";
        active_row_bg = "#374145";
        selection_bg = "#414b50";
        surface0 = "reset";
        surface1 = "#414b50";
        surface_dim = "#2e383c";
        overlay0 = "#bcc4b6";
        overlay1 = "#ccd2c5";
        text = "#f2ecdd";
        subtext0 = "#d6dccf";
        mauve = "#d699b6";
        green = "#a7c080";
        yellow = "#dbbc7f";
        red = "#e67e80";
        blue = "#7fbbb3";
        teal = "#83c092";
        peach = "#e69875";
      };
      ui = {
        accent = "#a7c080";
        pane_gaps = false;
        host_cursor = "native";
        pane_scrollbars = false;
        pane_outer_borders = false;
        prompt_new_tab_name = false;
        agent_panel_sort = "priority";
        status_indicators = "symbols";
        /*nixfmt:disable*/
        sidebar.agents.rows = [
          [ "state_icon" { token = "workspace"; bold = true; } "tab" ]
          [ "machine" "agent" ]
        ];
        sidebar.spaces.rows = [
          [ "state_icon" "workspace" ]
          [ { token = "branch"; dim = true; } "git_status" ]
        ];
        /*nixfmt:enable*/
        toast.delivery = "herdr";
        sound.enabled = false;
      };
      keys = {
        prefix = "ctrl+b";
        navigate_workspace_up = "k";
        navigate_workspace_down = "j";
        switch_tab = "prefix+1..9";
        switch_workspace = "prefix+alt+1..9";
      };
      experimental.kitty_graphics = true;
      remote.quic_port_range ="5060-5061";
    };
  };
}
