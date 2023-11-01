for theme in light dark; do
  for orientation in portrait landscape; do
    for style in blank grid lines dotted; do
      theme=$theme orientation=$orientation style=$style bash generate-template.sh
    done
  done
done
