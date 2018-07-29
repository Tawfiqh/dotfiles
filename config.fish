alias ll="ls -Gap"

alias lld="ls -d ./*/"

function gitpullprojects
  echo "Put a list of directories here to iterate through and run 'git pull'"
end


function cs
	 cd $argv; ll; printf "\n"; pwd;
end

function tgre
	 grep -ir $argv *;
end


function tgres
	 grep -iIrF $argv * --exclude-dir log --exclude-dir tmp --exclude-dir _site --exclude-dir node_modules --exclude-dir vendor;
end

function ltgres
	 tgres -l $argv
end

function oltgres
	 ltgres $argv |xargs open
end


alias otgres="oltgres"

function otgre
	 tgre -l $argv |xargs open;
end

alias otgrex="otgres"

function tfind
	 find . -iname "*$argv*";
end

function otfind
	 tfind "$argv" |xargs open ;
end

function dhikr
  set n $argv[1]

  if test -z $n
    set n 3
  end


  for x in (seq $n)
    say "Ul-lar  Hu" -r (math "((40 * $x) % 350)+ 200")
  end

end

alias tip="ipconfig getifaddr en1| awk '{print \"http:\/\/\" \$1 \":3000/\"}'|pbcopy;pbpaste;echo \"[Copied to clipboard]\""

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

set -Ux EDITOR emacs



#CONFIG FOR PATH STUFF

#set -x PATH $PATH /Users/Tawfiq/.rbenv/shims /Users/Tawfiq/.rbenv/  #To find where other ruby stuff is installed run `gem env`
#set -x PATH $PATH /usr/local/lib/ruby/gems/2.4.0 /Users/Tawfiq/.gem/ruby/ ~/.gem/ruby/2.0.0 rbenv global 2.3.0
#set -x PATH $PATH  /Library/Frameworks/Python.framework/Versions/3.5/bin

#Some QMake thing from QT5, required for Capybara
set -x PATH $PATH /usr/local/Cellar/qt@5.5/5.5.1_1/bin
#had to go to ./usr/local/Cellar and run:
# $ tfind qmake | grep "make\$"
#in order to find which bin folder to add to the path for QMake.


#Some rbenv thing
status --is-interactive; and source (rbenv init -|psub)
