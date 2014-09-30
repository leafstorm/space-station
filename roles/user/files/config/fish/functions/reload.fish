function reload --description 'Reload the config.fish file'
    if set -q XDG_CONFIG_HOME
        . $XDG_CONFIG_HOME/fish/config.fish
    else
        . ~/.config/fish/config.fish
    end
end
