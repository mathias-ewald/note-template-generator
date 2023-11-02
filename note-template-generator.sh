#!/bin/bash

### CONFIGURATION START ###

format="${format:-jpg}"
filename=${filename:-template}

dpi=300
scaling_factor=$(echo "$dpi / 72" | bc -l)

orientation="${orientation:-portrait}"
portrait_width=$(echo "8.27 * $dpi" | bc | cut -d'.' -f1)
portrait_height=$(echo "11.69 * $dpi" | bc | cut -d'.' -f1)
landscape_width=$portrait_height
landscape_height=$portrait_width


theme="${theme:-light}"
theme_light_bg_color="#FFFFFF"
theme_light_pattern_color="#EEEEEE"
theme_dark_bg_color="#000000"
theme_dark_pattern_color="#636363"

style="${style:-blank}"
pattern_spacing=$(echo "20 * $scaling_factor" | bc | cut -d'.' -f1)
pattern_stroke_width=$(echo "1 * $scaling_factor" | bc | cut -d'.' -f1)
dot_size=$(echo "1 * $scaling_factor" | bc | cut -d'.' -f1)


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

convert -size ${width}x${height} xc:$bg_color $filename.$format

if [ $style == "grid" ] || [ $style == "lines" ]; then
  draw_commands=""
  # horizontal lines
  for ((i=$pattern_spacing; i<$height; i+=$pattern_spacing)); do
      draw_commands="${draw_commands} line 0,$i $width,$i"
  done
  # vertical lines
  if [ $style == "grid" ]; then
    for ((i=$pattern_spacing; i<$width; i+=$pattern_spacing)); do
        draw_commands="${draw_commands} line $i,0 $i,$height"
    done
  fi
  convert $filename.$format -stroke $pattern_color -strokewidth $pattern_stroke_width -draw "$draw_commands" $filename.$format
fi 

if [ $style == "dotted" ]; then
  draw_commands=""
  for ((i=$pattern_spacing; i<$height; i+=$pattern_spacing)); do
      for ((j=$pattern_spacing; j<$width; j+=$pattern_spacing)); do
          draw_commands="${draw_commands} fill $pattern_color circle $j,$i $(($j+$dot_size)),$i"
      done
  done
  convert $filename.$format -fill "$pattern_color" -draw "$draw_commands" $filename.$format
fi

