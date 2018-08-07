alias ll="ls -Gap"

function cs
  cd $argv; ll; printf "\n"; pwd;
end

function tgre
  grep -ir $argv *;
end


function tgrex
  grep -iIrF $argv * --exclude-dir log --exclude-dir tmp --exclude-dir _site --exclude-dir vendor --exclude-dir node_modules;
end

alias tgres="tgrex" #tgres is easier to type on a QWERTY keyboars

function ltgres
  tgres $argv -l
end

function oltgres
  ltgres $argv |xargs open
end

function otgres
  tgres -l $argv |xargs open ;
end

function otgre
 tgre -l $argv |xargs open;
end

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
    echo "allah hu"
    say "Ul-lar  Hu" -r (math "((40 * $x) % 350)+ 200")
  end

end

alias tip="ipconfig getifaddr en1| awk '{print \"http:\/\/\" \$1 \":3000/\"}'|pbcopy;pbpaste;echo \"[Copied to clipboard]\""

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

alias gitloglong="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

set -Ux EDITOR emacs


#CONFIG FOR PATH STUFF
#set -x PATH $PATH /usr/local/Cellar/qt@5.5/5.5.1_1/bin


