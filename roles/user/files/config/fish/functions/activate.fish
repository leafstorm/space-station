function activate --description "Activates a Python virtualenv"
    # Determine virtualenv location and name
    if test (count -- $argv) -lt 1
        set env $PWD
    else
        set env (realpath $argv[1])
    end

    if test $env = "env"
        set name (basename (dirname $env))
    else
        set name (basename $env)
    end

    # Set up the environment variables
    set -gx VIRTUAL_ENV $env

    set -gx _VE_OLD_PATH $PATH
    set -gx PATH "$VIRTUAL_ENV/bin" $PATH

    if set -q PYTHONHOME
        set -gx _VE_OLD_PYTHONHOME $PYTHONHOME
        set -e PYTHONHOME
    end

    # Set up the prompt
    set __fish_prompt_hostname "$__fish_prompt_hostname "(set_color magenta)"[$name]"(set_color normal)
end

