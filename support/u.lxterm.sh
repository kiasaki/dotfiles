#!/bin/sh
color00="1f/1f/21" # Black
color01="cc/66/66" # Red
color02="b5/bd/68" # Green
color03="f0/c6/74" # Yellow
color04="81/a2/be" # Blue
color05="b2/94/bb" # Magenta
color06="8a/be/b7" # Cyan
color07="c5/c8/c6" # White
color08="96/98/96" # Bright Black
color09="cc/66/66" # Red
color10="b5/bd/68" # Green
color11="f0/c6/74" # Yellow
color12="81/a2/be" # Blue
color13="b2/94/bb" # Magenta
color14="8a/be/b7" # Cyan
color15="ff/ff/ff" # White
color_foreground="37/3b/41"
color_background="ff/ff/ff"
color_cursor="37/3b/41"

if [ -n "$TMUX" ]; then
  # tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  printf_template="\033Ptmux;\033\033]4;%d;rgb:%s\007\033\\"
  printf_template_var="\033Ptmux;\033\033]%d;rgb:%s\007\033\\"
  printf_template_custom="\033Ptmux;\033\033]%s%s\007\033\\"
elif [ "${TERM%%-*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  printf_template="\033P\033]4;%d;rgb:%s\007\033\\"
  printf_template_var="\033P\033]%d;rgb:%s\007\033\\"
  printf_template_custom="\033P\033]%s%s\007\033\\"
else
  printf_template="\033]4;%d;rgb:%s\033\\"
  printf_template_var="\033]%d;rgb:%s\033\\"
  printf_template_custom="\033]%s%s\033\\"
fi

# 16 color space
printf $printf_template 0  $color00
printf $printf_template 1  $color01
printf $printf_template 2  $color02
printf $printf_template 3  $color03
printf $printf_template 4  $color04
printf $printf_template 5  $color05
printf $printf_template 6  $color06
printf $printf_template 7  $color07
printf $printf_template 8  $color08
printf $printf_template 9  $color09
printf $printf_template 10 $color10
printf $printf_template 11 $color11
printf $printf_template 12 $color12
printf $printf_template 13 $color13
printf $printf_template 14 $color14
printf $printf_template 15 $color15

# foreground / background / cursor color
printf $printf_template_var 10 $color_foreground
printf $printf_template_var 11 $color_background
printf $printf_template_var 12 $color_cursor

# clean up
unset printf_template
unset printf_template_var
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
unset color_foreground
unset color_background
unset color_cursor
