set -U fish_greeting
clear
dbus-launch true
# pnpm
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# link windows
if test -d "/mnt/c/Windows/System32/"
    export PATH="$PATH:/mnt/c/Windows/System32/"
end
