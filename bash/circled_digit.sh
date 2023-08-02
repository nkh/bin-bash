#!/bin/bash
circled_digit() {
  circled_digits='⓪①②③④⑤⑥⑦⑧⑨⑩⑪⑫⑬⑭⑮⑯⑰⑱⑲⑳'
  if [ $1 -lt 20 ] 2>/dev/null ; then
    printf '%b' "${circled_digits:$1:1}\n"
  else
    printf '%b' "Must give a number between 0 and 20. Not '$1'\n"
  fi
}

circled_digit $1

