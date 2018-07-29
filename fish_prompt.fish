function fish_prompt
	set -l __last_command_exit_status $status

    if not set -q -g __fish_robbyrussell_functions_defined
        set -g __fish_robbyrussell_functions_defined
        function _git_branch_name
            set -l branch (git symbolic-ref --quiet HEAD ^/dev/null)
            if set -q branch[1]
                echo (string replace -r '^refs/heads/' '' $branch)
            else
                echo (git rev-parse --short HEAD ^/dev/null)
            end
        end

        function _is_git_repo
            type -q git
            or return 1
            git status -s >/dev/null ^/dev/null
        end

        function _repo_branch_name
            eval "_$argv[1]_branch_name"
        end

        function _repo_type
            if _is_git_repo
                echo 'git'
            end
        end
    end

    set -l cyan (set_color -o cyan)
    set -l yellow (set_color -o yellow)
    set -l red (set_color -o red)
    set -l green (set_color -o green)
    set -l blue (set_color -o blue)
    set -l normal (set_color normal)

    set -l orange (set_color -o f97a02)

    set -l cwd (set_color $fish_color_normal) [(prompt_pwd)]

    set -l repo_type (_repo_type)
    if [ $repo_type ]
        set -l repo_branch $cyan(_repo_branch_name $repo_type)
        set repo_info "$red $repo_type:($repo_branch$red)"

    end

    echo -n -s $cwd $repo_info $normal ' $ '
end
