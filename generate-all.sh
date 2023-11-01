for theme in light dark; do
  for orientation in portrait landscape; do
    for style in blank grid lines; do
      theme=$theme orientation=$orientation style=$style bash generate.sh
    done
  done
done
