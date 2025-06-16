# close fish greeting
set -U fish_greeting

# set homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# set ghostty integration
if test "$TERM_PROGRAM" = ghostty
  if test -n "$GHOSTTY_RESOURCES_DIR"
    source $GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish
  end
  if test -n "$GHOSTTY_BIN_DIR" && not contains "$GHOSTTY_BIN_DIR" $PATH
    fish_add_path --append --path "$GHOSTTY_BIN_DIR"
  end
end

