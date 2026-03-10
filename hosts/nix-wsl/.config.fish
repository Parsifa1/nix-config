set -U fish_greeting

if not string match -q -- $PNPM_HOME $PATH
   set -ga PATH "$PNPM_HOME"
end

# set neovim mason
set -l MASON "$HOME/.local/share/nvim/mason"
if not string match -q -- $MASON/bin $PATH
 set -ga PATH "$MASON/bin"
end

