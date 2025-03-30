function mkcd -a target
    mkdir -p $target
    cd $target
end

function fish_greeting
    if test -z $GUIX_ENVIRONMENT
        echo (set_color brblack)\~ (set_color normal) \
            bienvenue à \
            (set_color -b brmagenta)(set_color -i black)$hostname(set_color normal) \
            (set_color brblack) \~(set_color normal)
        echo
        echo (set_color -i)c\'est (date), ou (date +%s) après l\'époque
        echo
        echo (set_color brblack)\~(set_color yellow) bonne chasse(set_color normal) \
            (set_color brblack)\~
        echo
    end
end

function line_break
    set_color brblack
    for i in (seq $COLUMNS)
        printf "\Uf05c8"
    end
    printf "\n"
end

function fish_prompt
    set -l last_status $status
    if test $last_status -ne 0
        set -l display_status (string join '' (set_color red) $last_status (set_color normal))
    else
        set -l display_status (string join '' (set_color normal) $last_status)
    end

    set -f guix_environment (string join '' (set_color blue) (print_guix_env))
    if test -z $GUIX_ENVIRONMENT
        set -e guix_environment
    end

    line_break
    string replace -a / (string join '' (set_color brblack) / (set_color magenta)) (string join '' $display_status (pwd) ' ' $guix_environment)
    printf (set_color brblack)
    printf "¿ "
end
