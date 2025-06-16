# close fish greeting
set -U fish_greeting

# set homebrew
set --global --export HOMEBREW_PREFIX "/opt/homebrew";
set --global --export HOMEBREW_CELLAR "/opt/homebrew/Cellar";
set --global --export HOMEBREW_REPOSITORY "/opt/homebrew";
if test -n "$MANPATH[1]"; set --global --export MANPATH '' $MANPATH; end;
if not contains "/opt/homebrew/share/info" $INFOPATH; set --global --export INFOPATH "/opt/homebrew/share/info" $INFOPATH; end;


# set ghostty integration
if test "$TERM_PROGRAM" = ghostty
  if test -n "$GHOSTTY_RESOURCES_DIR"
    source $GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish
  end
  if test -n "$GHOSTTY_BIN_DIR" && not contains "$GHOSTTY_BIN_DIR" $PATH
    fish_add_path --append --path "$GHOSTTY_BIN_DIR"
  end
end

