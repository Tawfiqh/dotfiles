
alias ll="ls -Gap"
alias lll="ls -loGaprt"

# Start Jupyter notebooks with the i/o limit set high.
alias tjupyter="jupyter notebook --NotebookApp.iopub_data_rate_limit=10000000000"


# launch a macOS system notification.
# takes two arguemts title and message.
# Useful for putting at the end of another command so you get notified when your command has completed.
function notify
  set message $argv[2]

  if test -z $message
    set message "Well."
  end

  set title $argv[1]

  if test -z $title
    set title "DONE!"
  end


  set command "display notification \""(echo $message)"\" with title \""(echo $title)"\""

  osascript -e $command

end

# Keep running the input string.
# bad/dangerous - but also useful sometimes to auto-rerun a script on failure.
# e.g a server or live-reload that exits on error.
function forever
  while sleep 1
   eval $argv
  end
end

# Change directory and list the new directory and working directory.
function cs
  cd $argv; ll; printf "\n"; pwd;
end

# Recursively search subdirectories for the input string.
function tgre
  grep -ir $argv *;
end

# Recursively search files in subdirectories for the input string; Case insensitive and excluding common large directories.
function tgrex
  grep -iIrF $argv * --exclude-dir log --exclude-dir tmp --exclude-dir _site --exclude-dir vendor --exclude-dir node_modules --exclude-dir wp-includes --exclude-dir public --exclude-dir indexAndLandingPublic --exclude-dir landingPagePublic;
end


alias tgres="tgrex" #tgres is easier to type on a QWERTY keyboars

# Run tgres but Output just the filename. Useful for piping to other commands such as "open"
function ltgres
  tgres $argv -l
end

# Run tgres but Output just the filename. Useful for piping to other commands such as "open"
function oltgres
  ltgres $argv |xargs open
end

# Same as above, but quicker to type after running "tgres".
function otgres
  tgres -l $argv |xargs open ;
end

# Open files returned from "tgre".
function otgre
 tgre -l $argv |xargs open;
end

# Recursively search subdirectories for a filename containing the input string; Case insensitive and excluding common large directories.
function tfind
  find . -iname "*$argv*" -not -path "./vendor/*";
end

# Open the result from tfind.
function otfind
 tfind "$argv"  |xargs open ;
end


function dhikr
  set n $argv[1]

  if test -z $n
    set n 3
  end


  for x in (seq $n)
    echo "allah hu"
    say "Ul-lar  Hu" -r (math "((40 * $x) % 350)+ 200")
  end

end

function dhikr2
  set n $argv[1]

  if test -z $n
    set n 3
  end


  for x in (seq $n)
    # echo "Astagz - Astaghfirullah -  أَسْتَغْفِرُ اللّٰهَ‎ "
    echo " أَسْتَغْفِرُ اللّٰهَ‎ "
    say "astarg-fur lar" -r (math "((40 * $x) % 350)+ 200")
  end

end


# Photogaphy helpers:
# =============================================

# flattens all the subfolders into the current folder.
alias flatten="find . -mindepth 2 -type f -exec mv -i '{}' . ';'"

# Flattens a folder that may have subfolders containing pictures, then separates all the RAW files into a folder called RAWs
alias picFlow_flatten_mv_raw="flatten; mkdir RAWs; ls *.ARW | xargs -I \"\{\}\" mv \"\{\}\" RAWs/"
alias tPhotoFlow="picFlow_flatten_mv_raw"

# Copy all the Raw files out of the RAWs folder.
alias copyRaws="ls *.{JPG,jpg} | sed 's/...\$/ARW/' | xargs -I '{}' mv 'RAWs/{}' '{}'"

# Once files have been separated into JPEGs and a subfolder of RAWs one might delete some of the JPEGs that are bad.
# This then deletes the corresponding RAW files.
alias deleteNonMatchedRAWs="copyRaws; trash RAWs/ ; tPhotoFlow; echo 'Done. RAWs without corresponding JPEG (or jpeg) have been moved to the trash (and can be recovered from there).'"

# Rename the light room exports - for files that were imported from light room
alias sonyRename="tfind "ORG_"  | sed 's/^......//' | xargs -I '\{\}' mv 'ORG_\{\}' '\{\}'"


# =============================================

# Print the current local IP address - appends port 3000 as Rails servers are normally hosted there - and copies the resulting string to the clipboard
alias tip="ipconfig getifaddr en0| awk '{print \"http:\/\/\" \$1 \":3000/\"}'|pbcopy;pbpaste;echo \"[Copied to clipboard]\""

# Prints the fish logo- NOW IN COLOUR.
function logo
    echo '                 '(set_color F00)'___
  ___======____='(set_color FF7F00)'-'(set_color FF0)'-'(set_color FF7F00)'-='(set_color F00)')
/T            \_'(set_color FF0)'--='(set_color FF7F00)'=='(set_color F00)')
[ \ '(set_color FF7F00)'('(set_color FF0)'0'(set_color FF7F00)')   '(set_color F00)'\~    \_'(set_color FF0)'-='(set_color FF7F00)'='(set_color F00)')
 \      / )J'(set_color FF7F00)'~~    \\'(set_color FF0)'-='(set_color F00)')
  \\\\___/  )JJ'(set_color FF7F00)'~'(set_color FF0)'~~   '(set_color F00)'\)
   \_____/JJJ'(set_color FF7F00)'~~'(set_color FF0)'~~    '(set_color F00)'\\
   '(set_color FF7F00)'/ '(set_color FF0)'\  '(set_color FF0)', \\'(set_color F00)'J'(set_color FF7F00)'~~~'(set_color FF0)'~~     '(set_color FF7F00)'\\
  (-'(set_color FF0)'\)'(set_color F00)'\='(set_color FF7F00)'|'(set_color FF0)'\\\\\\'(set_color FF7F00)'~~'(set_color FF0)'~~       '(set_color FF7F00)'L_'(set_color FF0)'_
  '(set_color FF7F00)'('(set_color F00)'\\'(set_color FF7F00)'\\)  ('(set_color FF0)'\\'(set_color FF7F00)'\\\)'(set_color F00)'_           '(set_color FF0)'\=='(set_color FF7F00)'__
   '(set_color F00)'\V    '(set_color FF7F00)'\\\\'(set_color F00)'\) =='(set_color FF7F00)'=_____   '(set_color FF0)'\\\\\\\\'(set_color FF7F00)'\\\\
          '(set_color F00)'\V)     \_) '(set_color FF7F00)'\\\\'(set_color FF0)'\\\\JJ\\'(set_color FF7F00)'J\)
                      '(set_color F00)'/'(set_color FF7F00)'J'(set_color FF0)'\\'(set_color FF7F00)'J'(set_color F00)'T\\'(set_color FF7F00)'JJJ'(set_color F00)'J)
                      (J'(set_color FF7F00)'JJ'(set_color F00)'| \UUU)
                       (UU)'(set_color normal)
end

# Run a git command but using "less".
# Default pager on my machine is cat - outputs the whole diff.
# This runs the desired git command but using "less"
# so that large files can be scrolled and searched through easily in terminal
function lgit
# set -x GIT_PAGER less -+X;
# set -x GIT_PAGER less -+F -+X;

  git config --global --replace-all core.pager "less -+F -+X "

  git $argv;

# set -x GIT_PAGER cat;
  git config --global --replace-all core.pager "cat"

end

# Create a file and then open it. Can optionally specify an app to open the file with
function otouch --argument file app

 if test -z $file
  return
 end

 touch $file;

 if test -z $app
  open $file
  return
 end

 open -a $app $file

end


# https://superuser.com/questions/719531/what-is-the-equivalent-of-bashs-and-in-the-fish-shell
function bind_bang
    switch (commandline -t)[-1]
        case "!"
            commandline -t $history[1]; commandline -f repaint
        case "*"
            commandline -i !
    end
end

function bind_dollar
    switch (commandline -t)[-1]
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

function fish_user_key_bindings
    bind ! bind_bang
    bind '$' bind_dollar
end


# Useful for pretty-printing a succint git-log - one entry per line, colour coded with user-commit and time.
alias gitloglong="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit -n"


# Set default editor as Emacs
set -Ux EDITOR emacs


#CONFIG FOR PATH STUFF
#set -x PATH $PATH /usr/local/Cellar/qt@5.5/5.5.1_1/bin
set -x PATH $PATH /Users/tawfiq/anaconda3/bin/

# Rbenv stuff - needed for gems/bundler
status --is-interactive; and source (rbenv init -|psub)
