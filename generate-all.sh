#!/bin/bash

format=${format:-jpg}

themes="light dark"
orientations="portrait landscape"
styles="blank lines grid dotted"

for theme in $themes; do
  for orientation in $orientations; do
    for style in $styles; do
      filename="template-$theme-$orientation-$style"
      filename=$filename format=$format theme=$theme orientation=$orientation style=$style bash note-template-generator.sh
    done
  done
done
