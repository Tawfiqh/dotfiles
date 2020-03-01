
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

# Moves all the video files into a Films folder - can probable do this with && so that it only runs in mp4 files are found.
alias picFlow_flatten_mv_films="set -l filmFiles *.{MP4,mp4}; test  -n \"\$filmFiles\" ;and mkdir Films; and ls *.{MP4,mp4}| xargs -I \"\{\}\" mv \"\{\}\" Films/"


alias tPhotoFlow="picFlow_flatten_mv_raw;picFlow_flatten_mv_films"

# Copy all the Raw files out of the RAWs folder.
alias copyRaws="ls *.{JPG,jpg} | sed 's/...\$/ARW/' | xargs -I '{}' mv 'RAWs/{}' '{}'"

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
  ffmpeg -i $argv[1] -c:v libx265 -crf 63 -c:a aac -b:a 128k -tag:v hvc1 $filename_iphone.mp4
#ffmpeg -i input.avi -c:v libx265 -crf 28 -c:a aac -b:a 128k -tag:v hvc1 output.mp4
#https://aaronk.me/ffmpeg-hevc-apple-devices/

end


# This  one works
# ffmpeg -i C0029.MP4 -vcodec libx264 _C0029.MP4
# And can then open in Quicktime and export as HEVC to send to iPhone

function convertVideoToiPhone
    ffmpeg -i $argv[1] -vcodec libx264 iphone_$argv[1]
end

function removeVideoSound
    ffmpeg -i $argv[1] -c copy -an nosound_$argv[1]
end

# Convert video to frame grabs:
# ffmpeg -ss 03:00 -i C0037.MP4 -r 2 output-%04d.jpeg
# -ss is start time
# r is the framerate-fps. so 2 means 1 frame every 0.5s. 
function grabFrames

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

# Set textEdit to open new-file instead of "open window" on launch.
#defaults write -g NSShowAppCentricOpenPanelInsteadOfUntitledFile -bool false

#CONFIG FOR PATH STUFF
#set -x PATH $PATH /usr/local/Cellar/qt@5.5/5.5.1_1/bin
set -x PATH $PATH /Users/tawfiq/anaconda3/bin/

# Rbenv stuff - needed for gems/bundler
status --is-interactive; and source (rbenv init -|psub)
