#!/bin/bash

### CONFIGURATION START ###

format="${format:-jpg}"

orientation="${orientation:-portrait}"
portrait_width=595
portrait_height=842
landscape_width=842
landscape_height=595

theme="${theme:-light}"
theme_light_bg_color="#FFFFFF"
theme_light_pattern_color="#EEEEEE"
theme_dark_bg_color="#1C1C1C"
theme_dark_pattern_color="#636363"

style="${style:-blank}"
pattern_spacing=15
dot_size=1

### CONFIGURATION END ###

width=$portrait_width
height=$portrait_height
if [ $orientation == "landscape" ]; then
  width=$landscape_width
  height=$landscape_height
fi

bg_color=$theme_light_bg_color
pattern_color=$theme_light_pattern_color
if [ $theme == "dark" ]; then
  bg_color=$theme_dark_bg_color
  pattern_color=$theme_dark_pattern_color
fi

name="template-$theme-$orientation-$style"

convert -size ${width}x${height} xc:$bg_color $name.$format

if [ $style == "grid" ] || [ $style == "lines" ]; then
  for ((i=$pattern_spacing; i<$height; i+=$pattern_spacing)); do
      convert $name.$format -stroke $pattern_color -strokewidth 1 -draw "line 0,$i $width,$i" $name.$format
  done
fi 

if [ $style == "grid" ]; then
  for ((i=$pattern_spacing; i<$width; i+=$pattern_spacing)); do
      convert $name.$format -stroke $pattern_color -strokewidth 1 -draw "line $i,0 $i,$height" $name.$format
  done
fi

if [ $style == "dotted" ]; then
  draw_commands=""
  for ((i=$pattern_spacing; i<$height; i+=$pattern_spacing)); do
      for ((j=$pattern_spacing; j<$width; j+=$pattern_spacing)); do
          draw_commands="${draw_commands} fill $pattern_color circle $j,$i $(($j+$dot_size)),$i"
      done
  done
  convert $name.$format -fill "$pattern_color" -draw "$draw_commands" $name.$format
fi

