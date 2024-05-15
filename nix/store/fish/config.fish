clear
set -U fish_greeting
dbus-launch true

if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end

if test -d "/mnt/c/Windows/System32/"
    export PATH="$PATH:/mnt/c/Windows/System32/"
end
