function add_color () {
   # As seen on https://unix.stackexchange.com/questions/25319/256-colour-prompt-in-zsh
   LB="%{%F{74}%}$LB%{$reset_color%}"
   RB="%{%F{74}%}$RB%{$reset_color%}"
   AT="%{%F{197}%}$AT%{$reset_color%}"
   LUB="%{%F{255}%}$LUB%{$reset_color%}"
   LDB="%{%F{255}%}$LDB%{$reset_color%}"
   RUB="%{%F{255}%}$RUB%{$reset_color%}"
   RDB="%{%F{255}%}$RDB%{$reset_color%}"
   DASH="%{%F{255}%}$DASH%{$reset_color%}"
   CHECK="%{%F{118}%}$CHECK%{$reset_color%}"
   CROSS="%{%F{196}%}$CROSS%{$reset_color%}"
   RARROW="%{%F{255}%}$RARROW%{$reset_color%}"
   LARROW="%{%F{255}%}$LARROW%{$reset_color%}"
}

function set_prompt () {
   local success=$(print -rP "%?")
   if [[ $success -eq 0 ]]; then
      success="$CHECK"
   else
      success="$CROSS"
   fi
   PS1="$(print "$LDB$DASH$LB%!$RB$DASH$LB$success$RB$DASH$RARROW ")"
   RPS1="$(print "$LARROW$DASH$LB%*$RB$DASH$RDB")"
   local dir_path="$LB%~$RB"
   local files_current_dir="$LB$(ls -l | wc -l) files$RB"
   local user_host="$LB%{%F{118}%}%n%{$reset_color%}$AT%m$RB$DASH$RUB"
   local left_prompt="$LUB$DASH$dir_path$DASH$files_current_dir"
   local right_prompt="$user_host"
   local dummy_prompt="$(print -r  "$left_prompt$right_prompt" | sed -r 's/(\\[0-9]{3}){3}/X/g')" # Substitute octal chars for X
   dummy_prompt="$(echo "$dummy_prompt" | sed -r 's/%\{%F\{[0-9]{1,3}\}%\}//g')"                  # Remove zsh color codes
   dummy_prompt="$(echo "$dummy_prompt" | tr -dc '[:print:]')"                                    # Remove non-printable characters
   dummy_prompt="$(echo "$dummy_prompt" | sed -r 's/%\{\[([0-9]{2})m%\}//g')"                     # Remove $reset_color pattern %{[00m%}
   dummy_prompt="$(print -P "$dummy_prompt")"
   local length=${#dummy_prompt}
   local width=$(tput cols)
   (( width = $width - $length - 1 ))
   local fill=''
   for hyphen in {1..$width}; do
      fill="$fill$DASH"
   done
   print ''
   #print -a $dummy_prompt
   print -P "$left_prompt$fill$right_prompt"
}

function chpwd () {

}

function precmd () {
   set_prompt
}

function preexec () {

}

function postexec () {

}
