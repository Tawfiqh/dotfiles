
alias ll="ls -Gap"
alias lll="ls -loGaprt"

# Start Jupyter notebooks with the i/o limit set high.
alias tjupyter="jupyter notebook --NotebookApp.iopub_data_rate_limit=10000000000"
alias jupyterNotebook="tjupyter"

alias bbedit="open -a bbedit"
alias xcode="open -a Xcode"

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


function foreverWait
  while sleep 3
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
  grep -iIrF $argv * --exclude-dir log --exclude-dir tmp --exclude-dir _site --exclude-dir vendor --exclude-dir node_modules --exclude-dir wp-includes --exclude-dir public --exclude-dir indexAndLandingPublic --exclude-dir landingPagePublic --exclude-dir .git --exclude-dir build --exclude-dir bower_components;
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
  set app $argv[2]

  if test -n $app
    tfind "$argv[1]"  |xargs open -a $app ;
    return;
  end
  
 tfind "$argv[1]"  |xargs open ;
 
end

# =============================================
# Polymer / smartViz scripts

function smartviz_start
  
  # 1. Start the frontend
  echo "starting smartviz_frontend"
  cd ~/Documents/Projects_BuroHappold/smartviz-dashboard-frontend/;
  polymer serve & #This then runs in the background so that the backend can start.

  
  
  # 2.Start the backend
  echo "starting smartviz_backend"
  cd ~/Documents/Projects_BuroHappold/smartviz_backend_django/;
  pipenv run ./start.sh # This will stay running in the foreground. Won't proceed to the next line unless the user interrupts


  # If we get here then there was a user interrupt.
  echo "closing smartviz_backend"

  # We pull polymer serve, back into the foreground.
  fg #Brings it back to the foreground;

  # user interrupts again and we can close the program
  echo "closing smartviz_frontend"
  

end

# =============================================

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
alias picFlow_flatten_mv_jpg="flatten; mkdir JPGs; ls *.JPG | xargs -I \"\{\}\" mv \"\{\}\" JPGs/"

# Moves all the video files into a Films folder - can probable do this with && so that it only runs in mp4 files are found.
function picFlow_flatten_mv_films
  set -l filmFiles *.{MP4,mp4,MOV,mov};
  test  -n "$filmFiles" ;and mkdir Films;
  test  -n "$filmFiles" ;and ls *.{MP4,mp4,MOV,mov}| xargs -I "{}" mv "{}" Films/
end


# Moves all HEIC the video files into a Films folder - can probable do this with && so that it only runs in mp4 files \
function picFlow_flatten_mv_heic
  set -l heicFiles *.{HEIC,heic};
  test  -n "$heicFiles" ;and mkdir HEIC_iPhone;
  test  -n "$heicFiles" ;and ls *.{HEIC,heic}| xargs -I "{}" mv "{}" HEIC_iPhone/
end


alias tPhotoFlow="picFlow_flatten_mv_raw;picFlow_flatten_mv_films;picFlow_flatten_mv_heic"

alias tPhotoFlowJPEG="picFlow_flatten_mv_jpg;picFlow_flatten_mv_films;copyJPGs; echo 'JPEGs that don\'t have an accompanying RAW/ARW are now in the folder JPGs.'"


# Copy all the Raw files out of the RAWs folder.
alias copyRaws="ls *.{JPG,jpg} | sed 's/...\$/ARW/' | xargs -I '{}' mv 'RAWs/{}' '{}'"
alias copyJPGs="ls *.ARW | sed 's/...\$/JPG/' | xargs -I '{}' mv 'JPGs/{}' '{}'"

# Once files have been separated into JPEGs and a subfolder of RAWs one might delete some of the JPEGs that are bad.
# This then deletes the corresponding RAW files.
alias deleteNonMatchedRAWs="copyRaws; trash RAWs/ ; tPhotoFlow; echo 'Done. RAWs without corresponding JPEG (or jpeg) have been moved to the trash (and can be recovered from there).'"

# Rename the light room exports - for files that were imported from light room mobile
alias sonyRename="tfind "ORG_"  | sed 's/^......//' | xargs -I '\{\}' mv 'ORG_\{\}' '\{\}'"

alias removeXMP="ls *.xmp | xargs rm"

function renameWithPrefix

   set -l 1 $argv[1]
   ls *.{JPG,jpg,ARW} |  xargs -I '{}' mv '{}' "$1{}"
end

# Should adjust to use an argument as a prefix and defaults to "other_camera"
function renameToOtherCamera

  for fileFound in (ls *.{JPG,jpg,ARW,arw})
    set file2 (echo $fileFound | sed 's/^/other_camera_/')
    echo mv $fileFound $file2
    mv $fileFound $file2
  end

end

function removeEditedSecondNames

  # Get all files that are -2 duplicates
  for fileFound in (ls *-2.jpg)
    # Get rid of the -2 from the filename
    set file2 (echo $fileFound | sed 's/-2//g')

    # Useful output for debugging and seeing what's going on.
    echo mv $fileFound $file2

    # Move the newer "ABCD-2.jpg" to replace the original "ABCD.jpg"
    mv $fileFound $file2
  end

end


function removeEditedThirdNames

  # Get all files that are -2 duplicates                                                                                                                 
  for fileFound in (ls *-3.jpg)
    # Get rid of the -3 from the filename                                                                                                                
    set file2 (echo $fileFound | sed 's/-3//g')

    # Useful output for debugging and seeing what's going on.                                                                                            
    echo mv $fileFound $file2

    # Move the newer "ABCD-3.jpg" to replace the original "ABCD.jpg"                                                                                     
    mv $fileFound $file2
  end

end





alias safariHistoryTimes="cp  ~/Library/Safari/History.db ./; sqlite3 History.db \"select datetime(visit_time+978307200, 'unixepoch', 'localtime') ,title from history_visits order by visit_time desc;\" | head -n 1000"

# =============================================
# FFMPEG Helpers

# Encode a Video Sequence for the iPod/iPhone
# You can easily convert a video for iPhones and older iPods using this command:
# $ ffmpeg -i source_video.avi input -acodec aac -ab 128kb -vcodec mpeg4 -b 1200kb -mbd 2 -flags +4mv+trell -aic 2 -cmp 2 -subcmp 2 -s 320x180 -title X final_video.mp4

function convertVideoToiPhone2

#  ffmpeg -i $argv[1] input -acodec aac -ab 128kb -vcodec mpeg4 -b 1200kb -mbd 2 -flags +4mv+trell -aic 2 -cmp 2 -subcmp 2 -s 320x180 -title X iphone_$argv[1].mp4
#  ffmpeg -i $argv[1] -acodec aac -ab 128kb -vcodec mpeg4 -mbd 2 -flags +4mv+trell  -cmp 2 -subcmp 2 -s 320x180 iphone_output.mp4
#  ffmpeg -i $argv[1] -acodec aac -ab 128kb -vcodec mpeg4 -mbd 2 -flags +4mv+trell  -cmp 2 -subcmp 2 -s 320x180 iphone_output.mp4
  set fileName (echo $argv[1] | cut -d. -f1)
  ffmpeg -i $argv[1] -c:v libx265 -crf 63 -c:a aac -b:a 128k -tag:v hvc1 iphone_$argv[1]
#ffmpeg -i input.avi -c:v libx265 -crf 28 -c:a aac -b:a 128k -tag:v hvc1 output.mp4
#https://aaronk.me/ffmpeg-hevc-apple-devices/
end


# This  one works
# ffmpeg -i C0029.MP4 -vcodec libx264 _C0029.MP4
# And can then open in Quicktime and export as HEVC to send to iPhone

function convertVideoToiPhone
    ffmpeg -i $argv[1] -vcodec libx264 iphone_$argv[1]
    echo "Export complete. Now open it in quicktime and re-export 🙄 . Not ideal, but it works 🤷‍♀️"
end

function removeVideoSound
    ffmpeg -i $argv[1] -c copy -an nosound_$argv[1]
end

# Convert video to frame grabs:
# ffmpeg -ss 03:00 -i C0037.MP4 -r 2 output-%04d.jpeg
# -ss is start time
# r is the framerate-fps. so 2 means 1 frame every 0.5s. 
function grabFrames

    # $argv[1] = filename
    # $arfv[2] = start_time (optional)
    # $arfv[3] = duration (optional)
    # $arfv[4] = fps (optional)
	    

    if test -z $argv[1]
      echo "filename needed"
      return
    end

    set start $argv[2]
    test -z "$start";and set start "00:00"

    set duration $argv[3]
    if not test -z "$duration"
        ffmpeg -ss $start -t $duration -i $argv[1] -r 2 $argv[1]_output-%04d.jpeg
       	return
    end

    set fps $argv[4]
    test -z "$fps";and set fps "2"


    ffmpeg -ss $start -i $argv[1] -r $fps $argv[1]_still_%04d.jpeg

end




#slow down audio:
# ffmpeg -i shuaib.ogg  -filter:a "atempo=0.5" -vn slow_shuaib.mp3




# =============================================

# Youtube DL


alias youtube-dl-audio="youtube-dl -f 'bestaudio[ext=m4a]'"

# =============================================

#Raspberry - Pi
# ssh pi@raspberrypi2.local

alias rpi="forever 'ssh -o ConnectTimeout=1 pi@raspberrypi2.local' "

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


# copy the permissions from file1 to file2.
#chmod (stat -f %A file1) file2

# Useful for pretty-printing a succint git-log - one entry per line, colour coded with user-commit and time.
alias gitloglong="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit -n"

#Log ALL even if the commits aren't on a branch - i.e they're detached but not garbage collected yet. 
alias gitlogall="git log --graph --decorate (git rev-list -g --all) -n"


# Set default editor as Emacs
set -Ux EDITOR emacs

# Set textEdit to open new-file instead of "open window" on launch.
#defaults write -g NSShowAppCentricOpenPanelInsteadOfUntitledFile -bool false

#CONFIG FOR PATH STUFF
#set -x PATH $PATH /usr/local/Cellar/qt@5.5/5.5.1_1/bin
set -x PATH $PATH /Users/tawfiq/anaconda3/bin/

#function export
#    if [ $argv ] 
#        set var (echo $argv | cut -f1 -d=)
#        set val (echo $argv | cut -f2 -d=)
#        set -g -x $var $val
#    else
#        echo 'export var=value'
#    end
#end

#export LDFLAGS="/usr/local/opt/openssl@1.1/lib"
#export CPPFLAGS="/usr/local/opt/openssl@1.1/include"

set -x PATH $PATH /usr/local/opt/openssl@1.1/bin


# OpenSSL stuff needed for pipenv and mysql.
set -x LDFLAGS -L/usr/local/opt/openssl@1.1/lib
set -x CPPFLAGS -I/usr/local/opt/openssl@1.1/include


# Rbenv stuff - needed for gems/bundler
status --is-interactive; and source (rbenv init -|psub)

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# eval /Users/tawfiq/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

