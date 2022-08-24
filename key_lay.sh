#!/bin/bash

function get_cur_lang {
  en="00000000"
  ru="00001000"
  xset -q | grep -A 0 'LED' | cut -c59-67 > lang
  r=$(cat lang)

  if [ "$r" == "$ru" ]
  then
    cur_lang=$ru
  elif [ "$r" == "$en" ]
  then
    cur_lang=$en
  fi
}

function check_lang {
  while :
  do
    xset -q | grep -A 0 'LED' | cut -c59-67 > lang
    sleep .3
    t=$(cat lang)
    if [ "$t" == "$ru" ] && [ "$cur_lang" == "$en" ]
    then
      mpg321 ru.mp3
      cur_lang=$ru
    elif [ "$t" == "$en" ] && [ "$cur_lang" == "$ru" ]
    then
      mpg321 en.mp3
      cur_lang=$en
    fi
  done
}

get_cur_lang
check_lang
