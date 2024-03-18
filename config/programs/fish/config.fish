set -U fish_greeting

clear

dbus-launch true

export FZF_DEFAULT_COMMAND="fd -H -I --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build,.vscode-server,.virtualenvs} --type f"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --color=bg+:,bg:,gutter:-1,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
export EDITOR="nvim"
export DISPLAY=":0"
export WAYLAND_DISPLAY=wayland-0
export PATH="$HOME/.cargo/bin:$PATH"


if test -d "/mnt/c/Windows/System32/"
    export PATH="$PATH:/mnt/c/Windows/System32/"
end


function set_panetitle
    set -gx panetitle "❄️ nix"
    echo -n (printf "\033]1337;SetUserVar=panetitle=%s\007" (echo -n $panetitle | base64))
end
set_panetitle
