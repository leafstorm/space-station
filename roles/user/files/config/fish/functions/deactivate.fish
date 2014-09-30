function deactivate --description "Exit a virtualenv"
    if not set -q VIRTUAL_ENV
        echo No virtualenv is activated
        exit 1
    end

    if test -q _VE_OLD_PATH
        set -gx PATH $_VE_OLD_PATH
        set -e _VE_OLD_PATH
    end

    if test -q _VE_OLD_PYTHONHOME
        set -gx PYTHONHOME $_VE_OLD_PYTHONHOME
        set -e _VE_OLD_PYTHONHOME
    end

    set -e VIRTUAL_ENV
    set -e __fish_prompt_hostname
end

